Words Count and Statistic API on Sinatra + MongoDB + Sidekiq
===========================================================

#Instructions

- Run the following commands to get started

1) gem install bundler
2) bundle install
3) brew services start mongodb              # if you have one, if not please install through brew
4) brew services start redis                # if you have one, if not please install through brew
5) /usr/local/bin/sidekiq -r /wc_server.rb  # to start sidekiq run  
6) rake db:create_indexes
7)  ruby wc_server.rb                        # start app run 

#Endpoints 

    A 'word_counter' endpoint
    
   example to send data you can use curl 
   
    curl -i -X POST -H "Content-Type: application/json" -d'{"input_source":{ "url":"https://raw.githubusercontent.com/dmitry-zimin/wc_ws_api/init_phase/files/url_testfile.txt" } }' http://localhost:4567/api/v1/word_counter
    
   
    A 'word_statistics' endpoint returns count if word exist and message if not
   
   example 
    
    http://localhost:4567/api/v1/word_statistics/who
  
  
   - My assumptions about current realisation 
   
As we have no detailed specs for API, I've got all the freedom of actions
So input structure for endpoints I have chosen by my self
   
   Input for word_counter endpoint should be well organized.
   For now we will say that we expect only one input source.
   possible inputs
  
   {
     "text": "Hi! My name is (what?), my name is (who?), my name is Slim Shady",
     "file_path": "path",
     "url": "url_path"
   }
  
   request body example
  
   { "input_source": { "text": "Hi! My name is (what?), my name is (who?), my name is Slim Shady" } }
  
   I've decided that endpoint will not wait until the data will be processed,
   so we will validate input_source and then send a status,
   400 if json body not valid, 422 if input_source not valid, 200 if yes.
   Text will be processed in worker which is implemented using Sidekiq
   
   The only unclear thing is about file_path, it could be through FormData, 
   or we need to discuss it and finish that part, now it is working with dummy file name which 
   preloaded file.