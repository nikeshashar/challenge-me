class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :firstname, presence: true, format: {with: /\A[a-zA-Z]+\Z/ }
  validates :lastname, presence: true, format: {with: /\A[a-zA-Z]+\Z/ }
  has_many :events
  has_many :posts
  has_many :comments

  def full_name
  	[firstname, lastname].join(' ')
  end
end