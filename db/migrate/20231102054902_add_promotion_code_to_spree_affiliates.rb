class AddPromotionCodeToSpreeAffiliates < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_affiliates, :promotion_code, :string
  end
end
