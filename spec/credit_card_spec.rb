require_relative '../lib/credit_card'

describe 'Credit card validation' do
  describe '#card_type' do
    
    context 'when the card number is invalid' do
      subject(:card_type) { CreditCard.new('g1bb3r1sh').humanized_card_type }
      
      it "should return an 'Unknown' label" do
        expect(card_type).to eql('Unknown')
      end
    end
    
    context 'when it starts with 34 or 37 like an AMEX' do
      it 'should regognise a valid number' do
        card_type = CreditCard.new('378282246310005').humanized_card_type
        expect(card_type).to eql('AMEX')
      end
      
      it 'should reject numbers that are too short' do
        card_type = CreditCard.new('3782822463100').humanized_card_type
        expect(card_type).to eql('Unknown')
      end
      
      it 'should reject numbers that are too long' do
        card_type = CreditCard.new('3782822463100055').humanized_card_type
        expect(card_type).to eql('Unknown')
      end
    end
    
    context 'when it starts with 6011 like a Discover' do
      it 'should regognise a valid number' do
        card_type = CreditCard.new('6011111111111117').humanized_card_type
        expect(card_type).to eql('Discover')
      end
      
      it 'should reject numbers that are too short' do
        card_type = CreditCard.new('601111111111111').humanized_card_type
        expect(card_type).to eql('Unknown')
      end
      
      it 'should reject numbers that are too long' do
        card_type = CreditCard.new('60111111111111177').humanized_card_type
        expect(card_type).to eql('Unknown')
      end
    end
    
    context 'when it starts with 51 - 55 like a Mastercard' do
      it 'should regognise a valid number' do
        card_type = CreditCard.new('5305105105105100').humanized_card_type
        expect(card_type).to eql('Mastercard')
      end
      
      it 'should reject numbers that are too short' do
        card_type = CreditCard.new('530510510510510').humanized_card_type
        expect(card_type).to eql('Unknown')
      end
      
      it 'should reject numbers that are too long' do
        card_type = CreditCard.new('53051051051051000').humanized_card_type
        expect(card_type).to eql('Unknown')
      end
    end
    
    context 'when it starts with a 4 like a Visa' do
      it 'should regognise a valid number' do
        card_type = CreditCard.new('4111111111111111').humanized_card_type
        expect(card_type).to eql('Visa')
      end
      
      it 'should reject numbers that are too short' do
        card_type = CreditCard.new('411111111111').humanized_card_type
        expect(card_type).to eql('Unknown')
      end
      
      it 'should reject numbers that are too long' do
        card_type = CreditCard.new('41111111111111110000').humanized_card_type
        expect(card_type).to eql('Unknown')
      end
    end
    
  end
  
  describe '#valid?' do
    context 'an AMEX card number' do
      it 'should be valid against the luhn algorithm' do
        card = CreditCard.new('378282246310005')
        expect(card.valid?).to eq(true)
      end
      
      it 'should be invalid against the luhn algorithm with a modified digit' do
        card = CreditCard.new('378282246310006')
        expect(card.valid?).to eq(false)
      end 
    end

    context 'a Discover card number' do
      it 'should be valid against the luhn algorithm' do
        card = CreditCard.new('6011111111111117')
        expect(card.valid?).to eq(true)
      end
      
      it 'should be invalid against the luhn algorithm with a modified digit' do
        card = CreditCard.new('6011111111111118')
        expect(card.valid?).to eq(false)
      end
    end
    
    context 'a Mastercard card number' do
      it 'should be valid against the luhn algorithm' do
        card = CreditCard.new('5105105105105100')
        expect(card.valid?).to eq(true)
      end
      
      it 'should be invalid against the luhn algorithm with a modified digit' do
        card = CreditCard.new('5105105105105101')
        expect(card.valid?).to eq(false)
      end
    end
    
    context 'a Visa card number' do
      it 'should be valid against the luhn algorithm' do
        card = CreditCard.new('4111111111111111')
        expect(card.valid?).to eq(true)
      end
      
      it 'should be invalid against the luhn algorithm with a modified digit' do
        card = CreditCard.new('4111111111111112')
        expect(card.valid?).to eq(false)
      end
    end
  end
end
