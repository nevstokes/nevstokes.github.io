---
title: "Image Building"
date: 2020-09-12T14:10:13Z
summary: "There's little doubt in my mind about what technology has had the biggest impact on the industry over the past several years. That same thing has become the atomic unit of deployment: the container."
tags: ["images","containers","dev"]
---
{{< quote text="And they're all made out of ticky-tacky, and they all look just the same." author="<cite>Little Boxes</cite>, Malvina Reynolds" >}}

Containerisation -- that is to say process isolation via cgroups and namespaces -- is a concept that goes back quite a bit further but [Docker](https://docker.com) certainly popularised the idea and drove the recent mass adoption.

I'm going to pull this next bit out to highlight it because it's important:

> Docker is an eponymous container runtime implementation from one particular company -- it is not a technology in itself.

With my developer hat on, having a single consistent artefact that can be used efficiently throughout the development process and that can also be released to production delivers the parity that has long been sought after.

Having that delivered in an ephemeral, self-contained, and immutable manner offers some benefits for security too but this is a deceptively complex thing to get right.

I'm assuming a fair amount of familiarity with containers over the next few posts but, before going any further, I want to have a refresher on the appropriate phraseology.

## Terminology

An _image_ is a blueprint of the application you want to run. It packages up everything required into a single executable process: code, system libraries and operating system. Technically, it's a compressed `tar` archive consisting of directories and `json` manifests that constitute _layers_ of the image.

A _container_ is a running instance of an image.

When I use either of these terms, I'm specifically going to be implying compliance with the [OCI](https://opencontainers.org/about/overview/) Image Specification.

Images are stored in a _registry_ -- they can be made either public or private.

You can self-host a registry, go with a managed solution, your cloud service provider or potentially even directly with your source code repository hosting company.

An image _name_ is made up of components separated with slashes; this name maps to a _repository_ in a registry. A repository can be constructed however you wish (as long as you stick to the accepted character ranges); you could prefix your image names with a vendor path, specify package membership or simply use the name of your application.

If the first component of an image name contains a colon or a period then it is considered to indicate the registry address for the image. If no registry is specified and you try and `push` the image, it could end up being published on [Docker Hub](https://hub.docker.com) and therefore made publicly available.

An image _tag_ can be used to identify different variants of the same image name. You may want to add build information, a version number, or include the OS. If no tag is given, a default of `latest` will be used automatically; this does not imply that the image is, in fact, actually the most recent build.

    <registry>/<repository>:<tag>

## Custom Images

Most of the time, the images you build will rely on an upstream base image. Depending on your architecture, this may be something like `nginx:stable-alpine` or `php:7.4-fpm-alpine`.

Alternatively you could start with a base OS image such as `alpine:3.12` or `ubuntu:20.04` and use the native package manager to install what you need for your project.

{{< hilite docker >}}
FROM alpine:3.12

RUN apk --no-cache add \
        nginx~=1.18.0 \
    && rm -rf /var/cache/apk/*

CMD ["nginx"]
ENTRYPOINT ["-g", "daemon off;"]
{{< /hilite >}}

Going further still, thanks to the beauty of Open Source software, you are free to download the source code in order to configure and compile the application yourself.

## Official Images

"But what's the problem with just using official images from Docker Hub?" I hear you cry. "Why should I go to the bother of building my own versions?"

The only confidence that using official images should give you is that they're not going to disappear overnight. Using a package manager also puts a reliance -- and trust -- on third parties and on their priorities and schedules.

If you build something yourself then you have full control -- you know exactly what's in the resulting image. I'm not suggesting that you audit the source files but you can certainly improve your security by reducing the attack surface.

Official images are generic, trying to cover the biggest number of <nobr>use-cases</nobr> for the <nobr>widest-ranging</nobr> audience. By customising and removing what you're not going to use, not only will you make life harder for an attacker but you'll also reduce the final size of your image.

Synk's [Shifting Docker Security Left](https://snyk.io/blog/shifting-docker-security-left/) report on the state of development practices contained some eye-opening statistics.

> The top 10 official Docker images with more than 10 million downloads each contain at least 30 vulnerabilities.

> Of the top 10 most popular free certified Docker images, 50% have known vulnerabilities.

There is also an opportunity to improve performance in images you create by using profile-guided optimisation. This involves extra steps in the build process where you train the compiler on your application code. Using this technique will take longer but could give you a performance boost of several percent.

In the next few posts I'm going to go over some of the methods I use when building my own container images.

<div style="
    background: #eee;
    padding: .5rem 1rem;
    border: 1px solid #ddd;
">
        <h3 style="
    margin-bottom: .5rem;
">Would you like to know more?</h3>
        <ul>
            <li>
                <a href="https://gist.github.com/aaronlehmann/b42a2eaf633fc949f93b">Docker v1.10 Design</a></li>
            <li>
                <a href="https://windsock.io/explaining-docker-image-ids/">Explaining Docker Image IDs</li>
            <li>
                <a href="https://medium.com/tenable-techblog/a-peek-into-docker-images-b4d6b2362eb">A Peek into Docker Images</a>
            </li>
        </ul>
    </div>
