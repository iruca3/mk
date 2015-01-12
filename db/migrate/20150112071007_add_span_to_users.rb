class AddSpanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :span, :integer, null: false, default: 0
  end
end
