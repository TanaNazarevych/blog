class Category < ApplicationRecord
    has_many :articles


    #validates  :articles, presence: true, :length => { :minimum => 1 }
    include PgSearch::Model

    pg_search_scope :search_by_category, against: :category_title
  
    validates :title, presence: true, length: { in: 6..50}, uniqueness: { case_sensitive: false }

    def category_title
        title
         
    end
end
