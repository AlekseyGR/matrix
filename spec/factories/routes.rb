# frozen_string_literal: true
FactoryGirl.define do
  factory :route do
    source Route::SOURCES.sample
    start_node Route::NODES.sample
    end_node Route::NODES.sample
    start_date DateTime.now
    end_date { DateTime.now + 1.hour }
  end
end
