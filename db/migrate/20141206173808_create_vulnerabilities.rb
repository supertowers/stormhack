class CreateVulnerabilities < ActiveRecord::Migration
  def change
    create_table :vulnerabilities do |t|
      t.references :user, index: true
      t.string :title
      t.text :description
      t.boolean :approved

      t.timestamps
    end
  end
end
