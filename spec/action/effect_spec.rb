require './lib/action/effect'
require './lib/valera'

describe Action::Effect do
  describe 'execute' do
    let(:valera) { Valera.new health: 100 }
    let(:effect) do
      Action::Effect.new field: :health, operator: :-, value: 50
    end

    subject { effect.execute valera }

    it { is_expected.to be_a Valera }
    it { expect(subject.health).to eq(50) }
  end
end
