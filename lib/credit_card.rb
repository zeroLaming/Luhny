class CreditCard
  
  CARD_TYPES = {
    'AMEX' => /^3[47]\d{13}?$/,
    'Discover' => /^6011\d{12}?$/,
    'MasterCard' => /^5[1-5]\d{14}?$/,
    'VISA' => /^4\d{12}(\d{3})?$/
  }
  
  def initialize(card_number)
    @card_number = clean_number(card_number)
  end
  
  def humanized_card_type
    card_type || 'Unknown'
  end
  
  def valid?
    card_type && valid_checksum?
  end
  
  def summary
    "#{humanized_card_type}: #{@card_number} #{valid? ? '(valid)' : '(invalid)'}"
  end
  
  private
  
    def clean_number(number)
      number.gsub(/\D/, '')
    end

    def card_type
      CARD_TYPES.map{|n, p| n if @card_number =~ p}.compact.first
    end
  
    def valid_checksum?
      numbers = @card_number.scan(/./).map(&:to_i)
      numbers.reverse.map.with_index do |digit, index|
        if index % 2 > 0
          (digit * 2) < 10 ? (digit * 2) : ((digit * 2) - 9)
        else
          digit
        end
      end.inject(:+) % 10 == 0
    end
    
end