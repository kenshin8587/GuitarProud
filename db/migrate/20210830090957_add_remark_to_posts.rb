class AddRemarkToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :remark, :text
  end
end
