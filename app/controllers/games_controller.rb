class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]
  before_action :return_to_game, only: %i[ new create edit update destroy ]

  # GET /games or /games.json
  def index
    if params[:search].present?
      @games = Game.where("name ILIKE ?", "%#{params[:search]}%")
    else
      @games = Game.all
    end

    @query = params[:search]

    respond_to do |format|
      format.html
      format.turbo_stream { render partial: "games_list", locals: { games: @games, query: params[:search] } }
    end
  end

  # GET /games/1 or /games/1.json
  def show
    # @rounds = @game.rounds
    @create_round_disabled = @game.rounds.exists?(finished: false)
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy!

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def finish
    @game = Game.find(params[:game_id])
    @game.update!(finished: true)

    redirect_to game_url(@game), notice: "Game finished!"
  end

  private

  def set_game
    @game = Game.includes(rounds: :scores, players: :scores).find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :winning_score)
  end
end
