class Transfer

  attr_accessor :status, :amount, :sender, :receiver, :prev_amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @prev_amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @sender.valid? && sender.balance > @amount
      @sender.deposit(-@amount)
      @receiver.deposit(@amount)
      @status = "complete"
      @amount = 0
    else
      @status = "rejected"
      @amount = 0
      "Transaction rejected. Please check your account balance."
    end
  end

  def complete?
    if @status == "complete"
      true
    else
      false
    end
  end

  def reverse_transfer
    if self.complete?
      @sender.deposit(@prev_amount)
      @receiver.deposit(-@prev_amount)
      @status = "reversed"
    end
  end

end
