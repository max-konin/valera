require './lib/valera'

describe Valera do
  describe '.new' do
    context 'without args' do
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
    context 'health <= 0' do
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
    let(:valera) { Valera.new mana: 10 }
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

    context 'when new value < 0' do
      let(:value) { -2 }
      it { expect { subject }.to change { valera.mana }.to(0) }
    end
  end

  describe '#health=' do
    let(:valera) { Valera.new health: 50 }
    subject { valera.health = value }
    context 'when new value > 100' do
      let(:value) { 150 }
      it { expect { subject }.to change { valera.health }.to(100) }
    end
    context 'when new value < 100' do
      let(:value) { 80 }
      it { expect { subject }.to change { valera.health }.to(80) }
    end
    context 'when new value < 0' do
      let(:value) { -1 }
      it { expect { subject }.to change { valera.health }.to(0) }
    end
  end

  describe '#fun=' do
    let(:valera) { Valera.new fun: 5 }
    subject { valera.fun = value }
    context 'when new value > 10' do
      let(:value) { 150 }
      it { expect { subject }.to change { valera.fun }.to(10) }
    end
    context 'when new value < 10' do
      let(:value) { 4 }
      it { expect { subject }.to change { valera.fun }.to(4) }
    end
    context 'when new value < -10' do
      let(:value) { -15 }
      it { expect { subject }.to change { valera.fun }.to(-10) }
    end
  end

  describe '#fatigue=' do
    let(:valera) { Valera.new fatigue: 30 }
    subject { valera.fatigue = value }
    context 'when new value > 100' do
      let(:value) { 150 }
      it { expect { subject }.to change { valera.fatigue }.to(100) }
    end
    context 'when new value < 100' do
      let(:value) { 80 }
      it { expect { subject }.to change { valera.fatigue }.to(80) }
    end
    context 'when new value < 0' do
      let(:value) { -1 }
      it { expect { subject }.to change { valera.fatigue }.to(0) }
    end
  end
end
