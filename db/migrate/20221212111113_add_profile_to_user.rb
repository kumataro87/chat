class AddProfileToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :introduction, :text
    add_column :users, :status_message, :string
  end
end
