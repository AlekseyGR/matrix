# frozen_string_literal: true
class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :source
      t.string :start_node
      t.string :end_node
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
