class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|

      t.timestamps
      t.string :title
      t.text :text
      
    end
  end
end
