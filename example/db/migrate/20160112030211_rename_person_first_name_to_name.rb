class RenamePersonFirstNameToName < ActiveRecord::Migration
  def change
    rename_column :people, :first_name, :name
  end
end

