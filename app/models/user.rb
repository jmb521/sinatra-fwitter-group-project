class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, presence: true
  validates :email, uniqueness: true

  def slug
    self.username.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    slug = slug.gsub("-", " ")
    User.find_by(username: slug)
  end
end
