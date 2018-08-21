#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#

require './app/settings.rb'
require './app/datastore.rb'
require './app/registry.rb'
require './app/info.rb'
require './app/utils.rb'

settings = Settings.new
settings.from_command_line

db = MySQLDataStore.new(settings)
with_retry(FOREVER) {
  db.connect
}


Registry.set :db, db
Registry.set :bind, '0.0.0.0'

puts "#{About::PROGRAM} v#{About::VERSION} (#{About::LICENSE})"
puts "#{About::COPYRIGHT}"

run Registry.run!
