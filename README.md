Rokkin
======

A fast and simple way to isolate development environments for ruby applications using Docker \m/

*Super-duper alpha software.  You've been warned.*

Background
----------

You have a rack-based application (rails, sinatra, etc), but setting up and maintaining development environments is a chore.  Everyone says containers are the wave of the future, but you're not sure of the investment.  But the last new hire took a whole week to get their laptop setup and you're getting worried ...

Features
--------

+ Super simple config - just edit 4 text files and your `database.yml`
+ Uses ddollar/foreman to start/stop/restart/kill your apps gracefully
+ Uses bkeepers/dotenv to separate out your database configuration from source control
+ Uses docker/fig to easily setup and manage complex container environments
+ Properly caches gems for you so you only have to reinstall when your `Gemfile.lock` changes
+ Multiple databases preconfigured for you out of the box
+ Works on non-Linux OSes via boot2docker
+ 100% compatible with Heroku environments (untested statement)
+ Devops recommended! (untested statement)

Quick Start
-----------

+ [Install docker](http://docs.docker.com/installation/) and/or [boot2docker](http://boot2docker.io/).  On OS X I prefer caskroom/homebrew-cask: `brew cask install boot2docker`
+ `gem install rokkin`
+ In an existing app directory, run `rokkin containerize`
+ For a new repo, `rokkin clone github.com:/Username/my_repo.git`
+ Change the ruby version on the top of `Dockerfile`
+ Configure `fig.yml` to match your app's databases and services.  The example are pretty straightforward and feel free to delete unused services.
+ Configure `Procfile` to match the commands used to start your app's services.
+ Configure `.env` to match the services exposed by `fig.yml`.
+ Modify your app to use the database connection params listed in `.env`.  For rails, look at `database.yml`
+ If you're on rails, add `dotenv-rails', require: 'dotenv/rails-now'` to your `Gemfile`.  If you're not, you'll need to run `dotenv` before running commands: `fig run web dotenv ruby some_file.rb`
+ Build the containers: `fig build`
+ Launch the containers: `fig up`
+ Setup your databases: `fig run web db:create db:migrate`
+ Browse your app (the ip is `boot2docker ip` and the port is specified in `fig.yml`)

Developer Workflow
------------------

+ `boot2docker up`
+ `$(boot2docker shellinit)`
+ `fig up`
+ :sparkles::sparkles::sparkles: Write code like normal :sparkles::sparkles::sparkles:
+ If you edit your `Gemfile`:
  - `bundle`
  - `fig build`
  - `fig up`
+ Opening a console: `fig run web rails console`
+ Connecting to a database: `fig run web redis-cli`

FAQ
===

+ Where are my containers located?
  - Somewhere in boot2docker.  I'd try `boot2docker ssh` and poke around docker directly: `docker ps`
+ Where are the database files located?  How can I map them to my host machine?
  - I looked into this but couldn't figure it out.  I'll figure it out eventually.

Nota Bene
---------
+ [Specify your ruby version in Gemfile](http://bundler.io/gemfile.html)
+ [Should you commit `.env` to version control?](https://github.com/bkeepers/dotenv#should-i-commit-my-env-file)
+ If you modify your `Gemfile`, run `bundle` and then `fig build` to rebuild your containers.
+ If you're running a command through `fig run`, you might want to use `dotenv` to load the right environment variables: `fig run service dotenv command`
+ *SUPER DUPER ALPHA SOFTWARE*
