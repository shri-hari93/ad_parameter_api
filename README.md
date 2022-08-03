# AD_PARAMETER_API

The Application consist of

- rake task
- web server

The rake task will transform the given configuration.xml to protobuf and prints the output in STDOUT. The web server is a simple rails api which returns json Object of placements with a creative, when particular placement is requested

## SETUP

### Pre-requsite

- Rails 7, Ruby 3.1.2, Postgres 12+

### Steps for Installation

- Clone the repository
- In the root directory ```bundle install```
- Create postgres user role and update it accordingly in ```config/database.yml```
- Setup your database with necessary tables and development data using ```rake db:setup```

### Steps for rake task

- After Installation, run the rake task using ```rake ad_parameter_task``` in the root directory
- To transform a new dashboard configuration file, add the ```*.xml``` to folder dashboard_configurations in the root directory
- Re-run the rake task after adding the new configuration file

### Steps for Web Server

- Start the server using ```rails s``` command
- To check the service, make an api get request to the endpoint "http://localhost:3000/placements/plc-1"

### Steps for tests

- Run the specs, run ```rspec``` in the root directory

### Files to look for rake task

    .
    ├── lib
        ├── ad_parameter.rb
        ├── currency_conversion.rb            
        ├── task                       
            ├── ad_parameter_task.rake          # Rake task

