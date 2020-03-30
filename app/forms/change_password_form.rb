class ChangePasswordForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  # Add all validations you need
  validates_presence_of :old_password, :password, :password_confirmation
  validates_confirmation_of :password
  validate :verify_old_password

  attr_accessor :old_password, :password, :password_confirmation
  
  def initialize(user)
    @user = user
  end

  def submit(params)
    self.old_password = params[:old_pasword]
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]

    if valid?
      @user.password = password
      @user.password_confirmation = password_confirmation
      @user.save!
      true
    else
      false
    end
  end

  def verify_old_password
    byebug
    self.errors[:old_password] << "Not valid" unless @user.authenticate(self.old_password)
  end

  def persisted?
      false
  end
end