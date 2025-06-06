class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.belongs_to :article, null: false, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
