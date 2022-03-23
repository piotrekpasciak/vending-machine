require_relative '../spec_helper'

describe ReturnChangeService do
  subject { described_class.new(coins: coins, user_balance: user_balance) }

  describe '#call' do
    context "when coins can't match user balance" do
      let(:user_balance) { 3.75 }
      let(:coins) do
        [
          { value: 5.0, quantity: 0 },
          { value: 3.0, quantity: 5 },
          { value: 2.0, quantity: 5 },
          { value: 1.0, quantity: 0 },
          { value: 0.5, quantity: 0 },
          { value: 0.25, quantity: 2 }
        ]
      end

      it 'returns success value set to false' do
        result = subject.call

        expect(result[:success]).to eq false
      end
    end

    context 'when coins can match user balance' do
      let(:user_balance) { 3.75 }
      let(:coins) do
        [
          { value: 5.0, quantity: 5 },
          { value: 3.0, quantity: 5 },
          { value: 2.0, quantity: 5 },
          { value: 1.0, quantity: 5 },
          { value: 0.5, quantity: 5 },
          { value: 0.25, quantity: 5 }
        ]
      end

      it 'returns collection of coins with updated quantity' do
        result = subject.call

        expect(result[:coins]).to match_array [
          { value: 5.0, quantity: 5 },
          { value: 3.0, quantity: 4 },
          { value: 2.0, quantity: 5 },
          { value: 1.0, quantity: 5 },
          { value: 0.5, quantity: 4 },
          { value: 0.25, quantity: 4 }
        ]
      end

      it 'returns collection of returned coins' do
        result = subject.call

        expect(result[:returned_coins]).to match_array [
          { value: 3.0, quantity: 1 },
          { value: 0.5, quantity: 1 },
          { value: 0.25, quantity: 1 }
        ]
      end

      it 'returns success value set to true' do
        result = subject.call

        expect(result[:success]).to eq true
      end
    end
  end
end
