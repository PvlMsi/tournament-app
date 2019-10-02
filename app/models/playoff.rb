class Playoff < ApplicationRecord
  belongs_to :tournament

  has_many :matches, as: :parent, dependent: :destroy, inverse_of: :parent
end
