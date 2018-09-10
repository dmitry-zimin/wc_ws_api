Words Count and Statistic API on Sinatra + MongoDB + Sidekiq
===========================================================

## Instructions

- Run the following commands to get started

1) gem install bundler
2) bundle install
3) brew services start mongodb              # if you have one, if not please install through brew
4) brew services start redis                # if you have one, if not please install through brew
5) /usr/local/bin/sidekiq -r /word_count_app.rb  # to start sidekiq run  
6) rake db:create_indexes[development]
7) rackup config.ru                        # start app run 

- To run test
1) rake db:create_indexes[test]
2) rake spec

## Requirements
It was created and tested on MacOS High Sierra, version 10.13.5, ruby 2.3.3p222

## Endpoints 

   - 'word_counter' endpoint
    
   example, to send data you can use curl:
   
    curl -i -X POST -H "Content-Type: application/json" -d'{"input_source":{ "url":"https://raw.githubusercontent.com/dmitry-zimin/wc_ws_api/master/files/url_testfile.txt" } }' http://localhost:9292/api/v1/word_counter
    
   
   - 'word_statistics' endpoint returns count if word exist and message if not
   
   example:
    
    http://localhost:9292/api/v1/word_statistics/who
     
###Possible inputs
  
   {
     "text": "Hi! My name is (what?), my name is (who?), my name is Slim Shady",
     "file_path": "path",
     "url": "url_path"
   }
  
   request body example
  
   {"input_source": {"text": "Hi! My name is (what?), my name is (who?), my name is Slim Shady"}}
  
   Endpoint will not wait until the data will be processed
   Error statuses:
   400 if json body not valid, 422 if input_source not valid, 200 if yes.
   
   Text will be processed in worker which is implemented using Sidekiq.
   