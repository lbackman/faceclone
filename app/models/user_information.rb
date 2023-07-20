class UserInformation < ApplicationRecord
  # https://westonganger.com/posts/make-values-nil-if-blank-data-normalization-in-rails
  before_save :normalize_blank_values

  belongs_to :user
  validates_presence_of :first_name, :last_name, :date_of_birth

  private

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end
end
