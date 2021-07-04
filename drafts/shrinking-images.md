---
title: "Shrinking Images"
date: 2020-09-12T20:10:13Z
summary: "The lightweight nature of containers can all too often be betrayed by images that run to the hundreds of megabytes -- if not a couple of gigabytes -- in size. Thankfully there are ways to control this."
tags: ["images","containers","dev"]
---
{{< quote text="Harder, Better, Faster, Stronger" author="Daft Punk" >}}

Okay, so you have a custom built image. How can you make it even smaller?

Remove what we don't need. A multistage build flips that question on its head -- it becomes more a question about what you want to keep.

To start a new stage, all we have to do is start with a new `FROM` statement.

To make things easier to keep track, we can go back and give the previous stage a name.

Remember `upx` we added in our build utility image? We'll need that again. Unpack the binary, query its dependencies, and pack it again.

We can't query a packed binary; ELF information stripped. Thankfully, not a one-way process.

Use an undocumented flag to squeeze the binary as small as we can.

{{< hilite docker "linenos=false" >}}
RUN upx -9 --lzvm /usr/sbin/nginx
{{< /hilite >}}

That's a good start.

Harden this we can use `apk` to remove itself and its public keys, along with the utilities -- including `upx` that we no longer need.

{{< hilite docker "linenos=false" >}}
RUN apk del --purge \
      alpine-keys \
      apk-tools \
      libc-utils \
      musl-utils \
      scanelf \
      upx
{{< /hilite >}}

We've already used multistage technique. We can use it again.

Alpine is based on Busybox. More specifically a `musl` variant.

We can quite easily copy our built binary across.

The problem comes when we try and copy across those shared libraries that were installed in the final stage after interrogating the binary with `scanelf`.

The file that we're told we need isn't actually a file -- it's called a _soname_ and it usually references a symbolic link that points to the actual library. This major / minor naming scheme is a libtool convention and, like semantic versioning of an API, is intended to indicate version compatability for dynamic linking of the <acronym title="Application Binary Interface">ABI</acronym> to simplify maintainance and upgrades.

soname for libc is libc.so.6: where lib is the prefix, c is a descriptive name, so means shared object, and 6 is version.

You might think we could copy *.so from `/lib` and `/usr/lib`. We _could_ -- but copying symlinks across build stages duplicates the underlying shared library and inflates image size; the exact opposite of what we're trying to do here.

What we really want to do is copy what's described in the soname by effectively resolving the symlink.





https://www.ibm.com/developerworks/linux/library/l-shlibs/index.html#N1006F
https://www.tecmint.com/understanding-shared-libraries-in-linux/


This is a bit of a special case, as libc naming history.

{{< hilite bash >}}
rm /lib/libc.musl-x86_64.so.1
{{< /hilite >}}


Harden symolic links to shared libraries and remove original files (if they're in the same directory)

{{< hilite bash >}}
find {{< note >}}/lib /usr/lib{{</ note >}} -name lib{{< note >}}*.so.*{{</ note >}} {{< note >}}-type l{{</ note >}} \
| xargs {{< note >}}-I {}{{</ note >}} sh -c 'TARGET=$({{< note >}}readlink -f {}){{< /note >}} \
&& [ "$(dirname ${TARGET})" {{< note >}}=={{</ note >}} "$(realpath $(dirname {}))" ] \
&& mv ${TARGET} {}; \
{{< note >}}(true){{< /note >}}'
{{< /hilite >}}

1. Only search in these directories
1. Shared objects match this pattern.
1. Make sure we only find symbolic links
1. Define a placeholder to allow us to reference the files we find.
1. Resolve the symbolic link.
1. We only want to replace files that are in the same directory as the symlink.
1. If the test fails this prevents the whole operation from failing.

Remove duplicate shared libraries

{{< hilite bash >}}
find /lib /usr/lib -name lib*.so.* -type f \
| xargs {{< note >}}--max-args=1{{< /note >}} basename \
| {{< note >}}sort{{< /note >}} | uniq {{< note >}}-d{{< /note >}} | \
xargs -I {} rm /usr/lib/{}
{{</ hilite >}}

1. Take a single argument at most.
1. `uniq` only works with a sorted list.
1. The `-d` flag counts duplicates.

Clean up any dangling symlinks

{{< hilite bash >}}
find /lib /usr/lib -type l -exec test {{< note >}}!{{< /note >}} {{< note >}}-e {}{{< /note >}} \; -delete
{{</ hilite >}}

1. The `!` is used to negate -- either in the test or before `-exec` to negate the find command itself.
1. Test that the file exists -- or, in this case, if the symlink resolves.


Now, in a fresh stage, we can copy shared libraries with a wildcard pattern.


Python images onto an Ubuntu base. There is a `glibc` variant of Busybox too.






Only time we're going to change will be an image rebuild


There are a few tools we can use

{{< hilite bash "linenos=false" >}}
objdump -p /lib/libz.so.1.2.11  | grep SONAME
  SONAME               libz.so.1
{{< /hilite >}}

{{< hilite bash "linenos=false" >}}
scanelf --soname /lib/libz.so.1.2.11
 TYPE   SONAME FILE
ET_DYN libz.so.1 /lib/libz.so.1.2.11
{{< /hilite >}}

Can also use `scanelf` or `ldd` to query dependencies. (`ldd` will break if those dependencies aren't available.)

{{< hilite bash "linenos=false" >}}
scanelf --nobanner --needed /usr/sbin/nginx | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }'
{{< /hilite >}}

{{< hilite bash "linenos=false" >}}
{{< note >}}ldd{{< /note >}} /lib/libtls.so.16.0.1 | grep = | awk '{ print $1 }'
{{< /hilite >}}

1. `ldd` stands for "list dynamic dependencies".
