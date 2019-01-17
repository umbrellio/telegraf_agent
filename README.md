# TelegrafAgent

[![Build Status](https://travis-ci.org/umbrellio/telegraf_agent.svg?branch=master)](https://travis-ci.org/umbrellio/telegraf_agent)
[![Coverage Status](https://coveralls.io/repos/github/umbrellio/telegraf_agent/badge.svg?branch=master)](https://coveralls.io/github/umbrellio/telegraf_agent?branch=master)
[![Gem Version](https://badge.fury.io/rb/telegraf_agent.svg)](https://badge.fury.io/rb/telegraf_agent)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'telegraf_agent'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install telegraf_agent

## Usage

```ruby
logger = Logger.new(STDOUT)
agent = TelegrafAgent.new(url: "udp://localhost:3030", logger: logger)
agent.write("SuperProject", keys: { env: Rails.env }, values: { action: "index", duration: 0.2 })
```
