require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:messages){create_list(:message, 3, user: user, group: group)}

# indexアクションの検証
    describe 'GET #index' do

      it "＜ログイン中＞indexビューが表示されるか" do
        login_user user
        get :index, group_id: group
        expect(response).to render_template :index
      end

      it "＜非ログイン中＞new_user_session_pathへリダイレクトするか" do
        get :index, group_id: group
        expect(response).to redirect_to(new_user_session_path)
      end

      it "@messagesの中身は期待した通りのものが取得できているか" do
        login_user user
        get :index, group_id: group
        expect(assigns(:messages)).to match(messages)
      end

    end

# createアクションの検証
    describe 'POST #create' do

      it "＜ログイン中＞group_messages_pathへ遷移するか" do
        login_user user
        post :create, group_id: group, message: {body: "テスト嫌い" }
        expect(response).to redirect_to(group_messages_path)
      end

      it "＜非ログイン中＞group_messages_pathへ遷移するか" do
        post :create, group_id: group, message: {body: "テスト嫌い" }
        expect(response).to redirect_to(new_user_session_path)
      end

      it "Messageの保存がされているか" do
        login_user user
        expect {
          post :create, group_id: group, message: {body: "テスト嫌い" }
        }.to change(Message, :count).by(1)
      end

    end
end
