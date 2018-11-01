require './lib/action/cond.rb'
require './lib/valera.rb'

describe Action::Cond do
  describe 'valid?' do
    let(:cond) do
      Action::Cond.new field: :health, operator: :<, value: 50
    end
    subject { cond.valid? valera }
    context 'when cond is valid' do
      let(:valera) { Valera.new health: 100 }
      it { is_expected.to eq false }
    end
    context 'when cond is not valid' do
      let(:valera) { Valera.new health: 10 }
      it { is_expected.to eq true }
    end
  end
end
