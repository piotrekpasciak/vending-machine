require_relative '../spec_helper'

describe InsertCoinService do
  subject do
    described_class.new(
      coins: coins,
      user_balance: user_balance,
      user_input: user_input
    )
  end

  let(:user_balance) { 0.0 }
  let(:coins) do
    [
      { value: 3.0, quantity: 5 },
      { value: 2.0, quantity: 5 }
    ]
  end

  describe '#call' do
    context 'when user input is not a number' do
      let(:user_input) { 'Text' }

      it 'raises InvalidCoin exception' do
        expect { subject.call }.to raise_error InvalidCoinInserted
      end
    end

    context 'when user input is a number that does not match any of the coins' do
      let(:user_input) { '9.50' }

      it 'raises InvalidCoin exception' do
        expect { subject.call }.to raise_error InvalidCoinInserted
      end
    end

    context 'when user input is a number that matches one of the coins' do
      let(:user_input) { '2' }

      it 'returns collection of coins with updated quantity' do
        result = subject.call

        expect(result[:coins]).to eq [
          { value: 3.0, quantity: 5 },
          { value: 2.0, quantity: 6 }
        ]
      end

      it 'returns updated user balance' do
        result = subject.call

        expect(result[:new_balance]).to eq 2.0
      end
    end
  end
end
