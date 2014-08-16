froyo
=====

[![Build Status](https://travis-ci.org/mjgpy3/froyo.svg?branch=master)](https://travis-ci.org/mjgpy3/froyo)

Fluent Ruby Objects, Yo!

Description
===========

Firstly, let me deeply apologize to anyone looking for frozen yogurt. I feel your pain.

`froyo` is (perhaps) the simplest gem around. `froyo`'s purpose is simply to eliminate the need to return `self` as the last statement in a ruby method, and to add a formal way to specify fluent methods.

Install
=======
```
gem build froyo-<version>.gem
gem install froyo-<version>.gem
```

or, if using bundler, add the following to your `Gemfile`
```
gem 'froyo', :git => 'git:github.com/mjgpy3/froyo.git'
```


Example Usage
=============

```ruby
require 'froyo'

class FunkyStringMaker
  extend FroYo

  def initialize
    @value = ''
  end

  def appending_funky
    @value.concat('funky')
  end

  def n_times_append_monkey(n)
    n.times { @value.concat('monkey') }
  end

  def blah
    @value = 'blah ' + @value
  end

  def to_s
    @value
  end

  make_fluent :blah, :n_times_append_monkey, :appending_funky
end

FunkyStringMaker.new.
  _appending_funky.
  _n_times_append_monkey(2).
  _blah.to_s # => 'blah funkymonkeymonkey'
```

