FROM docker.elastic.co/logstash/logstash:7.16.2

RUN bin/logstash-plugin install logstash-filter-sentimentalizer