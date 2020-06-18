Запуск jmeter без gui внурки докера с экспортером в prometheus

test_plan.jmx экспортит метрики ResponseTime (с персентилями), Ratio (он же rps)

Рецепты

создаю
docker build -t hlt .

запускаю в шелл
docker run -i -t --rm --net host hlt:latest sh

запускаю сразу скрипт
docker run -i -t --rm -p 9270:9270 hlt:latest ./jmeter.sh

запуск influx
docker run -p 8086:8086 \
    -v $PWD:/var/lib/influxdb \
    influxdb

docker run \
    -d \
    -p 8086:8086 \
    -p 2003:2003 \
      -e INFLUXDB_DB=db0 \
      -e INFLUXDB_ADMIN_USER=admin -e INFLUXDB_ADMIN_PASSWORD=supersecretpassword \
      -e INFLUXDB_USER=telegraf -e INFLUXDB_USER_PASSWORD=secretpassword \
      -v $PWD/influxdb/:/var/lib/influxdb \
      -v $PWD/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
      influxdb

docker logs -f influxdb

запуск прометеуса
docker run -d -p 9090:9090 -v $PWD/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

запуск локально

prometheus --config.file=prometheus.yml

запуск графаны
docker run -d -p 3000:3000 grafana/grafana
логин admin admin

плагины
rocks.nt.apm.jmeter.JMeterInfluxDBBackendListenerClient
curl https://github.com/NovatecConsulting/JMeter-InfluxDB-Writer/releases/download/v-1.2/JMeter-InfluxDB-Writer-plugin-1.2.jar

curl https://github.com/NovatecConsulting/JMeter-InfluxDB-Writer/releases/download/v-1.2/JMeter-InfluxDB-Writer-plugin-1.2.jar --output /opt/apache-jmeter-5.2.1/lib/ext/JMeter-InfluxDB-Writer-plugin-1.2.jar

ссылки
https://www.blazemeter.com/blog/how-to-use-grafana-to-monitor-jmeter-non-gui-results?utm_source=blog&utm_medium=BM_blog&utm_campaign=how-to-use-grafana-to-monitor-jmeter-non-gui-results2

https://www.blazemeter.com/blog/how-to-use-grafana-to-monitor-jmeter-non-gui-results-part-2



локально jmeter
wget https://github.com/johrstrom/jmeter-prometheus-plugin/releases/download/0.6.0/jmeter-prometheus-plugin-0.6.0.jar -O /usr/local/Cellar/jmeter/5.2.1/libexec/lib/ext/jmeter-prometheus-plugin-0.6.0.jar


jmeter -n -t test_plan.jmx

