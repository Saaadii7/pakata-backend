# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  deleted_at             :datetime
#  dob                    :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  gender                 :integer
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  user_name              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_user_name             (user_name)
#
class User < ApplicationRecord
  rolify
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  # attributes
  enum gender: %i[male female gay lesbian confused complicated transgender shemale
                  prefer_not_to_disclose]

  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    # (?=.*[a-z])        # Must contain a lower case character
    # (?=.*[A-Z])        # Must contain an upper case character
    # (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  # validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :password,
            presence: true,
            length: { in: Devise.password_length },
            format: { with: PASSWORD_FORMAT },
            confirmation: true,
            on: :create

  validates :password,
            allow_nil: true,
            length: { in: Devise.password_length },
            format: { with: PASSWORD_FORMAT },
            confirmation: true,
            on: :update
  # user.really_destroy!

  # associations

  # scopes

  # callbacks

  # instance methods
  def age
    (Date.today - dob.to_datetime).to_i
  end
end
