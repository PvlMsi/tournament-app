# frozen_string_literal: true

class DivisionMatchesGenerator
  attr_reader :division

  def initialize(division)
    @division = division
  end

  def call
    rest_teams = division.teams.to_a

    division.teams.each do |primary_team|
      rest_teams.shift
      generate_current_team_matches(primary_team, rest_teams)
    end
  end

  private

  def generate_current_team_matches(primary_team, rest_teams)
    rest_teams.each do |team|
      division.matches.create!(
        first_team: primary_team,
        second_team: team,
        round: 'division'
      )
    end
  end
end
