# [BOSH](https://bosh.io/) Release for [Traefik](https://traefik.io)

## Usage

This BOSH release is currently in dev. To use it:

```sh
bosh create-release
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
