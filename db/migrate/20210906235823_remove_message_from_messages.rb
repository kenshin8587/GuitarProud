class RemoveMessageFromMessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :message, :text
  end
end
