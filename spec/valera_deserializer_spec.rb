require './lib/valera'
require './lib/valera_deserializer'

describe ValeraDeserializer do
  describe '#serialize' do
    let(:hash) do
      {
        'health' => 40,
        'mana' => 40,
        'fun' => 3,
        'fatigue' => 3,
        'money' => 100
      }
    end

    subject { ValeraDeserializer.new(hash).deserialize }

    it { is_expected.to be_a Valera }
    it { is_expected.to have_attributes hash.transform_keys(&:to_sym) }
  end
end
