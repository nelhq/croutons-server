require "administrate/base_dashboard"

class TiktokMovieProfileDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    cover_image_url: Field::String,
    duration: Field::Number,
    embed_html: Field::Text,
    embed_link: Field::Text,
    height: Field::Number,
    posted_at: Field::DateTime,
    share_url: Field::Text,
    tiktok_movie: Field::BelongsTo,
    title: Field::String,
    uid: Field::String,
    video_description: Field::Text,
    width: Field::Number,
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
    cover_image_url
    duration
    embed_html
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    cover_image_url
    duration
    embed_html
    embed_link
    height
    posted_at
    share_url
    tiktok_movie
    title
    uid
    video_description
    width
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    cover_image_url
    duration
    embed_html
    embed_link
    height
    posted_at
    share_url
    tiktok_movie
    title
    uid
    video_description
    width
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

  # Overwrite this method to customize how tiktok movie profiles are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(tiktok_movie_profile)
  #   "TiktokMovieProfile ##{tiktok_movie_profile.id}"
  # end
end
