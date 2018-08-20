#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#



require 'mysql2'



class Sensor

  attr_reader :name, :description, :unit
  attr_accessor :id
  
  def initialize(id, name, description, unit)
    @id = id
    @name = name
    @description = description
    @unit = unit
  end

  def to_hash
    {"id" => @id,
     "name" => @name,
     "description" => @description,
     "unit" => @unit }
  end

  def self.from_json(hash)
       Sensor.new(hash["id"],
                  hash["name"],
                  hash["description"],
                  hash["unit"])
  end

end



class DataStore

  def find_by_id(id)
    raise 'Should be overriden!'
  end

  def find_all_sensors()
    raise 'Should be overriden!'
  end

  def insert(sensor)
    raise 'Should be overriden!'
  end

  def count()
    raise 'Should be overriden!'
  end

end



class InMemoryDataStore < DataStore


  def initialize(sensors)
    @last_id = 0
    @sensors = {}
    sensors.each{ |s| @sensors[s.id] = s }
  end


  def find_by_id(id)
    if @sensors.key? id
    then
      return @sensors[id]
    end
    raise "Unknown sensor ID '#{id}'"
  end


  def find_all_sensors
    sensors = []
    @sensors.each{ |id, s| sensors.append(s) }
    sensors
  end


  def insert(sensor)
    if @sensors.key? sensor.id
    then
      raise "Duplicated sensor ID '#{sensor.id}'"
    end
    @last_id += 1
    sensor.id = @last_id
    @sensors[sensor.id] = sensor
  end


  def count
    @sensors.length
  end

end



class MySQLDataStore < DataStore

  def initialize(settings)
    @db = Mysql2::Client.new(:host => settings.db_host,
                             :port => settings.db_port,
                             :username => settings.db_user,
                             :password => settings.db_password)
    @db.query("CREATE DATABASE IF NOT EXISTS #{settings.db_name};")
    @db.select_db(settings.db_name)
    @db.query('CREATE TABLE IF NOT EXISTS sensors (id MEDIUMINT NOT NULL AUTO INCREMENT,' +
              'name VARCHAR(50), description VARCHAR(200), ' +
              'unit VARCHAR(5), PRIMARY KEY(id));')
  end

  def find_by_id(id)
    records = @db.query("SELECT * FROM sensors WHERE id = '#{id}';")
    if records.count == 1
    then
      return Sensor.from_json(records.first)
    end
    raise "Invalid database, several sensors have ID '#{id}'"
  end

  
  def find_all_sensors()
    sensors = []
    result = @db.query('SELECT * FROM sensors;')
    result.each{ |entry| sensors.append(Sensor.from_json(entry)) }
    return sensors
  end

  def insert(sensor)
    query = "INSERT into sensors VALUES ('#{sensor.name}'," +
            "'#{sensor.description}', '#{sensor.unit}');"
    result = @db.query(query)
    sensor.id = @db.last_id
  end


  def count
    return 1
  end


end
