class GroupsController < ApplicationController

    def index
        redirect_to :root
    end

    def edit
    end

    def new
      @group = Group.new
    end

    def create
      @group = Group.new(group_params)
      if @group.save
        redirect_to :root
      else
        render 'new'
      end
    end

    private

    def group_params
      params.require(:group).permit(:name)
      # group_usersのDBに保存されないとだめじゃない？と思ってる
    end

end
