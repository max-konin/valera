require './lib/valera.rb'

describe Valera do
  describe '.new' do
    context 'with args' do
      subject { Valera.new }

      it { expect(subject.health).to eq 100 }
      it { expect(subject.mana).to eq 0 }
      it { expect(subject.fun).to eq 0 }
      it { expect(subject.fatigue).to eq 0 }
      it { expect(subject.money).to eq 0 }
    end
    context 'with arg' do
      subject do
        Valera.new health: 10,
                   mana: 10,
                   fun: 1,
                   fatigue: 2,
                   money: 100
      end

      it { expect(subject.health).to eq 10 }
      it { expect(subject.mana).to eq 10 }
      it { expect(subject.fun).to eq 1 }
      it { expect(subject.fatigue).to eq 2 }
      it { expect(subject.money).to eq 100 }
    end
  end

  describe '#dead?' do
    context 'health > 0' do
      subject { Valera.new health: 10 }
      it { is_expected.not_to be_dead }
    end
    context 'health < 0' do
      subject { Valera.new health: -10 }
      it { is_expected.to be_dead }
    end
    context 'fun > -10' do
      subject { Valera.new fun: 0 }
      it { is_expected.not_to be_dead }
    end
    context 'fun <= -10' do
      subject { Valera.new fun: -10 }
      it { is_expected.to be_dead }
    end
  end

  describe '#mana=' do
    let(:valera) { Valera.new }
    subject { valera.mana = value }
    context 'when new value > 100' do
      let(:value) { 150 }
      it { expect { subject }.to change { valera.mana }.to(100) }
      it { expect { subject }.to change { valera.health }.by(-50) }
    end
    context 'when new value < 100' do
      let(:value) { 80 }
      it { expect { subject }.to change { valera.mana }.to(80) }
      it { expect { subject }.not_to change { valera.health } }
    end
  end
end
