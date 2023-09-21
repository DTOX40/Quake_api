

class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  def index
    @games = Game.all
    render json: @games
  end

  def show
    render json: @game
  end

  def create
    parser = QuakeLogParser.new(Rails.root.join('public', 'quake', 'log_game.log').to_s)
    games_data = parser.parse_log
  
    games_data.each do |game_key, game_data|
      Game.create(
        total_kills: game_data['total_kills'],
        players: game_data['players'],
        kills: game_data['kills']
      )
    end
  
    @game = Game.new(game_params)
  
    if @game.save
      render json: @game, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:total_kills, players: [], kills: {})
  end
end
