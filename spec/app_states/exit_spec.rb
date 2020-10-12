require './lib/app_states/exit'
require './lib/io_adapter'

describe AppStates::Exit do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  let(:state) { AppStates::Exit.new double('app_context') }

  describe '#render' do
    it 'renders Goodbye' do
      state.render
      expect(io_mock).to have_received(:write).with(
        'Goodbye!'
      )
    end
  end

  describe '#next' do
    it { expect { state.next }.to raise_error('Exit state does not have the next state') }
  end
end
