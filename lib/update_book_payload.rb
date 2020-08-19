# frozen_string_literal: true

# nodoc
class UpdateBookPayload
  def initialize(params)
    @params = params
    @book = book
  end

  def call
    iterate_params
    @book.save!
  end

  private

  def book
    Book.find(@params[:book_id])
  end

  def iterate_params
    params = @params.delete('book_id')
    params.each do |key1, value1|
      if key1 == 'authors'
        iterate_authors(key1, value1)
      else
        @book.payload[key1] = (value1 || @book.payload[key1])
      end
    end
  end

  def iterate_authors(key1, value1)
    value1.each_with_index do |value2, key2|
      value2.each do |key3, value3|
        @book.payload[key1][key2][key3] = (value3 || @book.payload[key1][key2][key3])
      end
    end
  end
end
