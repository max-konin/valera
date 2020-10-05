require './lib/range_guard'

describe RangeGuard do
  describe '#cut' do
    let(:guard) { RangeGuard.new min: 0, max: 100 }
    subject { guard.cut(value) }

    context 'when passed value is out of the range' do
      let(:value) { 110 }

      it { is_expected.to be_a RangeGuard::Result }
      it { expect(subject.value).to eq 100 }
      it { expect(subject.rest).to eq 10 }
    end

    context 'when passed value in the range' do
      let(:value) { 80 }

      it { is_expected.to be_a RangeGuard::Result }
      it { expect(subject.value).to eq 80 }
      it { expect(subject.rest).to eq 0 }
    end
  end
end
