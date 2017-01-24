# frozen_string_literal: true
class Route < ApplicationRecord
  SOURCES = %w(sentinels sniffers loopholes).freeze
  NODES = %w(alpha beta gamma delta theta lambda tau psi omega).freeze

  # Validations
  validates :source, presence: true, inclusion: SOURCES
  validates :start_node, :end_node, presence: true, inclusion: NODES
  validates :start_date, :end_date, presence: true
  validate :validate_dates_order

  private

  def validate_dates_order
    return if start_date < end_date
    errors.add(:base, 'End date should be greater start date')
  end
end
