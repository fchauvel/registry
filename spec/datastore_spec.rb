#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#



require "./app/datastore.rb"



describe InMemoryDataStore do

  
  before do
    data = [
      Sensor.new("s1", "temperature", "room temperature", "C"),
      Sensor.new("s2", "pressure", "pressure temperature", "Pa")
    ]
    @store = InMemoryDataStore.new(data)
  end


  context 'find_all' do
  
    it 'returns all the existing sensors' do
      sensors = @store.find_all_sensors()
      expect(sensors.length).to equal(2)
    end

  end


  context 'find_by_id' do
  
    it 'returns the sensors, whose ID matches' do
      temperature = @store.find_by_id('s1')
      expect(temperature.name).to eq('temperature')
    end

  
    it 'raises an exception when no sensor matches the given ID' do
      UNKNOWN_ID = 'unknown sensor'
      expect{
        depth = @store.find_by_id(UNKNOWN_ID)
      }.to raise_error("Unknown sensor ID '#{UNKNOWN_ID}'")
    end

  end


  context 'insert' do
  
    it 'accept new sensors, if their ID is not already taken' do
      new_sensor = Sensor.new('s3', 'new sensor', 'sense something', 'km')
      
      @store.insert(new_sensor)
      
      expect(@store.count()).to eq(3)
    end

  
    it 'rejects new sensors whose ID is already taken' do
      SENSOR_ID = 's1'
      new_sensor = Sensor.new(SENSOR_ID, 'another sensor', 'sense something else', 'unit')
      
      expect{
        @store.insert(new_sensor)
      }.to raise_error("Duplicated sensor ID '#{SENSOR_ID}'")
    end

  end

  
end
