# frozen_string_literal: true

class ResultsGenerator
  attr_reader :matches

  def initialize(matches)
    @matches = matches
  end

  def call
    matches.sort.each do |match|
      match.update_attributes(
        winner: get_winner(match)
      )
      fill_sub_match_team(match.sub_match, match.winner) if match.sub_match && match.winner
    end
  end

  private

  def get_winner(match)
    [match.first_team, match.second_team].sample
  end

  def fill_sub_match_team(sub_match, winner)
    sub_match.first_team = sub_match.first_team || winner
    sub_match.second_team = winner if sub_match.first_team != winner

    sub_match.save!
  end
end
