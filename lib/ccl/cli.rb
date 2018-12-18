require 'ccl'
require 'thor'
require 'chargify_api_ares'
require 'yaml'

chargify_config = YAML::load_file(File.join(Dir.home,'.ccl', 'chargify.yml'))

Chargify.configure do |c|
  c.domain = chargify_config['domain']
  c.subdomain = chargify_config['subdomain']
  c.api_key   = chargify_config['api_key']
end

module Ccl
  class CLI < Thor
    include Thor::Actions

    def self.exit_on_failure?
      true
    end

    class SubCommandBase < Thor
      def self.banner(command, namespace = nil, subcommand = false)
        "#{basename} #{subcommand_prefix} #{command.usage}"
      end

      def self.subcommand_prefix
        self.name.gsub(%r{.*::}, '').gsub(%r{^[A-Z]}) { |match| match[0].downcase }.gsub(%r{[A-Z]}) { |match| "-#{match[0].downcase}" }
      end
    end

    class BankAccount < SubCommandBase

    end

    class CreditCard < SubCommandBase

    end

    class PaymentProfiles < SubCommandBase
      desc "list", "list payment_profiles"
      def list
        payment_profiles = Chargify::PaymentProfile.find(:all)
        puts payment_profiles.to_json
      end

      desc "create_bank CUSTOMER_ID BANK_NAME BANK_ROUTING_NUMBER BANK_ACCOUNT_NUMBER ", "Create payment_profile"
      method_option :bank_account_type, type: :string, default:'checking', option: :required
      method_option :bank_account_holder_type, type: :string, default: 'business'
      def create_bank(customer_id, bank_name, bank_routing_number, bank_account_number)

        pmt_profile = Chargify::PaymentProfile.create(
          customer_id: customer_id,
          bank_name: bank_name,
          bank_routing_number: bank_routing_number,
          bank_account_number: bank_account_number,
          bank_account_type: options[:bank_account_type],
          payment_type: 'bank_account',
          billing_address: "foo",
          billing_city: "Newaygo",
          billing_state: "Mi",
          billing_zip: "49337",
          billing_country:"US"
        )

        if pmt_profile.valid?
          puts pmt_profile.to_json
        else
          puts pmt_profile.errors.to_json
        end
      end

      desc "update ID BILLING_ADDRESS BILLING_CITY BILLING_STATE BILLING ZIP, BILLING_COUNTRY", "Update payment profile"
      def update(id, billing_address, billing_city, billing_state, billing_zip, billing_country)
        pp = Chargify::PaymentProfile.find(id)
        if pp
          pp.update_attributes(
            billing_address: billing_address,
            billing_city: billing_city,
            billing_state: billing_state,
            billing_zip: billing_zip,
            billing_country: billing_country,
            billing_address2: nil
          )
          pp.save
          puts pp.to_json
        end

      end

    end



    desc "subscriptions", "lists a subdomains subscriptions"
    def subscriptions
      subscriptions = Chargify::Subscription.find(:all)

      puts subscriptions.to_json
    end

    desc "payment-profiles SUBCOMMAND", "manage payment profiles for a subdomain"
    subcommand "payment_profiles", PaymentProfiles

    desc "customers", "Lists customers for a subdomain"
    def customers
      customers = Chargify::Customer.find(:all)

      puts customers.to_json
    end
  end
end
