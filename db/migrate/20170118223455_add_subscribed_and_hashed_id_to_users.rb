class AddSubscribedAndHashedIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscribed, :boolean, default: true
    add_column :users, :hashed_id, :string
  end
end
