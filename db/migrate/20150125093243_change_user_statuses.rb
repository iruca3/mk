class ChangeUserStatuses < ActiveRecord::Migration
  def change
    remove_column :users, :status
    add_column :users, :rss_url, :string
    add_column :user_status_histories, :image, :string
  end
end
