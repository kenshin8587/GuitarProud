class Post < ApplicationRecord
  belongs_to :user

  validates :bandname, presence: true, length: { maximum: 255 }
  validates :member, presence: true, numericality: { in: 0..15 }
  validates :part, presence: true, length: { maximum: 255 }
  
  scope :get_by_bandname, ->(bandname) { where("bandname like ?", "%#{bandname}%") }
  scope :get_by_part, ->(part) { where("part like ?", "%#{part}%") } 
  
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
end
