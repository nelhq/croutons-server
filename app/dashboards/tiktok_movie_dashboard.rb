require "administrate/base_dashboard"

class TiktokMovieDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    tiktok_uid: Field::Text,
    tiktok_movie_logs: Field::HasMany,
    tiktok_movie_log_after_48_hours: Field::HasOne,
    view_count_after_48_hours: Field::Number,
    user: Field::BelongsTo,
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
    user
    tiktok_uid
    tiktok_movie_logs
    tiktok_movie_log_after_48_hours
    view_count_after_48_hours
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    user
    tiktok_uid
    tiktok_movie_logs
    tiktok_movie_log_after_48_hours
    view_count_after_48_hours
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    tiktok_uid
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

  # Overwrite this method to customize how tiktok movies are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(tiktok_movie)
  #   "TiktokMovie ##{tiktok_movie.id}"
  # end
  def display_resource(tiktok_movie)
    "#{tiktok_movie.user.user_profile.tiktok_user_name} #{tiktok_movie.tiktok_uid}"
  end
end
