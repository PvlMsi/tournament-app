class PlayoffsController < ApplicationController
  before_action :set_playoff

  def generate_results
    (Match.rounds.keys - ['division']).each do |round|
      ResultsGenerator.new(@playoff.matches.public_send(round)).call
    end

    redirect_to @playoff.tournament
  end

  private

  def set_playoff
    @playoff = Playoff.find(params[:id])
  end
end
