class RemoveAvatarFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :avatar, :string
  end
end
