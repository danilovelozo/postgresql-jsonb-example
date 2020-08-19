# frozen_string_literal: true

# nodoc
class UsersController < ApplicationController
  # localhost:3000/users?page=1&per_page=5&id=1

  # def index
  #   page = params[:page].to_i
  #   per_page = params[:per_page].to_i
  #   offset = (page - 1) * per_page
  #   payload = User
  #             .select('id', 'jsonb_array_elements(payload) AS payload')
  #             .all
  #             .limit(per_page)
  #             .offset(offset)
  #   render json: { object: payload }, status: 200
  # end

  def index
    payload = JSON.parse "[#{ActiveRecord::Base.connection.exec_query(sql).rows.join(',')}]"
    render json: { object: payload }, status: 200
  end

  private

  def sql
    "
    SELECT jsonb_array_elements(payload)
    FROM users
    WHERE id = #{params[:id]}
    LIMIT #{params[:per_page]} OFFSET #{params[:page].to_i(-1) * params[:per_page].to_i}
    "
  end
end
