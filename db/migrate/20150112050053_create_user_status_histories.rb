class CreateUserStatusHistories < ActiveRecord::Migration
  def change
    create_table :user_status_histories do |t|
      t.integer       :user_id, null: false
      t.text          :status

      t.timestamps
    end
    add_index :user_status_histories, :user_id
  end
end
