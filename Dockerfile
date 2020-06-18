FROM egaillardon/jmeter-plugins
RUN ["mkdir", "/jmeter/jmeter_report"]
RUN apk add --no-cache wget
RUN wget https://github.com/johrstrom/jmeter-prometheus-plugin/releases/download/0.6.0/jmeter-prometheus-plugin-0.6.0.jar -O /opt/apache-jmeter-5.2.1/lib/ext/jmeter-prometheus-plugin-0.6.0.jar
COPY ./test_plan.jmx ./test_plan.jmx
COPY ./jmeter.sh ./jmeter.sh
ENTRYPOINT [""]