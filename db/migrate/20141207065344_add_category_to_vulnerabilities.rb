class AddCategoryToVulnerabilities < ActiveRecord::Migration
  def change
    add_column :vulnerabilities, :category, :string
  end
end
