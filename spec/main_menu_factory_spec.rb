require './lib/main_menu_factory'
require './lib/components/menu'

describe MainMenuFactory do
  describe '.build' do
    subject { MainMenuFactory.build only: only }

    context 'with `only` argument' do
      let(:only) { [:exit] }

      it { is_expected.to be_a Components::Menu }
      it 'build menu with horizontal layout' do
        expect(subject.layout).to eq 'horizontal'
      end
      it 'builds correct menu items' do
        texts = subject.items.map(&:text_to_render).join(' | ')
        expect(texts).to eq '[exit] Exit'
      end
    end
    context 'without `only` argument' do
      let(:only) { nil }

      it { is_expected.to be_a Components::Menu }
      it 'build menu with horizontal layout' do
        expect(subject.layout).to eq 'horizontal'
      end
      it 'builds correct menu items' do
        texts = subject.items.map(&:text_to_render).join(' | ')
        expect(texts).to eq '[save] Save | [load] Load | [exit] Exit'
      end
    end
  end
end
