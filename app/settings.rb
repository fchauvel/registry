#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#


require 'optparse'





class Settings

  attr_reader :db_host, :db_port, :db_name, :db_user, :db_password
  
  def initialize()
    @db_host = '127.0.0.1'
    @db_port = 3306
    @db_name = 'sensapp_registry'
    @db_user = 'root'
    @db_password = '123456'
  end

  def from_command_line
    OptionParser.new do |opt|
      opt.on("-h", "--db-host [HOSTNAME]", "set the host where the database server runs") do
        |o| @db_host = o
      end
      opt.on("-p", "--db-port [PORT]", Integer, "set the port where the database server listen") do
        |o| @db_port = o
      end
      opt.on("-n", "--db-name [DB_NAME]", "set the name of the database to use") do
        |o| @db_name = o
      end
      opt.on("-u", "--db-user [USERNAME]", "set the username to use with the DB") do
        |o| @db_user = o
      end
      opt.on("-w", "--db-password [PWD]", "set the password to use with the DB") do
        |o| @b_password = o
      end
    end.parse!    
  end

end
