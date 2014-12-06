class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :url
      t.references :user, index: true
      t.string :status

      t.timestamps
    end
  end
end
