# Dockerfile for Juman++ and KNP

[![build-push-jumanpp-knp](https://github.com/ku-nlp/dockerfile-jumanpp-knp/actions/workflows/build-push-jumanpp-knp.yml/badge.svg)](https://github.com/ku-nlp/dockerfile-jumanpp-knp/actions/workflows/build-push-jumanpp-knp.yml)

This project automatically builds and pushes Docker images of [Juman++](https://github.com/ku-nlp/jumanpp) and [KNP](https://github.com/ku-nlp/knp).

|       | Juman++ | KNP | Juman++/KNP |
|-------|---------|-----|-------------|
| pulls | ![Docker Pulls](https://img.shields.io/docker/pulls/kunlp/jumanpp) | ![Docker Pulls](https://img.shields.io/docker/pulls/kunlp/knp) | ![Docker Pulls](https://img.shields.io/docker/pulls/kunlp/jumanpp-knp) |
| size  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kunlp/jumanpp/ubuntu) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kunlp/knp/ubuntu) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kunlp/jumanpp-knp/ubuntu) |

## DockerHub Links

- [kunlp/jumanpp](https://hub.docker.com/repository/docker/kunlp/jumanpp)
- [kunlp/knp](https://hub.docker.com/repository/docker/kunlp/knp)
- [kunlp/jumanpp-knp](https://hub.docker.com/repository/docker/kunlp/jumanpp-knp)

## Authors/Contact

京都大学 黒橋・褚・村脇研究室 (contact **at** nlp.ist.i.kyoto-u.ac.jp)
- Nobuhiro Ueda <ueda **at** nlp.ist.i.kyoto-u.ac.jp>

## Reference

- [buildx/buildx_build.md at master · docker/buildx](https://github.com/docker/buildx/blob/master/docs/reference/buildx_build.md)
- [build-push-action/docs/advanced at master · docker/build-push-action](https://github.com/docker/build-push-action/tree/master/docs/advanced)
