
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/383771e3e7cb44de92ca28cf71bc935d)](https://app.codacy.com/app/fchauvel/registry?utm_source=github.com&utm_medium=referral&utm_content=fchauvel/registry&utm_campaign=Badge_Grade_Settings)
[![Build Status](https://travis-ci.org/fchauvel/registry.svg?branch=master)](https://travis-ci.org/fchauvel/registry)
[![Test Coverage](https://img.shields.io/codecov/c/github/fchauvel/registry.svg)](https://codecov.io/gh/fchauvel/registry)

# SensApp::Registry

The Registry offers the following end-points to manipulate the metadata of sensors

 1. `GET /registry/about` Returns some information about
    version and license. Useful as a health check.
 
 1. `GET /sensors/` Returns the metadata of all sensors
    registered so far as a JSON document.

 1. `POST /sensors/` Register a new sensor. The response
    contains the identifier the registry assigned to this new sensor. The
    payload of the POST request looks as follows:
	
		{ 
			'name': 'my-sensor',
			'description': 'A sweet little sensor',
			'unit': 's' 
		}
		
  1. `GET /sensors/:id` returns the metadata of the sensor
     with identifier `:id`. If there is no such sensor, the response
     will be a 204 (No Content).


# Testing

Registry is Sinatra application. You can run the unit tests with the command

	$> bundle exec rspec spec 
	
Alternatively, adding the option `--format documentation` shows more
details about what tests are run.


# Running the application

You can start the registry service as follows:

	$> ruby app/app.rb
	[2018-08-16 05:33:34] INFO  WEBrick 1.4.2
	[2018-08-16 05:33:34] INFO  ruby 2.5.1 (2018-03-29) [x86_64-linux]
	== Sinatra (v2.0.3) has taken the stage on 4567 for development with backup from WEBrick
	[2018-08-16 05:33:34] INFO  WEBrick::HTTPServer#start: pid=26706 port=4567
	...
	
You can quickly test whether the server is running by requesting the about page follows:

	$> curl http://localhost:4567/sensapp/registry/about/
	
Alternatively, you may also post a JSON snippet using the following command:

	$> curl -vX POST localhost:4567/sensapp/sensors/ -d @snippet.json --header "Content-type: application/json"
	


