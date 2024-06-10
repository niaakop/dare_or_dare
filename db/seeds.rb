# frozen_string_literal: true

require 'csv'

CSV.foreach(Rails.root.join("db/dares.csv"), headers: true) do |row|
  Dare.create!(text: row['text'])
end
