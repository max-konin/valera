require './lib/components/menu'

describe Components::Menu do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  let(:menu) do
    Components::Menu.new(
      layout: layout,
      items: [
        { title: 'Go to pub', command: '1', action: :go_to_pub },
        { title: 'Sleep', command: '2', action: :sleep }
      ]
    )
  end

  describe '#render' do
    context 'when a layout is vertical' do
      let(:layout) { 'vertical' }
      it 'renders the menu' do
        menu.render
        expect(io_mock).to have_received(:write).with(
          '[1] Go to pub'
        )
        expect(io_mock).to have_received(:write).with(
          '[2] Sleep'
        )
      end
    end

    context 'when a layout is horizontal' do
      let(:layout) { 'horizontal' }
      it 'renders the menu' do
        menu.render
        expect(io_mock).to have_received(:write).with(
          '[1] Go to pub | [2] Sleep'
        )
      end
    end
  end

  describe '#handle_input' do
    let(:layout) { 'vertical' }
    subject { menu.handle_input input }
    context 'when an input is correct' do
      let(:input) { '1' }
      it 'returns correct action name by the input' do
        expect(subject).to eq(:go_to_pub)
      end
    end

    context 'when an input is not correct' do
      let(:input) { 'fake' }
      it { is_expected.to be_nil }
    end
  end
end
