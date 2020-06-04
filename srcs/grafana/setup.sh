while :
do
    curl http://influxdb:8086/ping
    if [ $? == 0 ]
    then
        break
    fi
    sleep 10
done
echo "Connection with InfluxDB established."
cd ./grafana-6.7.2/bin/ && ./grafana-server