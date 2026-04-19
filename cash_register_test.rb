require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test

  def setup
    @register = CashRegister.new(100)
    @transaction = Transaction.new(10)
    @transaction.amount_paid = 10
  end

  def test_accept_money
    previous_amount = @register.total_money
    @register.accept_money(@transaction)
    current_amount = @register.total_money

    assert_equal(previous_amount + 10, @register.total_money)
  end

  def test_change
    expected_change = @transaction.amount_paid - @transaction.item_cost
    actual_change = @register.change(@transaction)
    assert_equal(expected_change, actual_change)
  end

  def test_give_receipt
    expected = "You've paid $#{@transaction.item_cost}.\n"
    assert_output(expected) {@register.give_receipt(@transaction)}
  end

end