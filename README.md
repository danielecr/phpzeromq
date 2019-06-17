# Image ready for ReactPHP (libuv) and ZeroMQ message bus library

This image is based on alpine and php, it add ZeroMQ, and some other defaults


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
