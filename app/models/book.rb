# frozen_string_literal: true

# nodoc
class Book < ApplicationRecord
  belongs_to :user
  serialize :payload, JsonbSerializers
  store_accessor :payload, :title, :publisher, :authors

  PAYLOAD_SCHEMA = "#{Rails.root}/app/models/schemas/book_payload.json"

  validates :payload, presence: true, json: { message: ->(err) { err }, schema: PAYLOAD_SCHEMA }

  validates :title, length: { in: 3..50 }
end
