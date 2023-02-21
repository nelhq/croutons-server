module Line
  class MessageBot


    TRANSFER_REQUEST_MESSAGE ={type: 'text', text: "【お知らせ】クルトン報酬のお支払い申請を受け付けました。\n\nお支払いは、お支払い月締め、翌月末払いとなります。予めご了承ください。"}
    INTEGRATED_MESSAGE ={type: 'text', text: "Tiktokアカウントの連携ありがとうございます！\n\nCroutonsよりキャンペーンの参加、Tiktok動画の投稿が可能になります！"}

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
