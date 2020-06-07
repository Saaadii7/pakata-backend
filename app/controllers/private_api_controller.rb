class PrivateApiController < ApplicationController
  before_action :require_current_user
end
