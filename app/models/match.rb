class Match < ApplicationRecord
  belongs_to :first_team, class_name: 'Team', foreign_key: 'first_team_id', optional: true
  belongs_to :second_team, class_name: 'Team', foreign_key: 'second_team_id', optional: true
  belongs_to :winner, class_name: 'Team', foreign_key: 'winning_team_id', optional: true
  belongs_to :parent, polymorphic: true
  belongs_to :sub_match, class_name: 'Match', foreign_key: 'sub_match_id', optional: true

  scope :finished, -> { where.not(winner: nil) }
  scope :not_finished, -> { where(winner: nil) }

  enum round: %i[division quarter_final semi_final final]
end
