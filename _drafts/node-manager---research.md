---
title: "Node Manager - Research"
layout: default
date: 2017-09-01 09:20:44 BST
---

# Node Manager - Research
What is the node manager? 
https://hortonworks.com/blog/apache-hadoop-yarn-nodemanager/

https://community.hortonworks.com/questions/47382/yarn-components-fail-after-ambari-metrics-collecto.html

```

Connection failed to http://dev3.exp.caspian.rax.io:8042/ws/v1/node/info (Traceback (most recent call last): File "/var/lib/ambari-agent/cache/common-services/YARN/2.1.0.2.0/package/alerts/alert_nodemanager_health.py", line 165, in execute url_response = urllib2.urlopen(query, timeout=connection_timeout) File "/usr/lib64/python2.6/urllib2.py", line 126, in urlopen return _opener.open(url, data, timeout) File "/usr/lib64/python2.6/urllib2.py", line 391, in open response = self._open(req, data) File "/usr/lib64/python2.6/urllib2.py", line 409, in _open '_open', req) File "/usr/lib64/python2.6/urllib2.py", line 369, in _call_chain result = func(*args) File "/usr/lib64/python2.6/urllib2.py", line 1190, in http_open return self.do_open(httplib.HTTPConnection, req) File "/usr/lib64/python2.6/urllib2.py", line 1165, in do_open raise URLError(err) URLError: )
```

