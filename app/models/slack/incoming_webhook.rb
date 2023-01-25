module Slack
  class IncomingWebhook
    SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/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'

    def self.notifier
      Slack::Notifier.new(SLACK_WEBHOOK_URL, username: 'notifier', icon_emoji: ':sunglasses:')
    end
  end
end
