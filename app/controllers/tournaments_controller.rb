class TournamentsController < ApplicationController
  before_action :set_tournament, only: %i[show]

  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      create_divisions

      redirect_to @tournament
    else
      render :new
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def tournament_params
    params.require(:tournament).permit(:name)
  end

  def create_divisions
    Tournament::DIVISIONS_NAMES.each do |name|
      @tournament.divisions.create!(name: name)
    end
  end
end
