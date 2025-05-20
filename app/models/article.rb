class Article < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImageUploader
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  include PgSearch::Model

  pg_search_scope :search_by_article, against: [:title, :text]
  
  pg_search_scope :search_by_category, associated_against: { 
    category: :title
  }

  def self.search_by_category(id)
    where(category_id: id)
  end

  def user_email
    user.email if user
  end
  

  paginates_per 25

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings, class_name: 'Gutentag::Tag'

  belongs_to :category
  
  validates :title, presence: true, length: { in: 6..50}, uniqueness: { case_sensitive: false }
  validates :text, presence: true, length: { in: 10..10000, too_long: "%{count} characters maximum allowed"}
  
  has_rich_text :text

  has_many :comments, dependent: :destroy


  



  Gutentag::ActiveRecord.call self
  
  def tags_as_string
    tag_names.join(", ")
  end

  def tags_as_string=(string)
    self.tag_names = string.split(/,\s*/)
  end

  
end

   
  