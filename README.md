# Chargify Command Line Client (ccl)

Uses API v1 to talk to chargify

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ccl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ccl

## Usage

    $ ccl
    Commands:
    ccl customers                                                                                           # Lists customers for a subdo...
    ccl help [COMMAND]                                                                                      # Describe available commands...
    ccl payment-profiles SUBCOMMAND                                                                         # manage payment profiles for...
    ccl payment-profiles create_bank CUSTOMER_ID BANK_NAME BANK_ROUTING_NUMBER BANK_ACCOUNT_NUMBER          # Create payment_profile
    ccl payment-profiles help [COMMAND]                                                                     # Describe subcommands or one...
    ccl payment-profiles list                                                                               # list payment_profiles
    ccl payment-profiles update ID BILLING_ADDRESS BILLING_CITY BILLING_STATE BILLING ZIP, BILLING_COUNTRY  # Update payment profile
    ccl subscriptions

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mwhagedorn/ccl.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
