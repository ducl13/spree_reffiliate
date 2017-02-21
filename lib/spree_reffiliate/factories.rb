FactoryGirl.define do
  factory :affiliate, class: Spree::Affiliate do
    name FFaker::Name.first_name
    path FFaker::Name.first_name
    partial FFaker::Name.first_name
    layout nil

    after(:build) do |affiliate|
      Spree::CommissionRule.find_or_create_by(name: Spree::CommissionRule::USER_REGISTRATION, fixed_commission: true)
      Spree::CommissionRule.find_or_create_by(name: Spree::CommissionRule::ORDER_PLACEMENT, fixed_commission: false)
      Spree::CommissionRule.all.map { |comm_rule| affiliate.affiliate_commission_rules.find_or_initialize_by(commission_rule_id: comm_rule.id) }
    end
  end

  factory :referral, class: Spree::Referral
  factory :referred_promotion_rule, class: Spree::Promotion::Rules::ReferredPromotionRule
  factory :affiliated_promotion_rule, class: Spree::Promotion::Rules::AffiliatedPromotionRule

  factory :transaction, class: Spree::CommissionTransaction do
    factory :order_transaction do
      commissionable order
    end

    factory :user_transaction do
      commissionable user
    end
  end

  factory :commission, class: Spree::Commission do
    start_date Date.current.beginning_of_month
    end_date Date.current.end_of_month
    factory(:commission_with_transactions) do
      after(:create) do
        self.transactions.create(commissionable: create(:order), affiliate: create(:affiliate))
        self.transactions.create(commissionable: create(:user), affiliate: create(:affiliate))
      end
    end
  end
end
