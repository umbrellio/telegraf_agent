# TelegrafAgent

[![Build Status](https://travis-ci.org/umbrellio/telegraf_agent.svg?branch=master)](https://travis-ci.org/umbrellio/telegraf_agent)
[![Coverage Status](https://coveralls.io/repos/github/umbrellio/telegraf_agent/badge.svg?branch=master)](https://coveralls.io/github/umbrellio/telegraf_agent?branch=master)
[![Gem Version](https://badge.fury.io/rb/telegraf_agent.svg)](https://badge.fury.io/rb/telegraf_agent)

Class for sending data to the telegraf server.

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

Just initialize an agent like:


```ruby
logger = Logger.new(STDOUT)
url = "tcp://localhost:1234"
agent = TelegrafAgent.new(url: url, logger: logger)
```

Logger param is optional.

And then use:

```ruby
tags = { env: Rails.env }
values = { action: "index", duration: 0.2 }
agent.write("SuperProject", tags: tags, values: values)
```
All params are required.

## License
Released under MIT License.

## Authors
Created by Aleksey Bespalov.

<a href="https://github.com/umbrellio/">
  <img style="float: left;" src="https://umbrellio.github.io/Umbrellio/supported_by_umbrellio.svg" alt="Supported by Umbrellio" width="439" height="72">
</a>
