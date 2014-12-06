class AddDescriptionsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :public_description, :text
    add_column :sites, :private_description, :text
  end
end
