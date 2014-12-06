class AddScreenshotToSites < ActiveRecord::Migration
  def change
    add_column :sites, :screenshot, :string
  end
end
