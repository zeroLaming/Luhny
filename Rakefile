require 'rspec/core/rake_task'
require_relative 'lib/credit_card'

RSpec::Core::RakeTask.new(:spec)
task :default => [:spec]

desc "Verify credit card numbers"
task :card_validation do
  puts "Welcome to the credit card validator. Press q to quit.\n\n"
  loop do
    puts "Please enter a credit card number:"
    card_number = STDIN.gets.chomp
    exit if card_number == 'q'
    credit_card = CreditCard.new(card_number)
    puts credit_card.summary
  end
end