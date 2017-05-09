class GroupsController < ApplicationController
  before_action :find_group_params, only: [:edit, :update]

    def edit
    end

    def new
      @group = Group.new
    end

    def create
      @group = Group.new(group_params)
      if @group.save
        redirect_to :root, notice: "グループを作成しました"
      else
        flash.now[:alert] = "グループ名を入力してください"
        render 'new'
      end
    end

    def update
      if @group.update(group_params)
        redirect_to :root, notice: "グループを編集しました"
      else
        flash.now[:alert] = "グループ名を入力してください"
        render :edit
      end
    end

    private

    def group_params
      params.require(:group).permit(:name, user_ids: [])
    end

    def find_group_params
      @group = Group.find(params[:id])
    end

end
