require "administrate/base_dashboard"

class CampaignParticipationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    campaign: Field::BelongsTo,
    user: Field::BelongsTo,
    tiktok_movies: Field::HasMany,
    posted_movie?: Field::Boolean,
    having_status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    campaign
    user
    having_status
    posted_movie?
    tiktok_movies
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    campaign
    user
    having_status
    posted_movie?
    tiktok_movies
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    campaign
    user
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how campaign participations are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(campaign_participation)
  #   "CampaignParticipation ##{campaign_participation.id}"
  # end
  def display_resource(campaign_participation)
    "#{campaign_participation.user.user_profile.tiktok_user_name} #{campaign_participation.product.name} #{campaign_participation.campaign.name}"
  end
end
