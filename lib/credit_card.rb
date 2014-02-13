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
  
  def humanized_card_type
    card_type || 'Unknown'
  end
  
  def valid?
    card_type && luhn_checksum
  end
  
  private
  
    def card_type
      CARD_TYPES.map{|n, p| n if @card_number =~ p}.compact.first
    end
  
    def luhn_checksum
      numbers = @card_number.scan(/./).map(&:to_i)
      total = 0
      numbers.reverse.each_with_index do |digit, index|
        if index % 2 > 0
          doubled = digit * 2
          total += doubled < 10 ? doubled : (doubled - 9)
        else
          total += digit
        end
      end
      total % 10 == 0
    end
    
end