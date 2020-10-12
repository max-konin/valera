require './lib/actions_container'
require './lib/app_context'
require './lib/app_states/welcome'
require './lib/app_states/exit'
require './lib/app_states/play'
require './lib/app_states/load'
require './lib/io_adapter'

describe AppStates::Welcome do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  let(:app_context) do
    AppContext.new valera: nil, actions_container: ActionsContainer.new([])
  end

  let(:state) { AppStates::Welcome.new app_context }

  describe '#render' do
    it 'renders correct text' do
      state.render
      expect(io_mock).to have_received(:write).with(
        'Valera Game'
      )
      expect(io_mock).to have_received(:write).with(
        '[1] Start a new game'
      )
      expect(io_mock).to have_received(:write).with(
        '[2] Load'
      )
      expect(io_mock).to have_received(:write).with(
        '---'
      )
      expect(io_mock).to have_received(:write).with(
        '[exit] Exit'
      )
    end
  end

  describe '#next' do
    subject { state.next }
    context 'when user inputs "1"' do
      before { allow(io_mock).to receive(:read).and_return('1') }
      it { is_expected.to be_a AppStates::Play }
    end

    context 'when user inputs "2"' do
      before { allow(io_mock).to receive(:read).and_return('2') }
      it { is_expected.to be_a AppStates::Load }
    end

    context 'when user inputs "exit"' do
      before { allow(io_mock).to receive(:read).and_return('exit') }
      it { is_expected.to be_a AppStates::Exit }
    end

    context 'when user inputs incorrect data' do
      before { allow(io_mock).to receive(:read).and_return('fake') }
      it { is_expected.to be_a AppStates::Welcome }
    end
  end
end
