# Rust SSG

This repository is for building a utility docker image to be used with `fleek`.
Utilities include:

- [Zola](https://getzola.org)
- [mdBook](https://rust-lang.github.io/mdBook/index.html)

## Fleek

When using `fleek` to deploy a site, it is possible to use a custom `docker`
image, however `fleek` makes assumptions about the custom `docker` image.

Particularly, `fleek` assumes that the `docker` image does not contain a
default `ENTRYPOINT`, which if trying to use the default `zola` `docker` images
errors appear referencing the use of `/bin/sh` as a parameter to `zola`.

This `docker` image only packages the tools that are used and does so by
pulling them from upstream `docker` images.
