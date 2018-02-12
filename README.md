# [BOSH](https://bosh.io/) Release for [Traefik](https://traefik.io)

## Usage

This BOSH release is currently in dev. To use it:

```sh
make release
bosh upload-release
```

## Know Issues

Currently when using traefik behind a loadbalancer e.g. AWS ELB. It will likely fail to validate your cert request. This is because traefik attempts to generate the cert at startup time but the load balancer has not yet marked the instance as online. In this scenario you will need to restart all traefik instances after the loadbalancer has state that they are `in service`.

If a restart does not work, try running:

**Note**: Only run this on one traefik instance.

```sh
/var/vcap/jobs/traefik/packages/traefik-consul/bin/consul kv delete traefik/acme/account/object
/var/vcap/jobs/traefik/packages/traefik-consul/bin/consul kv delete traefik/acme/account/lock
```

and then restarting the traefik services with monit on each server.

### Possible (nasty) workaround IaaS loadbalancer health check issues

1. Configure your security group to also allow ssh
1. Configure health checks to use TCP port `22`.
1. Once cert has been generated change healthcheck back to `80`.
1. Remove TCP `22` from your security group

This is definitely a nasty workaround but it gives the load balancer the opportunity to detect the health of the VM before jobs have been deployed. If you don't revert the healthcheck to port 80 then if traefik ever has an operational issue you will route traffic to a VM that cannot do anything with it.
