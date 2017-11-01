---
title: "Kaggle and Spark"
layout: post
date: 2017-11-01 20:26:39 GMT
---

# Kaggle and Spark
So I thought I would try my hand at Kaggle to get a bit more practice with Spark. It probably isn't the best tool for the job as the files aren't going to be huge, but is an interesting way to try and learn both.

Initially I signed in and was greeted with a pop-up asking me to find 'Which open dataset defines you?'! It was a short quiz that prompted me to go to the [Board Games Dataset](https://www.kaggle.com/gabrio/board-games-dataset). It was a nice touch to get me started. Once downloaded though its a sqlite database! What am I going to do with that? Obviously I was expecting a csv or something but this works as well. Something new to learn

1. Tried directly with spark, got error
2. Tried with the link got error
3. Downloaded jar and ran with --jars

``` spark-shell --jars sqlite-jdbc-3.20.0.jar ```
