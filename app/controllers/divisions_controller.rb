class DivisionsController < ApplicationController
  before_action :set_division

  def generate_results
    DivisionMatchesGenerator.new(@division).call
    ResultsGenerator.new(@division.matches).call

    generate_playoff_matches if @division.tournament.division_phase_ended?

    redirect_to @division.tournament
  end

  private

  def set_division
    @division = Division.find(params[:id])
  end

  def generate_playoff_matches
    playoff = @division.tournament.playoff || Playoff.create!(tournament: @division.tournament)
    PlayoffMatchesGenerator.new(playoff).call
  end
end
