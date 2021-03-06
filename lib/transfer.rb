require 'pry'

class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount


  def initialize(sender, receiver, amount)
    @sender, @receiver, @amount = sender, receiver, amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && sender.balance > amount && self.status == "pending"
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      reject_transaction
      # self.status = "rejected"
      # "Transaction rejected. Please check your account balance."
    end
  end

  def reject_transaction
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  def reverse_transfer
    if self.status == "complete"
      sender.balance += amount
      receiver.balance -= amount
      self.status = "reversed"
    else
      self.status = "pending"
    end
  end

end
