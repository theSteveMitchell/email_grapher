# Email-Grapher

This is a simple program that uses email conversation data and displays a graph of network connections.

## Setting things up

This repository contains a Rails app with a React frontend. To get started, follow these steps:

* Install Ruby 2.6.6 (we like to use [RVM](https://rvm.io))
* Install [NVM](https://github.com/creationix/nvm).
* Run `nvm install` in the repository root.
* Install [Yarn](https://yarnpkg.com/en/docs/install) (required by Webpacker).
* Depending on your platform, you might need to install libsqlite3 for SQLite support.
* Run `bundle install` and `yarn install`.

Once everything is installed, create a copy of the `.env` file and update the created file with the Postmark Server API token you have been assigned.

``` bash
cp .env .env.local
cp .env .env.test.local
```

The `.env.local` file should looks something like this:

``` bash
POSTMARK_API_TOKEN=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

Now set up the local SQLite db:

``` bash
$ bin/rake db:setup
```

To verify that your dev environment is set up correctly, run the Rails server and open [http://localhost:3000/](http://localhost:3000/) in your browser.

``` bash
# Running the Rails server

$ bin/rails server
```

Additionally, run the Rake task that you’ll need to modify.

``` bash
$ bin/rake snapshot:take

This Rake task doesn’t do much right now. It’s only got a few pointers to get you started!
```

# Design and Approach

Initial commit included a mostly working rails app with a react app in the frontend. The app emits javascript data to the front end using a server-rendered view. This is a *bit* oldschool, but works for this usecase. 

Every react component is in the same file, which is fine, I guess.

Uses D3 to render a network graph. 

Interesting bits here include:
- adding JS tests
- commit history shows a feature addition using stubbed data in the graph initially. Follow-up commits move that back into the backend
- ConversationMap is a pretty optimal data structure for the conversation snapshots. 
- I added some rspec tests to show a useful pattern. If you're building something like this, add more tests (integration tests, please)
