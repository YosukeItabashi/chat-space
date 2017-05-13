require 'rails_helper'

describe Message do
  describe '#create' do
  let(:message) { FactoryGirl.build(:message) }

    it "バリデーションに引っかかり、保存できない場合のテスト" do
      message = build(:message, body: "")
      message.valid?
      expect(message.errors[:body]).to include("を入力してください")
    end

    it "バリデーションに引っかからずに保存できる場合のテスト" do
      message = build(:message, body: "これはテストです。")
      expect(message).to be_valid
    end

  end
end
