class Division < ApplicationRecord
  belongs_to :tournament
  has_many :teams, dependent: :destroy

  has_many :matches, as: :parent, dependent: :destroy, inverse_of: :parent

  scope :not_filled, -> { left_joins(:teams).group('divisions.id').having('count(teams.id) < ?', MAX_DIVISION_TEAMS_SIZE) }
  scope :without_matches, -> { includes(:matches).where(matches: { id: nil }) }

  MAX_DIVISION_TEAMS_SIZE = 8

  def full?
    teams.size == MAX_DIVISION_TEAMS_SIZE
  end

  def top_four_teams
    teams.order_by_wins.first(4)
  end
end
