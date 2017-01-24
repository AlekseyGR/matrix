# frozen_string_literal: true
module Entities
  class Route < Grape::Entity
    expose :id
    expose :source
    expose :start_node
    expose :end_node
    expose :start_date
    expose :end_date
    expose :created_at
    expose :updated_at
  end
end
