---
title: "Utility Images"
date: 2020-09-12T15:10:13Z
summary: "The process of building container images from source archives can be broken down into a few distinct stages, some of which can be done ahead of time and reused."
tags: ["images","containers","dev"]
---
{{< quote text="Nothing can have value without being an object of utility." author="Karl Marx" >}}

Before we can get around to building our image, we need to obtain the source code. We don't need to do this each time.

My own pre-patched base Alpine and Ubuntu images from pinned digests.

{{< hilite docker >}}
FROM alpine@sha256:{{< note >}}185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321{{< /note >}}

RUN apk --no-cache update \
    && apk --no-cache upgrade --latest \
    && rm -rf /var/cache/apk/*
{{< /hilite >}}

1. Update this digest as and when new upstream releases are made.

Having a single common base facilitates a shared common layer which will improve storage and network tranfser efficiencies.

It's also a single point for patching. This allows all other dependant images to be built in an idempotent manner.

Working from this custom Alpine base, I add `axel` and `gnupg` to create a generic utility image which is responsible for not only dowloading potentially large source code archives but also for verifying them -- again, this is a one-time task.

{{< hilite docker >}}
FROM nevstokes/base-alpine:3.12

RUN apk --no-cache add \
    axel~=2.17.8 \
    gnupg~=2.2.23 \
    && rm -rf /var/cache/apk/*
{{< /hilite >}}

Using this image as a new base, I create separate images for each source code archive of the images I'm wanting to build and add the `gpg` keys of their maintainers and release managers.

{{< hilite docker >}}
FROM nevstokes/base-fetch:latest

RUN gpg add
{{< /hilite >}}

Similarly, I create a base image for building these images that contains `build-base` or `build-essentials`. This will be enough for some images -- others will need some additional dependencies.

I also add `upx` -- which is a binary packing utility -- in order to compress the final applications I build for the image. Using this results in much smaller images which equates to faster downloads, and savings on storage and transfer costs. There is a very slight hit on container start up time while the binary is expanded into memory (which is more than compensated by the quicker time taken to pull the image) but there is absolutely no impact after that.

{{< hilite docker >}}
FROM nevstokes/base-alpine:3.12

RUN apk --no-cache add \
    build-base~=0.5 \
    upx~=3.96 \
    && rm -rf /var/cache/apk/*
{{< /hilite >}}

When it comes time to build, I have everything I need in images - verified source and. I can work offline. Remove network affects.
