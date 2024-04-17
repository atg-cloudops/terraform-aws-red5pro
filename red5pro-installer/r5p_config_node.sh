#!/bin/bash
############################################################################################################
# 
############################################################################################################

# SM_IP
# NODE_CLUSTER_KEY

RED5_HOME="/usr/local/red5pro"

log_i() {
    log
    printf "\033[0;32m [INFO]  --- %s \033[0m\n" "${@}"
}
log_d() {
    log
    printf "\033[0;33m [INFO]  --- %s \033[0m\n" "${@}"
}
log_w() {
    log
    printf "\033[0;35m [WARN] --- %s \033[0m\n" "${@}"
}
log_e() {
    log
    printf "\033[0;31m [ERROR]  --- %s \033[0m\n" "${@}"
}
log() {
    echo -n "[$(date '+%Y-%m-%d %H:%M:%S')]"
}

config_node(){
    log_i "Config NODE"
    
    if [ -z "$SM_IP" ]; then
        log_w "Parameter SM_IP is empty, EXIT"
        exit 1
    fi
    if [ -z "$NODE_CLUSTER_KEY" ]; then
        log_e "Parameter NODE_CLUSTER_KEY is empty. EXIT."
        exit 1
    fi
    
    local ip_pattern='http://0.0.0.0:5080/streammanager/cloudwatch'
    local ip_new="http://${SM_IP}:5080/streammanager/cloudwatch"
    local autoscale_pattern='<property name="active" value="false"/>'
    local autoscale_true='<property name="active" value="true"/>'
    
    sed -i -e "s|$ip_pattern|$ip_new|" -e "s|$autoscale_pattern|$autoscale_true|" "$RED5_HOME/conf/autoscale.xml"
    
    local sm_pass_pattern='<property name="password" value="changeme" />'
    local sm_pass_new='<property name="password" value="'${NODE_CLUSTER_KEY}'" />'
    
    sed -i -e "s|$sm_pass_pattern|$sm_pass_new|" "$RED5_HOME/conf/cluster.xml"
}

install_crowdstrike_falconsensor(){
      cd /tmp/
      sudo curl -o /tmp/falcon-sensor_7.13.0-16604_amd64.deb https://pxb-public-assets.s3.amazonaws.com/installers/falcon-sensor_7.13.0-16604_amd64.deb
      sudo dpkg -i falcon-sensor_7.13.0-16604_amd64.deb
      sudo /opt/CrowdStrike/falconctl -s --cid=B5C2D39EE4BD4F0B92A44523FF317F16-BA --tags="Measured,prod,Node,Red5,PXB"
      sudo systemctl restart falcon-sensor
}

config_node
install_crowdstrike_falconsensor