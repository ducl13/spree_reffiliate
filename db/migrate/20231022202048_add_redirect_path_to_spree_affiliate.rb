class AddRedirectPathToSpreeAffiliate < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_affiliates, :redirect_path, :string
  end
end
