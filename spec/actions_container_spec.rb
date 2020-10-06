require './lib/action'
require './lib/actions_container'
require './lib/action/cond'
require './lib/valera'

describe ActionsContainer do
  describe '.available_actions_for' do
    let(:available_action) do
      Action.new conds: [], effects: []
    end
    let(:not_available_action) do
      Action.new(
        conds: [
          { field: :money, operator: :>, value: 50 }
        ],
        effects: []
      )
    end
    let(:valera) { Valera.new money: 10 }
    let(:container) { ActionsContainer.new [available_action, not_available_action] }

    subject { container.available_actions_for(valera) }

    it { is_expected.to include available_action }
    it { is_expected.not_to include not_available_action }
  end
end
