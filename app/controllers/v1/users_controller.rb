module V1
  class UsersController < PrivateApiController
    def index
      @users = User.all
    end
  end
end
