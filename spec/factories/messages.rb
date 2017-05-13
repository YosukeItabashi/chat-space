FactoryGirl.define do

  factory :message do
    body        "これはサンプルメッセージ"
    image       "test.png"
    group_id    "33"
    user_id     "1"
    created_at  "2017-05-10 04:05:07"
  end
end
