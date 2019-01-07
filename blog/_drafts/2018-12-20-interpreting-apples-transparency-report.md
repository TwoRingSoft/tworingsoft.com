---
title: "Interpreting Apple's Transparency Report"
date: 2019-01-01
layout: post
abstract: Apple recently released their transparency report for government and private party information requests for January through June of 2018, in an updated format including broken out CSVs.
author: Andrew McKnight
author-email: andrew@tworingsoft.com
tags: apple ethics law
---

Apple recently released their [transparency report](https://www.apple.com/legal/transparency/) for January 1 to June 30 of 2018, detailing requests for various types of information from governments and private third parties, along with their responses, via a fancy presentation, PDFs and some nice CSVs for number-crunching.

Whenever I have sets of numbers like this, I like to know the shape of the data. To me, this means the histogram of z-scores of the sample values. This helps show me how the population skews towards average, and how [far from] average is each member. This usually helps inform my next steps in pulling apart the data. Is it tightly grouped around the mean? Uniformly random? Is there a long tail worth considering?

Bonus points if we have series of samplings, so we can see how things progress as time goes on. The CSVs I downloaded have all the data for the catalog of reports they've released since 2013.

I broke down the request types for devices, financial identifiers and account info/preservation/restriction/deletion. For each of these, I'm interested in the number of requests received by country, average items per request, and the percentage of requests honored by Apple.

> Shout out to [cocoapods-playgrounds](https://github.com/asmallteapot/cocoapods-playgrounds) which I discovered while working on this post, in order to code up the number-crunching using my own library [FastMath](https://github.com/tworingsoft/fastmath) and the excellent [Charts](https://github.com/danielgindi/Charts) library to produce the graphics.

> Also TIL: the [68-95-99.7 rule aka empirical rule](https://en.wikipedia.org/wiki/68–95–99.7_rule) is a mnemonic to remember the percentages of a normally distributed population within 1, 2 and 3 (respectively) standard deviations from the mean.
