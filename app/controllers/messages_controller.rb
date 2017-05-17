class MessagesController < ApplicationController
  before_action :before_reload_data

  def index
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path, notice: "メッセージが投稿されました。" }
        format.json { render 'create.json.jbuilder' }
      end
    else
      redirect_to group_messages_path, alert: "メッセージを入力してください"
    end
  end

  private
  def before_reload_data
    @groups = current_user.groups.order(id: :DESC)
    @group = Group.find(params[:group_id])
    @users = @group.users
    @message = Message.new
    @messages = @group.messages
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id])
  end

end
