class TeamsController < ApplicationController
  before_action :set_tournament

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params.merge(division: @tournament.divisions.not_filled.sample))

    if @team.save
      redirect_to @tournament
    else
      render :new
    end
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
