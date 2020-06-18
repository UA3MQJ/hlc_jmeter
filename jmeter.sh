#!/usr/bin/env sh

echo "INFO - Some JMeter prepare steps..."
ls -la

echo "INFO - Running JMeter..."
# jmeter -n -t tests/example-jmeter-test.jmx -Jhost=ya.ru -l index.html -e -o ./jmeter_report
jmeter -n -t test_plan.jmx -Dprometheus.port=9270 -Dprometheus.ip=0.0.0.0

echo "DEBUG - Some steps to prepare reports..."

echo "DEBUG - view files in ./jmeter_report:"
ls -la ./jmeter_report
echo "INFO - Report's data files are prepared to publish"
