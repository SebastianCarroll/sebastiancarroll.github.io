---
title: "Solr Distribution Sharding"
layout: post
date: 2017-09-12 15:54:54 BST
---

# Solr Distribution Sharding
We had an issue today where Ranger was set up to log audits to Solr (or Ambari infra in this case) but was returning empty when querying for those logs. It was working initially but now was empty. I thought it could have been memory issues but turned out it was an age off and a distributed cluster problem. We had too many documents and were also logging only to one node as out `solr_shards` configuration (or `ranger_solr_shards` in Ambari) was set to 1.
This needs to be set to the number of nodes for all those nodes to be used. Since we had Solr deployed on two nodes but the parameter was set to 1, we were only actually using 1.The next steps will be to look at managing the age-off of the documents properly this [HCC Article](https://community.hortonworks.com/articles/63853/solr-ttl-auto-purging-solr-documents-ranger-audits.html) looks to be a good place to star 
