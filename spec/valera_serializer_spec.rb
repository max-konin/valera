require './lib/valera'
require './lib/valera_serializer'

describe ValeraSerializer do
  describe '#serialize' do
    let(:valera) { Valera.new }
    let(:expected_result) do
      {
        'health' => valera.health,
        'mana' => valera.mana,
        'fun' => valera.fun,
        'fatigue' => valera.fatigue,
        'money' => valera.money
      }
    end

    subject { ValeraSerializer.new(valera).serialize }

    it { is_expected.to be == expected_result }
  end
end
