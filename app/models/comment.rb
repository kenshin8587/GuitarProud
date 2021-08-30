class Comment < ApplicationRecord
  has_many :replies

  belongs_to :user
  belongs_to :post
end
