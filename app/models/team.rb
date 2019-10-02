class Team < ApplicationRecord
  belongs_to :division
  delegate :tournament, to: :division

  scope :order_by_wins, -> { sort_by { |team| -team.division_matches_won } }

  validates_presence_of :name

  def matches(round)
    Match.public_send(round).where('first_team_id = ? OR second_team_id = ?', id, id)
  end

  def division_matches
    matches(:division)
  end

  def division_matches_won
    division_matches.where(winning_team_id: id).count
  end

  def division_matches_lost
    division_matches.count - division_matches_won
  end
end
