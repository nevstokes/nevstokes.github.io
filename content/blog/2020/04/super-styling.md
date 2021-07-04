---
title: "Super Styling"
date: 2020-05-04T09:41:16Z
summary: I'm gradually getting to grips with Hugo, learning about how the build process, shortcodes and templates all work.
tags: ["blog"]
---
{{< quote text="The wisdom of the wise, and the experience of ages, may be preserved by quotation." author="Issac D'Israeli" >}}

I liked to begin posts on the previous incarnation of this blog with a quotation and I see no reason why I shouldn't continue the practice. For one thing, I quite enjoy researching them -- occasionally stumbling over misattribution and misunderstanding when attempting to verify.

For example, Gandhi's purported _["Be the Change"](https://professorbuzzkill.com/gandhi-be-the-change-you-wish-to-see-in-the-world/)_, Michaleangelo's _["Ancaro Imparo"](https://www.maryellencarsley.com/blog/i-am-still-learning-misattributed-to-michelangelo-di-lodovico-buonarroti-simoni)_ and the history of considering oneself a _[Citizen of the World](https://sententiaeantiquae.com/2016/06/04/citizens-of-the-world-from-diogenes-to-marcus-aurelius/)_ -- a phrase that was thrust into the headlines most recently when Theresa May put forward her own unpleasant interpretation.

Anyway, in order to avoid repetition in my Markdown source files, this use case seemed to be a prime candidate for writing my first custom Hugo shortcode.

Consequently, I've added this to the top of my blog post [archetype](https://gohugo.io/content-management/archetypes/):

{{< hilite html >}}
{​{< quote text="..." author="..." >}}
{{</hilite >}}

Which makes use of the corresponding shortcode template:

`layouts/shortcodes/quote.html`

{{< hilite html >}}
<figure>
    <blockquote>{{ .Get "text" }}</blockquote>
    <figcaption>
        &mdash; {{ .Get "author"{{< note >}} | safeHTML{{< /note >}} }}
    </figcaption>
< /figure>
{{</hilite >}}

1. Passing the author through the `safeHTML` function lets me add arbitrary markup, should I wish to include a citation for example.

With some styling applied, I get a nice-looking introduction for each post with minimal effort and a single file to change should I ever feel the need to update the layout.
