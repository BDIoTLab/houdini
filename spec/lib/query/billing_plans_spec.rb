require 'rails_helper'

describe BillingPlans do

  let(:percentage) {0.34}
  let(:billing_plan) do
    force_create(:billing_plan, :percentage_fee => percentage)
  end

  let(:nonprofit) do
    force_create(:nonprofit)
  end
  
  describe '.get_percentage_fee' do
    describe 'param validation' do
      it 'rejects non-integers' do
        expect { BillingPlans.get_percentage_fee('not an integer') }.to (raise_error {|error|
          expect(error).to be_a(ParamValidation::ValidationError)
          expect_validation_errors(error.data, [{key: :nonprofit_id, name: :is_integer}])
        })
      end

      it 'rejects invalid nonprofits' do
        expect { BillingPlans.get_percentage_fee(55555) }.to (raise_error {|error|
          expect(error).to be_a(ParamValidation::ValidationError)
          expect_validation_errors(error.data, [{key: :nonprofit_id}])
        })
      end
    end

    it 'returns 0 when no billing_subscription' do

      result = BillingPlans.get_percentage_fee(nonprofit.id)
      expect(result).to eq 0
    end

    # TODO not sure this is what we actually want?
    it 'returns 0 when billing plan is invalid' do
      bs = force_create(:billing_subscription, :billing_plan =>  nil, :nonprofit => nonprofit)

      result = BillingPlans.get_percentage_fee(nonprofit.id)
      expect(result).to eq(0)
    end

    it 'returns percentage when billing subscription exists' do
      bs = force_create(:billing_subscription, :billing_plan =>  billing_plan, :nonprofit => nonprofit)

      result = BillingPlans.get_percentage_fee(nonprofit.id)
      expect(result).to eq (0.34)
    end

  end
end
