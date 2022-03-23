require_relative '../spec_helper'

describe BuyProductService do
  subject do
    described_class.new(
      products: products,
      coins: coins,
      user_balance: user_balance,
      user_input: user_input
    )
  end

  let(:user_balance) { 0.0 }
  let(:products) do
    [
      { name: 'orange juice', price: 3.0, quantity: 10 },
      { name: 'water', price: 3.25, quantity: 0 }
    ]
  end
  let(:coins) do
    [
      { value: 3.0, quantity: 2 },
      { value: 2.0, quantity: 2 }
    ]
  end

  describe '#call' do
    context 'when user input does not match any product' do
      let(:user_input) { 'Not existing product' }

      it 'raises InvalidProductSelected exception' do
        expect { subject.call }.to raise_error InvalidProductSelected
      end
    end

    context "when user input matches product that's out of stock" do
      let(:user_input) { 'Water' }

      it 'raises OutOfStockProductSelected exception' do
        expect { subject.call }.to raise_error OutOfStockProductSelected
      end
    end

    context "when user input matches product that's in stock" do
      let(:user_input) { 'Orange Juice' }

      context 'when user balance is insufficient to buy the product' do
        let(:user_balance) { 1.0 }

        it 'raises InsufficientBalance exception' do
          expect { subject.call }.to raise_error InsufficientBalance
        end
      end

      context 'when machine is unable to return change' do
        let(:user_balance) { 10.0 }

        it 'returns success key with false value' do
          result = subject.call

          expect(result[:success]).to eq false
        end
      end

      context 'when user balance is sufficient to buy the product' do
        let(:user_balance) { 6.0 }

        it 'returns collection of products with updated quantity' do
          result = subject.call

          expect(result[:products]).to eq [
            { name: 'orange juice', price: 3.0, quantity: 9 },
            { name: 'water', price: 3.25, quantity: 0 }
          ]
        end

        it 'returns updated user balance' do
          result = subject.call

          expect(result[:new_balance]).to eq 3.0
        end

        it 'returns success key with true value' do
          result = subject.call

          expect(result[:success]).to eq true
        end
      end
    end
  end
end
