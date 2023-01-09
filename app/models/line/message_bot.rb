module Line
  class MessageBot

    PARTICIPATED_MESSAGE ={type: 'text', text: "ご参加ありがとうございます！\n投稿完了後、【Nel Casting LINE】にて投稿URLをお送りください。\n\n※注意※\n投稿から48時間が経過した後に、URLを送付いただいた場合、報酬は無効となります。\n予めご了承ください。"}
    TRANSFER_REQUEST_MESSAGE ={type: 'text', text: "【お知らせ】クルトン報酬のお支払い申請を受け付けました。\n\nお支払いは、お支払い月締め、翌月末払いとなります。予めご了承ください。"}

    class << self

      def push_message_for_users(uids, message)
        uids.each do |uid|
          client.push_message(uid, message)
        end
      end

      def push_message(uid, messge)
        client.push_message(uid, messge)
      end

      private

      def client
        @client ||= Line::Bot::Client.new do |config|
          config.channel_secret = ENV['LINE_CHANNEL_SECRET']
          config.channel_token = ENV['LINE_ACCESS_TOKEN']
        end
      end
    end
  end
end
