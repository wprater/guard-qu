# Guard::Qu

Guard::Qu automatically starts/stops/restarts qu workers

*forked from [Guard::Resque](http://github.com/railsjedi/guard-resque)*

## Install

Please be sure to have [Guard](http://github.com/guard/guard) installed before continue.

Install the gem:

    gem install guard-qu

Add it to your Gemfile (inside test group):

    gem 'guard-qu'

Add guard definition to your Guardfile by running this command:

    guard init qu

## Usage

Please read [Guard usage doc](http://github.com/guard/guard#readme).

I suggest you put the qu guard definition *before* your test/rspec guard if your tests depend on it
being active.

## Guardfile

    guard 'qu', :environment => 'development' do
      watch(%r{^app/(.+)\.rb$})
      watch(%r{^lib/(.+)\.rb$})
    end

Feel free to be more specific, for example watching only for `app/models` and `app/jobs`
to avoid reloading on a javascript file change.

## Options

You can customize the qu task via the following options:

* `environment`: the rails environment to run the workers in (defaults to `nil`)
* `task`: the name of the rake task to use (defaults to `"qu:work"`)
* `queue`: the qu queue to run (defaults to `"default"`)
* `trace`: whether to include `--trace` on the rake command (defaults to `nil`)
* `stop_signal`: how to kill the process when restarting (defaults to `TERM`)


## Development

 * Source hosted at [GitHub](http://github.com/wprater/guard-qu)
 * Report issues/Questions/Feature requests on [GitHub Issues](http://github.com/wprater/guard-qu/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.


## Guard::Delayed Authors

[David Parry](https://github.com/suranyami)
[Dennis Reimann](https://github.com/dbloete)

Ideas for this gem came from [Guard::WEBrick](http://github.com/fnichol/guard-webrick).


## Guard::Qu Authors

[Will Prater](https://github.com/wprater)

I hacked this together from the `guard-resque` gem for use with Qu. All credit go to the original authors.

