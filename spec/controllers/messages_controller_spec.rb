require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:messages){create_list(:message, 3, user: user, group: group)}

# indexアクションの検証
# ログイン時
    describe 'GET #index' do
      let(:params) { {group_id: group.id } }

      before do
        login_user user
      end

      it "indexビューが表示されるか" do
        get :index, params
        expect(response).to render_template :index
      end

      it "@messagesの中身は期待した通りのものが取得できているか" do
        get :index, params
        expect(assigns(:messages)).to match(messages)
      end
    end

# 非ログイン時
    describe 'GET #index' do
      let(:params) { {group_id: group.id } }

        it "new_user_session_pathへリダイレクトするか" do
          get :index, params
          expect(response).to redirect_to(new_user_session_path)
        end
    end

# createアクションの検証
# ログイン時
    describe 'POST #create' do
      let(:params) { {group_id: group.id, message: { body: "LGTM欲しさある" }} }

      before do
        login_user user
      end

      it "group_messages_pathへ遷移するか" do
        login_user user
        post :create, params
        expect(response).to redirect_to(group_messages_path)
      end

      it "Messageの保存がされているか" do
        login_user user
        expect {
          post :create, params
        }.to change(Message, :count).by(1)
      end
    end

# 非ログイン時
    describe 'POST #create' do
      let(:params) { {group_id: group.id, message: { body: "LGTM欲しさある" }} }

      it "＜非ログイン中＞group_messages_pathへ遷移するか" do
        post :create, params
        expect(response).to redirect_to(new_user_session_path)
      end
    end

end
