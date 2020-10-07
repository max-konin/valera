require './lib/config_loader'
require './lib/actions_container'

describe ConfigLoader do
  describe '.load' do
    let(:loaded_data) { ConfigLoader.load(File.expand_path('actions_fixture.yml', __dir__)) }
    subject { loaded_data }

    it { is_expected.to be_a ActionsContainer }
    it { expect(subject.actions.size).to eq(1) }

    describe 'first parsed actions' do
      subject { loaded_data.actions.first }

      it { is_expected.to have_attributes(before_text: 'Go to a pub', after_text: 'Cool party') }
    end
  end
end
