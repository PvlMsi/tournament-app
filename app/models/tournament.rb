class Tournament < ApplicationRecord
  has_many :divisions, dependent: :destroy
  has_one :playoff, dependent: :destroy
  has_many :matches, through: :divisions
  has_many :teams, through: :divisions

  validates_presence_of :name

  MAX_TOURNAMENT_TEAM_SIZE = 16
  DIVISIONS_NAMES = %w[A B].freeze

  def division_phase_ended?
    divisions.without_matches.empty? && matches.not_finished.empty?
  end

  def full?
    teams.count == MAX_TOURNAMENT_TEAM_SIZE
  end

  def winner
    playoff.matches.final.first&.winner
  end
end
