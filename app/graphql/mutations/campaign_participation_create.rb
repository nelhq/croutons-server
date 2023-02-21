# frozen_string_literal: true

module Mutations
  class CampaignParticipationCreate < Mutations::BaseMutation
    argument :campaign_id, String, required: true
    argument :user_id, String, required: true
    argument :having_status, String, required: true

    field :campaign_participation, Types::Objects::CampaignParticipationType, null: false

    def authorized?(args)
      context[:current_user].present? && context[:current_user].id.to_s == args[:user_id]
    end

    def resolve(**args)
      user = User.find(args[:user_id])
      campaign = Campaign.find(args[:campaign_id])
      campaign_participation = ::CampaignParticipation.new(args)

      if campaign_participation.save
        Line::MessageBot.push_message(user.line_user_id, line_message(campaign))
        {
          campaign_participation: campaign_participation
        }
      else
        # raise_resource_errors(campaign)
      end
    end

    def line_message(campaign)
      {type: 'text', text: "ご参加ありがとうございます！\nご投稿お待ちしております！！\n\n▼今回ご参加いただいた商品\n参加商品名：#{campaign.product.name}\n投稿期限：#{campaign.parsed_posted_period_contains_hours}\n\n▼今後の流れ\n1. 商品をお持ちでない場合は、商品を購入する\n2. 動画を作成し投稿する\n3. LINEのメッセージで投稿URLを送信する\n4. クルトン運営にて、動画の可否審査を行います\n5. 審査完了後、報酬が確定し、My walletに金額が表示されます\n\n▼投稿ルール\n以下より詳細をご確認いただけます\nhttps://nelinc.notion.site/138f5dae38934aa5a0a249a7afe3cc4b\n\n※注意事項※\n・#クルトンズ #croutons_ad #購入品 #ブランド名のハッシュタグをつけてください\n・投稿の秒数の1/3以上は商品の言及をしてください\n・投稿から48時間が経過した後に、URLを送付いただいた場合、計測が出来かねますため報酬は無効となります。予めご了承ください。"}
    end
  end
end
