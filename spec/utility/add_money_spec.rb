require_relative '../spec_helper'

describe AddMoney do
  subject { described_class.new(first_value, second_value) }

  describe '#call' do
    context 'when both values are positive' do
      let(:first_value)  { 1 }
      let(:second_value) { 1.25 }

      it 'returns sum of 2 values' do
        expect(subject.call).to eq 2.25
      end

      it 'returns result of BigDecimal type' do
        expect(subject.call.class).to eq BigDecimal
      end
    end

    context 'when second value is negative' do
      let(:first_value)  { 1 }
      let(:second_value) { -1.25 }

      it 'returns subtraction of first value by second value' do
        expect(subject.call).to eq(-0.25)
      end
    end
  end
end
