require './lib/action.rb'

describe Action do
  describe '#valid?' do
    let(:action) { Action.new conds: conds }
    let(:conds) { [cond1, cond2] }
    let(:cond1) { double('Cond') }
    let(:cond2) { double('Cond') }
    let(:valera) { double('Valera') }
    subject { action.valid? valera }
    context 'when all conds are valid' do
      before do
        allow(cond1).to receive(:valid?).and_return true
        allow(cond2).to receive(:valid?).and_return true
      end
      it { is_expected.to eq true }
    end
    context 'whne not all conds is valid' do
      before do
        allow(cond1).to receive(:valid?).and_return false
        allow(cond2).to receive(:valid?).and_return true
      end
      it { is_expected.to eq false }
    end
  end

  describe '#apply' do
  end
end