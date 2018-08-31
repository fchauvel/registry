#
# SensApp::Registry
#
# Copyright (C) 2018 SINTEF Digital
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.
#


require 'sinatra/base'


class Registry < Sinatra::Base

  
  get '/registry/about' do
     "SensApp::Registry -- v0.0.0 (MIT)
      Copyright (C) SINTEF 2018"
  end

  
  get '/sensors/' do
    sensors = settings.db.find_all_sensors()
    content_type :json
    return sensors.map {|s| s.to_hash }.to_json
  end


  post '/sensors/' do
    payload = JSON.parse request.body.read.to_s
    sensor = Sensor.from_json(payload)
    settings.db.insert(sensor)
    content_type :json
    sensor.to_hash.to_json
  end

  
  get '/sensors/:id' do
    begin
      sensor = settings.db.find_by_id(params[:id].to_i)
      content_type :json
      return sensor.to_hash.to_json
    rescue
      status 204
    end
  end

  

end


