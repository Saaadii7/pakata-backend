class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  enum gender: %i[male female gay lesbian confused complicated transgender shemale
                  prefer_not_to_disclose]
  # client.really_destroy!
end
