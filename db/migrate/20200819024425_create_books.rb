# frozen_string_literal: true

# nodoc
class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.integer :user_id
      t.jsonb :payload, null: false, default: '{}'
      t.timestamps
    end

    add_index :books, :payload, using: :gin

    # add_index :books, :payload, "payload ->> 'title'", using: :gin, name: "index_pictures_on_title"

    # add_index :books, :payload, "payload #>> '{authors,0,name}'", using: :gin, name: "index_pictures_on_first_author_name"
  end
end
