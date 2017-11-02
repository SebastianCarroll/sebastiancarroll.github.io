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
[This link](https://docs.databricks.com/spark/latest/data-sources/sql-databases.html)

~~~
import java.sql.DriverManager
val connection = DriverManager.getConnection("jdbc:sqlite:./database.sqlite")
~~~

```
java.sql.SQLException: No suitable driver found for jdbc:sqlite:.database.sqlite
  at java.sql.DriverManager.getConnection(DriverManager.java:689)
  at java.sql.DriverManager.getConnection(DriverManager.java:270)
  ... 48 elided
```

3. Downloaded jar and ran with --jars

``` spark-shell --jars sqlite-jdbc-3.20.0.jar ```

Still didn't works

~~~
spark.read.jdbc("jdbc:sqlite:./database.sqlite", "BoardGames", new Properties())
~~~

4. Had to specifiy the class in the Properties

[Source](https://spark.apache.org/docs/latest/sql-programming-guide.html#jdbc-to-other-databases)

~~~
var props = new Properties()
props.put("driver", "org.sqlite.JDBC")

var boardgames = spark.read.jdbc("jdbc:sqlite:./database.sqlite", "BoardGames", props)
~~~

5. But this didn't help me because they were just numbers. What was the schema here?
~~~
scala> boardgames.first()(1)
res21: Any = 1
~~~

Not very helpful...

6. back to sqlite3
~~~
CREATE TABLE "BoardGames" (
  "row_names" TEXT,
  "game.id" TEXT,
  "game.type" TEXT,
  "details.description" TEXT,
  "details.image" TEXT,
  "details.maxplayers" INTEGER,
  "details.maxplaytime" INTEGER,
  "details.minage" INTEGER,
  "details.minplayers" INTEGER,
  "details.minplaytime" INTEGER,
  "details.name" TEXT,
  "details.playingtime" INTEGER,
  "details.thumbnail" TEXT,
  "details.yearpublished" INTEGER,
  "attributes.boardgameartist" TEXT,
  "attributes.boardgamecategory" TEXT,
  "attributes.boardgamecompilation" TEXT,
  "attributes.boardgamedesigner" TEXT,
  "attributes.boardgameexpansion" TEXT,
  "attributes.boardgamefamily" TEXT,
  "attributes.boardgameimplementation" TEXT,
  "attributes.boardgameintegration" TEXT,
  "attributes.boardgamemechanic" TEXT,
  "attributes.boardgamepublisher" TEXT,
  "attributes.total" REAL,
  "stats.average" REAL,
  "stats.averageweight" REAL,
  "stats.bayesaverage" REAL,
  "stats.family.abstracts.bayesaverage" REAL,
  "stats.family.abstracts.pos" REAL,
  "stats.family.cgs.bayesaverage" REAL,
  "stats.family.cgs.pos" REAL,
  "stats.family.childrensgames.bayesaverage" REAL,
  "stats.family.childrensgames.pos" REAL,
  "stats.family.familygames.bayesaverage" REAL,
  "stats.family.familygames.pos" REAL,
  "stats.family.partygames.bayesaverage" REAL,
  "stats.family.partygames.pos" REAL,
  "stats.family.strategygames.bayesaverage" REAL,
  "stats.family.strategygames.pos" REAL,
  "stats.family.thematic.bayesaverage" REAL,
  "stats.family.thematic.pos" REAL,
  "stats.family.wargames.bayesaverage" REAL,
  "stats.family.wargames.pos" REAL,
  "stats.median" REAL,
  "stats.numcomments" REAL,
  "stats.numweights" REAL,
  "stats.owned" REAL,
  "stats.stddev" REAL,
  "stats.subtype.boardgame.bayesaverage" REAL,
  "stats.subtype.boardgame.pos" REAL,
  "stats.trading" REAL,
  "stats.usersrated" REAL,
  "stats.wanting" REAL,
  "stats.wishing" REAL,
  "polls.language_dependence" TEXT,
  "polls.suggested_numplayers.1" TEXT,
  "polls.suggested_numplayers.10" TEXT,
  "polls.suggested_numplayers.2" TEXT,
  "polls.suggested_numplayers.3" TEXT,
  "polls.suggested_numplayers.4" TEXT,
  "polls.suggested_numplayers.5" TEXT,
  "polls.suggested_numplayers.6" TEXT,
  "polls.suggested_numplayers.7" TEXT,
  "polls.suggested_numplayers.8" TEXT,
  "polls.suggested_numplayers.9" TEXT,
  "polls.suggested_numplayers.Over" TEXT,
  "polls.suggested_playerage" TEXT,
  "attributes.t.links.concat.2...." TEXT,
  "stats.family.amiga.bayesaverage" REAL,
  "stats.family.amiga.pos" REAL,
  "stats.family.arcade.bayesaverage" REAL,
  "stats.family.arcade.pos" REAL,
  "stats.family.atarist.bayesaverage" REAL,
  "stats.family.atarist.pos" REAL,
  "stats.family.commodore64.bayesaverage" REAL,
  "stats.family.commodore64.pos" REAL,
  "stats.subtype.rpgitem.bayesaverage" REAL,
  "stats.subtype.rpgitem.pos" REAL,
  "stats.subtype.videogame.bayesaverage" REAL,
  "stats.subtype.videogame.pos" REAL
);
~~~

7. Didn't even need that. Of course scala has a builtin  ```printSchema()```

~~~
root
 |-- row_names: string (nullable = true)
 |-- game.id: string (nullable = true)
 |-- game.type: string (nullable = true)
 |-- details.description: string (nullable = true)
 |-- details.image: string (nullable = true)
 |-- details.maxplayers: integer (nullable = true)
 |-- details.maxplaytime: integer (nullable = true)
 |-- details.minage: integer (nullable = true)
 |-- details.minplayers: integer (nullable = true)
 |-- details.minplaytime: integer (nullable = true)
 |-- details.name: string (nullable = true)
 |-- details.playingtime: integer (nullable = true)
 |-- details.thumbnail: string (nullable = true)
 |-- details.yearpublished: integer (nullable = true)
 |-- attributes.boardgameartist: string (nullable = true)
|-- attributes.boardgamecategory: string (nullable = true)
|-- attributes.boardgamecompilation: string (nullable = true)
|-- attributes.boardgamedesigner: string (nullable = true)
|-- attributes.boardgameexpansion: string (nullable = true)
|-- attributes.boardgamefamily: string (nullable = true)
|-- attributes.boardgameimplementation: string (nullable = true)
|-- attributes.boardgameintegration: string (nullable = true)
|-- attributes.boardgamemechanic: string (nullable = true)
|-- attributes.boardgamepublisher: string (nullable = true)
|-- attributes.total: double (nullable = true)
|-- stats.average: double (nullable = true)
|-- stats.averageweight: double (nullable = true)
|-- stats.bayesaverage: double (nullable = true)
|-- stats.family.abstracts.bayesaverage: double (nullable = true)
|-- stats.family.abstracts.pos: double (nullable = true)
|-- stats.family.cgs.bayesaverage: double (nullable = true)
|-- stats.family.cgs.pos: double (nullable = true)
|-- stats.family.childrensgames.bayesaverage: double (nullable = true)
|-- stats.family.childrensgames.pos: double (nullable = true)
|-- stats.family.familygames.bayesaverage: double (nullable = true)
|-- stats.family.familygames.pos: double (nullable = true)
|-- stats.family.partygames.bayesaverage: double (nullable = true)
|-- stats.family.partygames.pos: double (nullable = true)
|-- stats.family.strategygames.bayesaverage: double (nullable = true)
|-- stats.family.strategygames.pos: double (nullable = true)
|-- stats.family.thematic.bayesaverage: double (nullable = true)
|-- stats.family.thematic.pos: double (nullable = true)
|-- stats.family.wargames.bayesaverage: double (nullable = true)
|-- stats.family.wargames.pos: double (nullable = true)
|-- stats.median: double (nullable = true)
|-- stats.numcomments: double (nullable = true)
|-- stats.numweights: double (nullable = true)
|-- stats.owned: double (nullable = true)
|-- stats.stddev: double (nullable = true)
|-- stats.subtype.boardgame.bayesaverage: double (nullable = true)
|-- stats.subtype.boardgame.pos: double (nullable = true)
|-- stats.trading: double (nullable = true)
|-- stats.usersrated: double (nullable = true)
|-- stats.wanting: double (nullable = true)
|-- stats.wishing: double (nullable = true)
|-- polls.language_dependence: string (nullable = true)
|-- polls.suggested_numplayers.1: string (nullable = true)
|-- polls.suggested_numplayers.10: string (nullable = true)
|-- polls.suggested_numplayers.2: string (nullable = true)
|-- polls.suggested_numplayers.3: string (nullable = true)
|-- polls.suggested_numplayers.4: string (nullable = true)
|-- polls.suggested_numplayers.5: string (nullable = true)
|-- polls.suggested_numplayers.6: string (nullable = true)
|-- polls.suggested_numplayers.7: string (nullable = true)
|-- polls.suggested_numplayers.8: string (nullable = true)
|-- polls.suggested_numplayers.9: string (nullable = true)
|-- polls.suggested_numplayers.Over: string (nullable = true)
|-- polls.suggested_playerage: string (nullable = true)
|-- attributes.t.links.concat.2....: string (nullable = true)
|-- stats.family.amiga.bayesaverage: double (nullable = true)
|-- stats.family.amiga.pos: double (nullable = true)
|-- stats.family.arcade.bayesaverage: double (nullable = true)
|-- stats.family.arcade.pos: double (nullable = true)
|-- stats.family.atarist.bayesaverage: double (nullable = true)
|-- stats.family.atarist.pos: double (nullable = true)
|-- stats.family.commodore64.bayesaverage: double (nullable = true)
|-- stats.family.commodore64.pos: double (nullable = true)
|-- stats.subtype.rpgitem.bayesaverage: double (nullable = true)
|-- stats.subtype.rpgitem.pos: double (nullable = true)
|-- stats.subtype.videogame.bayesaverage: double (nullable = true)
|-- stats.subtype.videogame.pos: double (nullable = true)
~~~

8. Trying to just get a useful subset
details.maxplayers: integer (nullable = true)
 |-- details.maxplaytime: integer (nullable = true)
 |-- details.minage: integer (nullable = true)
 |-- details.minplayers: integer (nullable = true)
 |-- details.minplaytime: integer (nullable = true)
 |-- details.name: string (nullable = true)
 |-- details.playingtime


 but even the `select` command doesnt work:
```
scala> boardgames.select("details.name").show()
org.apache.spark.sql.AnalysisException: cannot resolve '`details.name`' given input columns: [polls.suggested_numplayers.4, ....,  details.name, ...., stats.family.wargames.pos];;
```

Its clearly there. Even tried with the extra space ([hint from here](https://stackoverflow.com/questions/39016440/analysisexception-ucannot-resolve-name-given-input-columns-list-in-sqlco)) as I couldn't tell if that was a printing thing. No dice

9. Tried with a table
```
scala> boardgames.createOrReplaceTempView("boardgames")
scala> var bg_name = spark.sql("select details.name from boardgames limit 10)
```

No dice
```
org.apache.spark.sql.AnalysisException: cannot resolve '`details.name`' given input columns:
 ```

 10. Checked class
 ```
 scala> boardgames.getClass
res37: Class[_ <: org.apache.spark.sql.DataFrame] = class org.apache.spark.sql.Dataset
```

11. Found something with the backticks
[From here](https://stackoverflow.com/questions/43122830/spark-cannot-resolve-input-columns) sayiing that the backticks are actually included! WTF.

```
scala> var bg_name = spark.sql("select `details.name` from boardgames limit 10")
bg_name: org.apache.spark.sql.DataFrame = [details.name: string]

scala> bg_name.show
+------------------+
|      details.name|
+------------------+
|        Die Macher|
|      Dragonmaster|
|           Samurai|
|    Tal der Könige|
|           Acquire|
|Mare Mediterraneum|
|         Cathedral|
| Lords of Creation|
|      El Caballero|
|         Elfenland|
+------------------+
```

There must be something here I really don't understand because that seems so broken. Where would that even come  from?

12. Hyphens and dots aren't allowed in the column names. Those backticks are needed to escape the chars.

See
https://stackoverflow.com/questions/43122830/spark-cannot-resolve-input-columns
https://issues.apache.org/jira/browse/SPARK-18502
https://stackoverflow.com/questions/30889630/how-to-escape-column-names-with-hyphen-in-spark-sql
