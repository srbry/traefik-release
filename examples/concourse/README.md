# Using Traefik with Concourse

[Concourse](http://concourse.ci/) is a great use case for Traefik. You want to have your CI server secure but you don't want to have to pay for an SSL cert and configure it.

The `ops-file.yml` in this directory can be used to colacate traefik and consul on the web nodes of your [concourse deployment](https://github.com/concourse/concourse-deployment/tree/master/cluster).

The ops file currently expects:

A cloud config including:

1. `traefik-network-properties` as a VM extension using a load balancer.
1. `traefik-sec-group` as a security group allowing access to your VMs on ports: `80`, `8080` and `443`

IAAS config:

1. An iaas loadbalancer listening on `80` and `443`, with health checks configured on `80` with the shortest possible check times. The longer this is the more likely you are to hit the `known issues` described in the main [README](../../README.md) of this project.
1. DNS pointing at your iaas loadbalacer
1. Inbound security groups on your loadbalancer on ports: `80` and `443`
