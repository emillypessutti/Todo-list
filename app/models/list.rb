class List < ApplicationRecord
  has_many :items, dependent: :destroy
end
