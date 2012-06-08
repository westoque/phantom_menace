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

Run the example by doing.

```sh
bundle exec ruby examples/simple.rb
```
