# frozen_string_literal: true

class PlayoffMatchesGenerator
  attr_reader :playoff

  SEMI_FINAL_MATCHES_SIZE = 2

  def initialize(playoff)
    @playoff = playoff
  end

  def call
    final_match = generate_final
    semi_final_matches = generate_semi_finals(final_match)
    generate_quarter_final(semi_final_matches)
  end

  private

  def generate_final
    playoff.matches.create!(
      round: 'final'
    )
  end

  def generate_semi_finals(final_match)
    SEMI_FINAL_MATCHES_SIZE.times.map do
      playoff.matches.create!(
        sub_match: final_match,
        round: 'semi_final'
      )
    end
  end

  def generate_quarter_final(semi_final_matches)
    divisions.first.top_four_teams.each_with_index do |team, index|
      playoff.matches.create!(
        first_team: team,
        second_team: divisions.last.top_four_teams[3 - index],
        sub_match: semi_final_matches[index > 1 ? 1 : 0],
        round: 'quarter_final'
      )
    end
  end

  def divisions
    @divisions ||= playoff.tournament.divisions
  end
end
