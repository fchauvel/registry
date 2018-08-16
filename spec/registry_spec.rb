#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#



require "rack/test"

require "./app/registry.rb"
require "./app/datastore.rb"



describe 'Registry ' do
  include Rack::Test::Methods

   
  let(:app) {
    sensors = [
      Sensor.new("s1", "temperature", "room temperature", "C"),
      Sensor.new("s2", "pressure", "room pressure", "Pa")
    ]
    Registry.set :db, InMemoryDataStore.new(sensors)
    Registry.new
  }

  
  context 'GET /sensapp/registry/about' do

    let(:response) { get 'sensapp/registry/about' }
    
    it 'returns 200 OK' do
      expect(response.status).to eq(200)
    end
    
  end


  context 'GET /sensapp/sensors/' do

    let (:response) { get 'sensapp/sensors/' }

    it 'returns all available sensors' do
      expect(response.status).to eq(200)
      expect(response.headers["Content-Type"]).to eq("application/json")

      sensors = JSON.parse(response.body)
      expect(sensors.length).to eq 2

      expect(sensors[0]["name"]).to eq "temperature"
      expect(sensors[1]["name"]).to eq "pressure"
    end
    
  end


  context 'GET /sensapp/sensors/s1' do

    let (:response) { get 'sensapp/sensors/s1' }

    it "returns the metadata of s1" do
      sensor = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(sensor["name"]).to eq("temperature")
    end
    
  end

  
  context 'GET /sensapp/sensors/unknown-sensor' do

    let (:response) {
      get '/sensapp/sensors/unknown-sensor'
    }
      
    it 'retunrs  404 Not Found' do
      expect(response.status).to eq 404
    end
    
  end
  

  context 'POST my-sensor at /sensapp/sensors' do
    
    before(:each) do
      data = { 'id': '12345',
               'name': 'my-sensor',
               'description': 'some description',
               'unit': 's'
             }
      post '/sensapp/sensors/', JSON.generate(data)
    end

    
    it 'returns 200 OK' do
      expect(last_response.status).to eq 200
    end

    
    it 'make my-sensor available at /sensapp/12345' do
      get '/sensapp/sensors/12345'
      expect(last_response.status).to eq 200
 
      data = JSON.parse(last_response.body)
      expect(data["name"]).to eq "my-sensor"
    end
    
  end

end
