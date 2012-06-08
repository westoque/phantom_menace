# phantom-menace

A real headless "browser." It uses phantomjs and provides an API like a
real browser does. Much like poltergeist but decoupled from capybara.

At the heart of *phantom-menace* is a run loop
inside the phantomjs script that makes it synchronous.

It is perfect for scraping or doing any browser related tasks.

## Install

```sh
gem install phantom-menace
```

## Getting Started

You have to run the phantomjs server first. This server accepts JSON
commands.

```sh
phantom_menace
```

You can then run a quick example:

```ruby
require "phantom_menace"

browser = PhantomMenace::Browser.new
browser.goto "http://facebook.com"
links = browser.find_all_links
links.each do |link|
  link.attributes["href"]
end
```

## Running The Example

When the server is running, run the example by doing.

```sh
bundle exec ruby examples/simple.rb
```

## Running The Tests

Unfortunately, we still don't have an automated test suite to run the
different services.

We have to run three things.

1. The `phantom_menace` binary

```sh
bundle exec ./bin/phantom_menace
```

2. The sinatra test server - This serves the files needed for the tests
   instead of hitting third party sites. This ensures that we can run
   the tests without internet.

```sh
bundle exec ruby ./spec/test_server/server.rb
```

3. Finally we can run the specs

```sh
bundle exec rake spec
```
