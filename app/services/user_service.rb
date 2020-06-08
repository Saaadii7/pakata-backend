class UserService
  def initialize(message)
    @message = message
  end

  def all
    User.all
  end
end
