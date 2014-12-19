Rokkin
======

A fast way to containerize your ruby webapps

Quick Start
-----------

1. Install docker (or boot2docker on OS X) and fig
2. Go to your app directory and run `git clone git@github.com:Whitespace/rokkin.git && cp rokkin/{fig.yml,Dockerfile,Procfile,.env} . && rm -rf rokkin`
3. Edit your `database.yml` to use the environment variables defined in `.env` (use `<%= ENV['DATABASE_HOST'] %>` syntax)
4. Add `gem 'dotenv-rails', require: 'dotenv/rails-now'` to your `Gemfile`
5. Quickly edit `Procfile`, `.env`, and `fig.yml` to match your app's database needs.  Commenting or deleting large blocks is recommended.
6. `fig build`
7. `fig up`
8. `fig run web db:create db:migrate`
9. Browse to `echo "$(boot2docker ip):8080"`

Detailed Installation
---------------------

0. Be on OS X
1. [Install Homebrew](http://brew.sh/)
2. `brew install boot2docker`
3. `boot2docker init`
4. `boot2docker start`
5. `$(boot2docker shellinit)` (You probably want to add this to your `.bashrc`)
6. `brew install fig`
7. `cd ~/code/my-rails-app`
8. `git clone git@github.com:Whitespace/rokkin.git && cp rokkin/{fig.yml,Dockerfile,Procfile,.env} . && rm -rf rokkin`
9. Change those files to suit your app.  Take extra care to ensure the ruby version matches the version listed in your `Gemfile`, if necessary
11. `fig up`
12. Put `echo "$(boot2docker ip) dev.com"` in your `/etc/hosts` file

also add some gems:
`gem 'dotenv-rails', '1.0.2', groups [:development, :test], require: 'dotenv/rails-now'`

Pay attention to:

Specify ruby version in Gemfile: http://bundler.io/gemfile.html
Should you commit `.env` to version control? https://github.com/bkeepers/dotenv#should-i-commit-my-env-file

Nota Bene
---------

+ If you modify your `Gemfile`, run `bundle` and then `fig build` to rebuild your containers.
+ If you're running a command through `fig run`, you might want to use `dotenv` to load the right environment variables: `fig run service dotenv command`
+ I haven't gotten the shared volumes working from the containerized database to my host machine.  I'm not sure why this isn't working :sobs:
