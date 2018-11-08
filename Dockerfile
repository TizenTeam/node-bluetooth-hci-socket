#!/bin/echo docker build . -f
# -*- coding: utf-8 -*-
# SPDX-License-Identifier: MPL-2.0
#{
# Copyright: 2018-present Samsung Electronics France SAS, and other contributors
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.*
#}

FROM node:8-stretch
MAINTAINER Philippe Coval (p.coval@samsung.com)

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANG ${LC_ALL}


RUN echo "#log: Setup system" \
  && set -x \
  && apt-get update -y \
  && apt-cache search npm \
  && apt-get install -y \
  libudev-dev \
  && apt-get clean \
  && sync

ENV project node-bluetooth-hci-socket
ADD . /usr/local/opt/${project}/src/${project}
WORKDIR /usr/local/opt/${project}/src/${project}
RUN echo "#log: ${project}: Preparing sources" \
  && set -x \
  && which npm \
  && npm --version \
  && npm install \
  && npm run test || echo "TODO: check package.json" \
  && sync

WORKDIR /usr/local/opt/${project}/src/${project}
ENTRYPOINT [ "/usr/local/bin/npm"]
CMD [ "run", "test" ]
