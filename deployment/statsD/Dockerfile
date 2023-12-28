FROM 157529275398.dkr.ecr.ap-southeast-1.amazonaws.com/cicd/dp-ie/statsd:v0.22.4-logs-1

ENV LOG_LEVEL debug

ENTRYPOINT /bin/statsd_exporter --log.level="${LOG_LEVEL}"
