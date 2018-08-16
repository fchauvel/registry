#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#


class Sensor

  attr_reader :id, :name, :description, :unit
  
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
    raise "Should be overriden!"
  end

  def find_all()
    raise "Should be overriden!"
  end

end



class InMemoryDataStore < DataStore


  def initialize(sensors)
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
    @sensors[sensor.id] = sensor
  end

  
  def count
    @sensors.length
  end
  
end
  
        
