# Dockerfile for Juman++, KNP, and KWJA

[![build-push-jumanpp-knp-kwja](https://github.com/ku-nlp/dockerfile-jumanpp-knp/actions/workflows/build-push-jumanpp-knp-kwja.yml/badge.svg)](https://github.com/ku-nlp/dockerfile-jumanpp-knp/actions/workflows/build-push-jumanpp-knp-kwja.yml)

This project automatically builds and pushes Docker images of [Juman++](https://github.com/ku-nlp/jumanpp), [KNP](https://github.com/ku-nlp/knp), and [KWJA](https://github.com/ku-nlp/kwja).

|       | Juman++                                                                      | KNP                                                                      | KWJA                                                                      | Juman++/KNP                                                                      | Juman++/KNP/KWJA                                                                      |
|-------|------------------------------------------------------------------------------|--------------------------------------------------------------------------|---------------------------------------------------------------------------|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|
| Pulls | ![Docker Pulls](https://img.shields.io/docker/pulls/kunlp/jumanpp)           | ![Docker Pulls](https://img.shields.io/docker/pulls/kunlp/knp)           | ![Docker Pulls](https://img.shields.io/docker/pulls/kunlp/kwja)           | ![Docker Pulls](https://img.shields.io/docker/pulls/kunlp/jumanpp-knp)           | ![Docker Pulls](https://img.shields.io/docker/pulls/kunlp/jumanpp-knp-kwja)           |
| Size  | ![Image Size](https://img.shields.io/docker/image-size/kunlp/jumanpp/latest) | ![Image Size](https://img.shields.io/docker/image-size/kunlp/knp/latest) | ![Image Size](https://img.shields.io/docker/image-size/kunlp/kwja/latest) | ![Image Size](https://img.shields.io/docker/image-size/kunlp/jumanpp-knp/latest) | ![Image Size](https://img.shields.io/docker/image-size/kunlp/jumanpp-knp-kwja/latest) |

## DockerHub Links

- [kunlp/jumanpp](https://hub.docker.com/repository/docker/kunlp/jumanpp)
- [kunlp/knp](https://hub.docker.com/repository/docker/kunlp/knp)
- [kunlp/kwja](https://hub.docker.com/repository/docker/kunlp/kwja)
- [kunlp/jumanpp-knp](https://hub.docker.com/repository/docker/kunlp/jumanpp-knp)
- [kunlp/jumanpp-knp-kwja](https://hub.docker.com/repository/docker/kunlp/jumanpp-knp-kwja)

## Authors/Contact

京都大学 黒橋・褚・村脇研究室 (contact **at** nlp.ist.i.kyoto-u.ac.jp)

- Nobuhiro Ueda <ueda **at** nlp.ist.i.kyoto-u.ac.jp>

## Reference

- [buildx/buildx_build.md at master · docker/buildx](https://github.com/docker/buildx/blob/master/docs/reference/buildx_build.md)
- [build-push-action/docs/advanced at master · docker/build-push-action](https://github.com/docker/build-push-action/tree/master/docs/advanced)
