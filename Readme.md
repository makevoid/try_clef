# Clef example Sinatra app

No backend, users are stored in memory so you can plug in your favourite backend

code from the dafult docs: http://docs.getclef.com/v1.0/docs/sinatra
and from the example repo: https://github.com/clef/sample-ruby - https://github.com/clef/sample-ruby/blob/master/app.rb

### Setup

Set up and configure an app on Clef: https://getclef.com/team/applications

Set up the config/clef.rb file

    cp ./config/clef.rb.default ./config/clef.rb

    vim ./config/clef.rb

and set both the client ID and SECRET.

then...

Install the dependencies:

    bundle

### Run it!

    rackup

then connect to <http://localhost:9292>

#### TODO:

- refactor clef_hook
- move all the login/logout/user routes in lib
- implement logout check / hook
