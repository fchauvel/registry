#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#

FROM ruby:2.5.1-slim-stretch

LABEL maintainer "franck.chauvel@sintef.no"

# Update the dist and install needed tools
RUN apt-get -qq update
RUN apt-get -qq -y install git default-libmysqlclient-dev

# Fetch, build and install sensapp-storage
RUN git clone https://github.com/fchauvel/registry.git
WORKDIR registry
RUN gem install bundler
RUN bundler install --without test .

# Run sensapp-storage
CMD ["ruby", "app/app.rb"]

