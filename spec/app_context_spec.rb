require './lib/action'
require './lib/app_context'

describe AppContext do
  describe '#available_actions' do
    let(:available_action) do
      Action.new conds: [], effects: []
    end
    let(:unavailable_action) do
      Action.new(
        conds: [
          { field: :money, operator: :>, value: 50 }
        ],
        effects: []
      )
    end
    let(:valera) { Valera.new money: 10 }
    let(:container) { ActionsContainer.new [available_action, unavailable_action] }
    let(:app_context) { AppContext.new(valera: valera, actions_container: container) }

    subject { app_context.available_actions }

    it { is_expected.to include available_action }
    it { is_expected.not_to include unavailable_action }
  end
end
