class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.string :type
      t.references :user, index: true
      t.references :site, index: true

      t.timestamps
    end
  end
end
