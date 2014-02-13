class CreditCard
  
  CARD_TYPES = {
    'AMEX' => /^3[47]\d{13}?$/,
    'Discover' => /^6011\d{12}?$/,
    'Mastercard' => /^5[1-5]\d{14}?$/,
    'Visa' => /^4\d{12}(\d{3})?$/
  }
  
  def initialize(card_number)
    @card_number = card_number
  end
  
  def card_type
    CARD_TYPES.map{|n, p| n if @card_number =~ p}.compact.first || 'Unknown'
  end
  
  def valid?
    
  end
  
  private
  
  def luhn_valid?
    
  end
end