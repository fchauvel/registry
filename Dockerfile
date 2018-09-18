#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#

FROM ruby:2.5.1-alpine3.7

LABEL maintainer "franck.chauvel@sintef.no"

WORKDIR /registry
COPY . /registry

# Install the tools and
RUN apk add --no-cache build-base mariadb-dev \ 
    && gem install bundler \
    && bundler install --without test . \
    && apk del build-base
    	
# Run sensapp-storage
CMD ["ruby", "app/app.rb"]

