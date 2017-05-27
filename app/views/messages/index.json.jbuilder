json.messages @messages.each do |message|
  json.name     message.user.name
  json.date     message.created_at.strftime("%Y年%m月%d日(#{%w(日 月 火 水 木 金 土)[message.created_at.wday]}) %H時%M分")
  json.body     message.body
  json.image    message.image.url
  json.id       message.id
end

