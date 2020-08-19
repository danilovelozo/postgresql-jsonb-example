# frozen_string_literal: true

# nodoc
class BooksController < ApplicationController
  def create
    book = Book.create!(book_params)
    render json: { status: 'OK', message: 'Book Created!', object: book }, status: 201
  end

  def update
    UpdateBookPayload.new(update_params).call
    render json: { status: 'OK', message: 'Book updated!' }, status: 200
  end

  private

  def book_params
    params.permit(
      payload: [
        :title,
        :publisher,
        :published_date,
        authors: %i[
          id
          name
        ]
      ]
    )
  end
end
