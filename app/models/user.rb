class User < ActiveRecord::Base
    acts_as_authentic do |c|
    c.login_field = 'email'

  end # block optional
  has_many :medicines
  belongs_to :role

  def admin?
   role == 0 # If you have id == 0 for admin
  end
end