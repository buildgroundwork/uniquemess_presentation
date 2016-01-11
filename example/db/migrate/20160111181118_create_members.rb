class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :person
      t.references :band

      t.timestamps null: false
    end
  end
end
