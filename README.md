# SensApp::Registry

Manage the sensors' metadata


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
	


