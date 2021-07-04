---
title: "You Can't Always Get What You Want"
date: 2020-04-21T09:41:16Z
summary: I had some pretty specific requirements regarding a theme for my blog but I couldn't find anything that ticked all my boxes.
tags: ["blog"]
---
{{< quote text="Simplicity is the ultimate sophistication." author="Leonardo da Vinci" >}}

Having decided a) to start writing again and, b) on how I was going to publish, I asked myself what I'd like from a blog theme and I came up with lists of several keywords:

- Clean, Simple, Minimal, Lightweight
- Mobile-first, Responsive, Gridless
- Accessible, Maintainable, Semantic, Valid

I couldn't really find anything that I liked so I decided to roll my sleeves up and write my own. My front-end skills have definitely got a bit rusty from underuse in recent years; I guess I missed it more than a little. And, wow, how complicated is it these days? I know it doesn't _have_ to be, but I freely admit that I kind of enjoy playing with the tools -- of which there are a ridiculous amount.

I used to work at a design agency for a long time so I picked up one or two things along the way. Now I'm not claiming that I can actually _design_ anything myself, nor that I necessarily fully understand all of the subtle nuances that contribute to an effective implementation, but I'm not sure that's really important in order to be able to appreciate the difference that at least some attention to detail can make.

Things like a fully responsive layout, performance, accessibility, custom fonts and establishing a vertical rhythm for your typography.

## Choices

Adopting a mobile-first strategy, I chose to expose my main navigation on smaller devices rather than collapsing the links into a JavaScript-powered burger menu and to instead reflow the layout for larger screens.

The big thing in terms of performance though is that there's no JavaScript as standard at all; absolutely no tracking or analytics libraries.

This is a personal blog; I'm not a business trying to ensure my marketing budget is being well spent and I have no goals to convert. I'm also not really concerned with vanity metrics like page views.

Were I so inclined, I _could_ get some rough numbers from Cloudflare but primarily this is an outlet for me to write about things in which I'm interested and sometimes to transcribe the thoughts that are swirling around inside my head -- those that need externalising occasionally in order to let me sleep.

## Technologies

Webpack, Flexbox, subsetted WOFF2 fonts, Brotli and AVIF compression for content and images, HTTP/2 and resource preloading all contribute towards delivering tiny, performant sites built to work in a progressive manner with modern evergreen browsers.

Couple all of these advancements with static generation to massively reduce the attack surface for any miscreants looking to take control of a site and you're in a really good place.
