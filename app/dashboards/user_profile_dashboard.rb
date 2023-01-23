require "administrate/base_dashboard"

class UserProfileDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    line_user_id: Field::String,
    line_user_image_url: Field::String,
    line_user_name: Field::String,
    tiktok_open_id: Field::String,
    tiktok_profile_deep_link: Field::Text,
    tiktok_union_id: Field::String,
    tiktok_user_image_url: Field::Text,
    tiktok_user_name: Field::String,
    user_id: Field::Number,
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
    line_user_id
    line_user_image_url
    line_user_name
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    line_user_id
    line_user_image_url
    line_user_name
    tiktok_open_id
    tiktok_profile_deep_link
    tiktok_union_id
    tiktok_user_image_url
    tiktok_user_name
    user_id
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    line_user_id
    line_user_image_url
    line_user_name
    tiktok_open_id
    tiktok_profile_deep_link
    tiktok_union_id
    tiktok_user_image_url
    tiktok_user_name
    user_id
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

  # Overwrite this method to customize how user profiles are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user_profile)
  #   "UserProfile ##{user_profile.id}"
  # end
end
