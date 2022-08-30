# kubespray-HAProxy-keepalived-
configure k8s cluster with kubespray and haproxies with vrrp and keepalived.
![2018120518452648](https://user-images.githubusercontent.com/73755890/187443013-46de4c0f-e8fa-4b61-9ded-96964020a9a6.png)

Our VMs : Master1, Master2, Master3, Worker1, Worker2, Loadbalancer1, LoadBalancer2

Firsty we configure our Load Balancers

1) 1.On each node:
![image](https://user-images.githubusercontent.com/73755890/187444510-1723b53d-650c-44d9-b117-3dfcf8439154.png)

2. After that configure on each LB nodes script for checking apiserver:
 ![image](https://user-images.githubusercontent.com/73755890/187444778-520c4fa7-7c43-4259-b663-1ab93092abb3.png)
configuration file: check_apiserver.sh

3. Keepalived configution on LB nodes:
![image](https://user-images.githubusercontent.com/73755890/187444969-c220622a-def7-4dbc-bc0a-0c7319378492.png)
configuration file: keepalived.conf

4. After that we must enable keepalived and configure haproxy.cfg file
systemctl enable --now keepalived
vim /etc/haproxy/haproxy.cfg 
![image](https://user-images.githubusercontent.com/73755890/187445601-d8606338-dc7a-4d7e-9053-a6a2959ee739.png)
Configuration of haproxy in haproxy.cfg

5. After that 
systemctl enable haproxy && systemctl restart haproxy
![image](https://user-images.githubusercontent.com/73755890/187447323-556b066c-aae5-4730-9454-9c043953e2b7.png)

6. Our Load Balancers are configured. We go to our ansible host and preparate for kubespray
![image](https://user-images.githubusercontent.com/73755890/187447702-53f7ecc7-8576-48f4-8f94-d71878800075.png)

7. Kubespray configuration
![image](https://user-images.githubusercontent.com/73755890/187448164-f439ebcc-1042-466e-a317-ed95c3c09aaa.png)

8. Our host.yaml configuration 
 vim inventory/mycluster/hosts.yaml
 ![image](https://user-images.githubusercontent.com/73755890/187448424-ab99d0b8-243c-467c-94a3-f78b851bb89f.png)
Configuration file: host.yaml

9. After that we configure inventory/mycluster/group_vars/all/all.yml
   Configure all.yml file with this configuration
   ![image](https://user-images.githubusercontent.com/73755890/187449110-c76ebb25-f81b-4956-a266-c00355ea9031.png)
192.168.180.25( This is our virtual IP address of HA Proxies)

Okey after that run it : 

ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml

#but please note you must create ssh-keygen and with tool ssh-copy-id send keys to your ansible-clients( K8S nodes)

 
