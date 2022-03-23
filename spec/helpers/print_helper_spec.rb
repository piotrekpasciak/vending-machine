require_relative '../spec_helper'

describe PrintHelper do
  subject { Class.new { extend PrintHelper } }

  describe '#print_welcome_message' do
    it 'prints welcome message' do
      expect { subject.print_welcome_message }.to output(/Vending Machine/).to_stdout
    end
  end

  describe '#print_user_balance' do
    it 'prints user balance' do
      expect { subject.print_user_balance(0.1) }.to output(/0.10/).to_stdout
    end
  end

  describe '#print_returned_coins' do
    let(:returned_coins) { [{ value: 2.0, quantity: 3 }] }

    it 'prints returned coin value' do
      expect { subject.print_returned_coins(returned_coins) }.to output(/2.00/).to_stdout
    end

    it 'prints returned coin quantity' do
      expect { subject.print_returned_coins(returned_coins) }.to output(/3/).to_stdout
    end
  end

  describe '#print_product_bought' do
    it 'prints product name' do
      expect { subject.print_product_bought('sprite') }.to output(/Sprite/).to_stdout
    end
  end

  describe '#print_no_change_available' do
    it 'prints not available change message' do
      expect { subject.print_no_change_available }.to output(/No change available/).to_stdout
    end
  end
end
