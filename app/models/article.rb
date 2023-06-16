class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include PgSearch::Model
  # pg_search_scope :search_by_multiple, against: [:title, :text, :category_title, :tags]
  pg_search_scope :search_by_article, against: [:title, :text]
  
  pg_search_scope :search_by_category, associated_against: { 
    category: :title
  }

  def self.search_by_category(id)
    where(category_id: id)
  end
  
  # pg_search_scope :search_by_multiple, against: [:title, :text:], associated_against: {
  #   category: :title
  # }
  paginates_per 25
  
  mount_uploader :image, AvatarUploader

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings, class_name: 'Gutentag::Tag'

  belongs_to :category
  
  validates :title, presence: true, length: { in: 6..50}, uniqueness: { case_sensitive: false }
  validates :text, presence: true, length: { in: 10..10000, too_long: "%{count} characters maximum allowed"}
  
  has_rich_text :text

  # def self.search_multiple(query)
  #   #debugger
  #   first = where("TITLE like :search OR TEXT like :search", search: query.to_s)
  #   second = joins(:category).where(category: { title: query.to_s })
  #   third = joins(:tags).where(tags: { name: query.to_s })
  #   [first, second, third].flatten.uniq
  # end

  Gutentag::ActiveRecord.call self
  
  def tags_as_string
    tag_names.join(", ")
  end

  def tags_as_string=(string)
    self.tag_names = string.split(/,\s*/)
  end
end

   
    # Article.tagged_with(:names => ['tag1', 'tag2'], :match => :any)
    # Article.tagged_with(
    # :tags  => Gutentag::Tag.where(name: ['tag1', 'tag2']),
    # :match => :any
    # )
    #  Article.tagged_with(:ids => [:tag_id], :match => :any)

      

