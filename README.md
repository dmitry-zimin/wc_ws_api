Words Count and Statistic API on Sinatra + MongoDB + Sidekiq
===========================================================

#Instructions

- Run the following commands to get started

1) gem install bundler
2) bundle install
3) brew services start mongodb              # if you have one, if not please install through brew
4) brew services start redis                # if you have one, if not please install through brew
5) /usr/local/bin/sidekiq -r /wc_server.rb  # to start sidekiq run  
6) ruby wc_server.rb                        # start app run 