require './lib/action'
require './lib/valera'

describe Action do
  describe '#valid?' do
    let(:action) do
      Action.new(
        conds: [
          { field: :health, operator: :<, value: 50 },
          { field: :health, operator: :>, value: 40 }
        ],
        effects: []
      )
    end

    subject { action.valid? valera }

    context 'when all conds are valid' do
      let(:valera) { Valera.new health: 45 }
      it { is_expected.to eq true }
    end

    context 'when there is an invalid conds' do
      let(:valera) { Valera.new health: 80 }
      it { is_expected.to eq false }
    end
  end

  describe '#execute?' do
    let(:valera) { Valera.new health: 20, mana: 0 }
    let(:action) do
      Action.new(
        effects: [
          { field: :health, operator: :-, value: 10 },
          { field: :mana, operator: :+, value: 10 }
        ],
        conds: []
      )
    end

    subject { action.execute valera }

    it 'applies the first effect' do
      expect { subject }.to change { valera.health }.by(-10)
    end
    it 'applies the second effect' do
      expect { subject }.to change { valera.mana }.by(10)
    end
    it { is_expected.to eq valera }
  end
end
