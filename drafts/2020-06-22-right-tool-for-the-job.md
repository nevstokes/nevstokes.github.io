---
title: "The Right Tool for the Job"
date: 2020-07-01T11:32:16Z
summary: "If you're going to do something, it's worth taking the time to learn how to do it properly. In this post I'll run through some common mistakes and patterns for `bash` scripting."
tags: ["dev", "bash"]
---
{{< quote text="If my only tool is a hammer, then every problem is a nail." author="Sholem Asch" >}}

<!-- http://mywiki.wooledge.org/BashFAQ -->

Use cases:

For example, try not to use loops if possible -- pipe things through xargs, where you can often get the benefit of parallelism

No
	for VALUE in `<command>`; do <stuff>; done

Yes
<command> | xargs <stuff>

Can't always use xargs (built-ins)?

--no-run-if-empty

{{< hilite bash >}}
#!/usr/bin/env bash

which axel

if [ $? -ne 0 ]; then
    apt install axel
fi
{{< /hilite >}}

`which` is a actually remnent from `csh` -- it'll still work but it can misbehave. When you're using `bash` or want to be POSIX-compliant, use `command -v` and logical boolean operators instead of a conditional:

{{< hilite bash "linenos=false" >}}
echo -n "Checking for axel... " \
    && command -v axel || (echo "installing" && apt install axel)
{{< /hilite >}}

When is bash not bash? When it's dash. Make sure you're explicit in your shell

{{< hilite bash >}}
 #!/bin/env bash

for i in `df / /usr /boot /var /var/log --output=avail -m | grep -v Avail`; do \
    if [ $i -lt 250 ]; then \
        >&2 echo ERROR: server running out of space && exit 1;
    fi;
done
{{< /hilite >}}

Leaving the backtick syntax aside for the moment...

grep for Avail -- just happens to be the first line. No inbuilt option to not display this. Use the right tool for the job; in this case, sed 1d.

{{< hilite bash >}}
df / /usr /boot /var /var/log --output=file,avail -m \
    | sed 1d \
    | awk -v limit=250 \
        '{
            if (int($2) < limit) {
                print "ERROR:", $1, "running out of space" > "/dev/stderr";
                exit 1;
            }
        }'
{{< /hilite >}}

awk and sed work really well for text processing but in this case we can actually use awk directly:

{{< hilite bash >}}
df / /usr /boot /var /var/log --output=file,avail -m \
    | awk -v limit=250 \
    'NR > 1 {
        if (int($2) < limit) {
            print "ERROR:", $1, "running out of space" > "/dev/stderr";
            exit 1;
        }
    }'
{{< /hilite >}}

head & tail

Take the first / last rows of a file. Skip the first n lines.

grep

Search files for a pattern. (Cover -Po etc)

cut & awk

Split rows of a file

Can often render a seperate grep operation unessecary.

{{< hilite bash >}}
awk '/Test/ { print $1 }'
{{< /hilite >}}

tr & sed

Character replacement

sort, uniq & comm

`comm` is a cleaner diff.

jq

Unlike the others, not a core utility always required, in `aws ssm get-params` for example.

{{< hilite bash >}}
#!/usr/bin/env bash

while read key value; do
    export $(printf "%s=%s" $(basename ${key^^}) ${value})
done < <(aws ssm get-parameters-by-path \
    --path /path/to/values \
    --query "Parameters[*].{Name:Name,Value:Value}" \
    --output=text)
{{< /hilite >}}

There's a bit to unpack here. Using Parameter expansion, process and command substitutions.

{{< hilite bash >}}
#!/usr/bin/env bash

while read key value; do
    export $(printf "%s=%s" $({{< note >}}basename{{< /note >}} {{< note >}}${key^^}{{< /note >}}) ${value})
done < <(aws ssm get-parameters \
    --names {{< note >}}/list/of/{parameters,values}{{< /note >}} \
    --query "Parameters[*].{Name:Name,Value:Value}" \
    --output=text)
{{< /hilite >}}

1. `basename` will strip the leading path information, leaving only the variable name.
1. This is `bash` parameter expansion which converts the variable to uppercase.
1. Shorthand notation for multiple values, similar to `bash` brace expansion.

## Substitutions

In short, these are powerful tools, highly optimised for specific use cases.

You may have seen me referencing this article before.

It's well worth spending some time to really get to know the command line. https://www.shellcheck.net/
https://explainshell.com/
