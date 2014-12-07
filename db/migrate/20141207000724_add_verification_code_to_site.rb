class AddVerificationCodeToSite < ActiveRecord::Migration
  def change
    add_column :sites, :verification_code, :string
  end
end
