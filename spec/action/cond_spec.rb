require './lib/action/cond'
require './lib/valera'

describe Action::Cond do
  describe 'valid?' do
    let(:cond) do
      Action::Cond.new field: :health, operator: :<, value: 50
    end
    subject { cond.valid? valera }
    context 'when the cond is valid' do
      let(:valera) { Valera.new health: 100 }
      it { is_expected.to be_falsey }
    end
    context 'when the cond is not valid' do
      let(:valera) { Valera.new health: 10 }
      it { is_expected.to be_truthy }
    end
  end
end
