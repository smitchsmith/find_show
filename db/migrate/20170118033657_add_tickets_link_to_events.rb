class AddTicketsLinkToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :tickets_link, :string
  end
end
