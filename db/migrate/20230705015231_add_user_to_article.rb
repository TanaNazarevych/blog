class AddUserToArticle < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :user, null: false,default: 1, foreign_key: true
  end
end
