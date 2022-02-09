# Image ready for ReactPHP (libuv) and ZeroMQ message bus library

This image is based on alpine and php, it add ZeroMQ, and some other defaults


## Building crossplatform and manifest

At this point there is no github action used for building because of dockerhub
limitation. The scripts `push_the_manifest*.sh` make it via buildkit and binfmt.

Latest binfmt I used is tonistiigi/binfmt:

> docker run --privileged --rm tonistiigi/binfmt --install all

rif. https://github.com/tonistiigi/binfmt

Previous one was the legacy from docker https://github.com/docker/binfmt

7.4 does not work. So latest bild (7.3) is built by the legacy binfmt


## Other infos

default user created is scroll, with uid 1000 git 1000

ssmtp is in this image, so use it as

```
FROM starsellersworld/reactphpzeromq:latest

COPY ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf
```

and in the build context writing a file ssmtp/ssmtp.conf like:

```
root=postmaster
mailhub=smtp.yourdomain.com
hostname="yourdomain.com"
FromLineOverride=yes
```

and `mail()` function will work
