* 下载硬件监控相关yaml文件
```
git clone https://github.com/zcx5825585/edgeplus-prom.git && cd edgeplus-prom
```
* 修改yaml文件以适配当前系统环境,将scrape_configs.consul_sd_configs.server 中的 THE-EXPOSED-IP 替换为master节点的公网IP
```
vi prometheus/prometheus-cfg.yaml
```
* 创建命名空间
```
kubectl apply -f namespace.yaml
```
* 部署Prometheus，用于数据的汇总
```
kubectl apply -f prometheus/
```
* 部署node_exporter，用于在边缘节点上进行数据收集，进加入的节点会自动部署node_exporter，此步需保证master节点9100端口未被占用
```
kubectl apply -f node_exporter/
```
* 部署consul,因kubeedge的节点监控未与k8s兼容，需使用consul作为服务发现，此步需设置master节点8500端口未被占用并可从外网访问
```
kubectl apply -f consul.yaml
```
* 部署grafana,用于图形化展示
```
kubectl apply -f grafana.yaml
```
 * 使用`kubectl get pod -n prom`指令查看部署情况，当所有pod都处于running状态后，通过浏览器访问master节点32766端口进行grafana的配置
 1. 登录，默认用户名为 admin 密码为 admin
 
 2. 在左边栏的Configuration-Data Sources菜单中创建并配置Prometheus，prometheus和grafana都是由k8s部署的，可直接使用集群内部地址 http://prometheus.prom.svc:9090
 
  3. 通过json文件导入Dashboard (json文件为edgeplus-prom目录下的dashboard.json)
