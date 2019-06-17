#!/bin/sh

docker run -u scroll -it -v `pwd`/tests:/home/scroll/code localreactphp sh
