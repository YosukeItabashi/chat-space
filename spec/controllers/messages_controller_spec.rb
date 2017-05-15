require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:messages){ create_list(:message, 3, user: user, group: group) }

#indexアクションの検証
    describe 'GET #index' do
      let(:params) { { group_id: group.id } }
        context "ログイン時" do
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

        context "非ログイン時" do
          it "new_user_session_pathへリダイレクトするか" do
            get :index, params
            expect(response).to redirect_to(new_user_session_path)
          end
        end
    end

#createアクションの検証
    describe 'POST #create' do
      let(:params) { { group_id: group.id, message: { body: "LGTM欲しさある" } } }

      context "ログイン時" do
        before do
          login_user user
        end

          it "group_messages_pathへ遷移するか" do
            post :create, params
            expect(response).to redirect_to(group_messages_path)
          end

          it "Messageの保存がされているか" do
            expect {
              post :create, params
            }.to change(Message, :count).by(1)
          end

          it "バリデーションにかかった場合は、messageの保存が行われなかったか" do
            expect {
              post :create, group_id: group.id, message: { body: "" }
              }.to change(Message, :count).by(0)
          end
      end

      context "非ログイン時" do
        it "group_messages_pathへ遷移するか" do
          post :create, params
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
end
