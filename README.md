# DevOps - Containerization, CI/CD &amp; Monitoring - January 2023 - SoftUni

## Regular Exam

### The whole process is fully automated

1. **Creating Vagrantfile which creates three virtual machine with the following configuration:**
    - docker
      - Box: **`shekeriev/debian-11`**
      - Host names: **`containers.do1.exam`**
      - Private network with dedicated IPs: **`192.168.99.202`**
      - Provisioning via provided bash scripts: [**`add-hosts.sh`**](/provision-scripts/add-hosts.sh), [**`install_docker.sh`**](/provision-scripts/install_docker.sh),[**`setup_docker.sh`**](/provision-scripts/setup_docker.sh), [**`setup_gitea.sh`**](/provision-scripts/setup_gitea.sh) and [**`install_node_exporter.sh`**](/provision-scripts/install_node_exporter.sh)
      - Shared folder configuration: **`shared-files/`** -> **`/vagrant`**
      - Set virtual machine memory size: **`3072`**
    - jenkins
      - Box: **`shekeriev/debian-11`**
      - Host names: **`pipelines.do1.exam`**
      - Private network with dedicated IPs: **`192.168.99.201`**
      - Provisioning via provided bash scripts: [**`add-hosts.sh`**](/provision-scripts/add-hosts.sh), [**`install_jenkins.sh`**](/provision-scripts/install_jenkins.sh),  [**`setup_jenkins.sh`**](/provision-scripts/setup_jenkins.sh) and [**`install_node_exporter.sh`**](/provision-scripts/install_node_exporter.sh)
      - Shared folder configuration: **`shared-files/`** -> **`/vagrant`**
      - Set virtual machine memory size: **`3072`**
    - monitoring
      - Box: **`shekeriev/debian-11`**
      - Host names: **`monitoring.do1.exam`**
      - Private network with dedicated IPs: **`192.168.99.203`**
      - Provisioning via provided bash scripts: [**`add-hosts.sh`**](/provision-scripts/add-hosts.sh), [**`install_docker.sh`**](/provision-scripts/install_docker.sh) and   [**`install_prometheus.sh`**](/provision-scripts/install_prometheus.sh)
      - Shared folder configuration: **`shared-files/`** -> **`/vagrant`**
      - Set virtual machine memory size: **`3072`**
    - Create after trigger event to create an index pattern in Kibana using REST API
    - Create another after trigger event to open default browser to view created Kibana dataviews at [**`http://192.168.34.201:5601/app/management/kibana/dataViews`**](http://192.168.34.201:5601/app/management/kibana/dataViews)
2. **Sequence of actions:**
    - Install docker on docker machine:
        - Change Docker configuration to expose Prometheus metrics by copying [**`daemon.json`**](/shared-files/docker/daemon.json) to **`/etc/docker/`** folder
    - Install and setup gitea via docker compose using the following configuration file [**`docker-compose.yml`**](/shared-files/gitea/docker-compose.yml)
        - Setup gitea with following data:
            - GITEA__server__DOMAIN=[**`192.168.99.202`**]
            - GITEA__server__ROOT_URL=[**`http://192.168.99.202:3000`**]
            - GITEA__webhook__ALLOWED_HOST_LIST=[**`192.168.99.0/24`**]
        - Clone the following repository [**`shekeriev/fun-facts`**](https://github.com/shekeriev/fun-facts)
        - Copy local files to repository folder and push to gitea public project with name: [**`exam`**](http://192.168.99.202:3000/vagrant/exam.git)
        - Add webhook for the [**`exam`**](http://192.168.99.202:3000/vagrant/exam.git) project
    - Install and run Node Exporter on docker VM
    - Install Jenkins and needed components (like java-17)
    - Setup Jenkins
        - Set credentials for docker user: needed to push images to [**`docker hub`**](https://hub.docker.com/)
        - Configure jenkins via configuration scripts to automate the process like creating admin account, installing needed plugins and etc.
        - Download Jenkins CLI
        - Create vagrant credentials
        - Create Docker Hub credentials
        - Add slave node
        - Add and build the exam job
    - Install and run Node Exporter on jenkins VM
    - Install docker on monitoring VM
    - Install and setup Prometheus and Grafana via docker compose using the following configuration file [**`docker-compose.yml`**](/shared-files/prometheus/docker-compose.yml)
        - Copy Prometheus custom configuration file [**`prometheus.yml`**](/shared-files/prometheus/prometheus.yml) to /tmp folder
            - scrape metrics configuration for two job [**`docker`**] and [**`node-exporter`**]
        - Grafana is provision by following configuration files:
            - [**`dashboard.yml`**](/shared-files/grafana/provisioning/dashboards/dashboard.yml)
            - [**`datasource.yml`**](/shared-files/grafana/provisioning/datasources/datasource.yml)
            - Custom cofiguration file to create datasource and dashboard with needed metrics: [**`exam.json`**](/shared-files/grafana/provisioning/dashboards/exam.json)
        - Using docker compose with the following configuration [**`docker-compose.yml`**](/shared-files/prometheus/docker-compose.yml) run the Prometheus & Grafana containers
3. **The result:**
    - Gitea repo can be seen at: [**`http://192.168.99.202:3000/vagrant/exam`**](http://192.168.99.202:3000/vagrant/exam)
        - Credentials
            - user: **`admin`**
            - password: **`admin`**
    - Jenkins job pipeline can be seen at: [**`http://192.168.99.201:8080/job/exam/`**](http://192.168.99.201:8080/job/exam/)
        - Credentials
            - user: **`admin`**
            - password: **`admin`**
    - The final result of builded images in docker can be seen at: [**`http://localhost:80/`**](http://localhost:80/) or [**`http://192.168.99.202:8080/`**](http://192.168.99.202:8080/)
    - The Grafana monitoring dashboard can be seen at: [**`http://localhost:8083`**](http://localhost:8083) or [**`http://192.168.99.203:3000/`**](http://192.168.99.203:3000/)
        - Credentials
            - user: **`admin`**
            - password: **`admin`**
    - Created docker hub repositories can be seen at: [**`https://hub.docker.com/repositories/mark79`**](https://hub.docker.com/repositories/mark79)
    - Docker metrics exposed to Prometheus can be seen at: [**`http://192.168.99.202:9323/metrics`**](http://192.168.99.202:9323/metrics)
    - Node exporter metrics exposed to Prometheus can be seen at: [**`http://192.168.99.201:9100/metrics`**](http://192.168.99.201:9100/metrics) and [**`http://192.168.99.202:9100/metrics`**](http://192.168.99.202:9100/metrics)
    - Prometheus configuration can be seen at: [**`http://192.168.99.203:9090/targets`**](http://192.168.99.203:9090/targets)
