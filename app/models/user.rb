class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validate :email_is_unique, on: :create
  after_create :create_account

  def confirmation_required?
    false
  end



  private

  def email_is_unique
    #logger.debug "################## dans la fonction email_is_unique ################# "
    return false unless self.errors[:email].empty?
    unless Account.find_by_email(email).nil?
      errors.add(:email, " already exist ")
    end
  end

  def create_account
    account = Account.new(:email => email)
    account.save!
  end
end


