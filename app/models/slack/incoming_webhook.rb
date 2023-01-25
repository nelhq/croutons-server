module Slack
  class IncomingWebhook
    SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/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'

    def self.croutons_notifier
      Slack::Notifier.new(SLACK_WEBHOOK_URL, username: 'croutons_notifier', icon_emoji: ':sunglasses:')
    end
  end
end
