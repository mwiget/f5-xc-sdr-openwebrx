# F5 Distributed Cloud SDR OpenWebRX Demo

## Requirements

- SDR Hardware receiver, e.g. RTL-SDR USB sticks or HackRF One
- [OpenWebRX multi-user SDR receiver](https://www.openwebrx.de)
- Kubernetes cluster with an x86_64 based node with a USB port to connect the SDR receiver
- [F5 Distributed Cloud Service Account](https://f5.com/cloud) (F5XC).
Click 'Sign Up' for a free individual account for Distributed apps in our network or across cloud or edge.
- DNS domain to delegate prefix to F5 Distributed Cloud Service (F5XC)

## Installation

### SDR receiver and OpenWebRX

Clone the repo [https://github.com/mwiget/f5-xc-sdr-openwebrx](https://github.com/mwiget/f5-xc-sdr-openwebrx):

```
$ git clone https://github.com/mwiget/f5-xc-sdr-openwebrx
$ cd f5-xc-sdr-openwebrx
```

The manifest [openwebrx.yaml](openwebrx.yaml) deploys the web-based software defined radio receiver from 
[Docker Hub](https://hub.docker.com/r/jketterl/openwebrx) as a privileged pod with the local folder /etc/openwebrx
exposed for the configuration. Please consult the [OpenWebRX documentation](https://github.com/jketterl/openwebrx/wiki) 
on howto get the initial configuration setup, like creating user account and radio profiles. 

Start by creating a namespace for the pod, e.g. 'sdr', then apply the openwebrx manifest:

```
$ kubectl create ns sdr
$ kubectl apply -f openwebrx.yaml
```


### Register site with F5 Distributed Cloud

Download the [kubernetes site manifest](https://gitlab.com/volterra.io/volterra-ce/-/blob/master/k8s/ce_k8s.yml):

```
$ wget https://gitlab.com/volterra.io/volterra-ce/-/raw/master/k8s/ce_k8s.yml
```

Edit the manifest, search for 'CHANGE ME' and specify ClusterName (will be used as site name), Latitude and Longitude
and Site Token (you can generate and copy one in the F5XC Console, once logged in).

E.g. a filled out template (just showing the parts requiring change) is 

```
    # CHANGE ME
    ClusterName: zug-attic
    ClusterType: ce
    Config: /etc/vpm/config.yaml
    DisableModules: ["dictator", "recruiter"]
    # CHANGE ME
    Latitude: 47.16970
    # CHANGE ME
    Longitude: 8.51445
    MauriceEndpoint: https://register.ves.volterra.io
    MauricePrivateEndpoint: https://register-tls.ves.volterra.io
    PrivateNIC: eth0
    SkipStages: ["osSetup", "etcd", "kubelet", "master", "voucher", "workload", "controlWorkload"]
    # CHANGE ME
    Token: 25730e8f-88a0-41c4-af5f-07854bff8cb9
```

The kubernetes node must have at least 400 2M hugepages configured and available.

Apply the k8s manifest

```
$ kubectl apply -f ce_k9s.yml
```

Check the pod in namespace ves-system is running:

```
$ kubectl get pods -n ves-system
NAME                     READY   STATUS    RESTARTS       AGE
volterra-ce-init-c2pq4   1/1     Running   0              7m46s
vp-manager-0             1/1     Running   1 (5m7s ago)   7m23s
etcd-7d86fd7dc7-m92z2    2/2     Running   0              4m50s
ver-0                    16/16   Running   0              4m33s
```

Now log into the [F5 Distributed Cloud Console](https://f5.com/cloud), go to 'Site Management', 'Registrations'
and accept the registration request from our new site.



## SDR Hardware and OpenWebRX Software


