class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, uniqueness: true

  before_create :generate_auth_token!

  def generate_auth_token!
    self.auth_token = random_unique_token
  end

  private
  def random_unique_token
    existing_tokens = User.all.map { |user| user.auth_token }
    new_token = random_token
    while existing_tokens.include?(new_token)
      new_token = random_token
    end
    new_token
  end

  def random_token
    SecureRandom.hex(8)
  end
end
