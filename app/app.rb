#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#



require './app/datastore.rb'
require './app/registry.rb'


sensors = [
  Sensor.new("s1", "temperature", "room temperature", "C"),
  Sensor.new("s2", "pressure", "pressure temperature", "Pa")
]

db = InMemoryDataStore.new(sensors)

Registry.set :db, db
Registry.set :bind, '0.0.0.0'

run Registry.run!
