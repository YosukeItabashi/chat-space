class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.limit(5)
    @group = Group.find(params[:group_id])
    @users = @group.users
  end

end
