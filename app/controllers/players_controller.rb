class PlayersController < ApplicationController
  before_action :set_game
  before_action :set_player, only: %i[ show edit update destroy ]
  before_action :can_create_player?
  before_action :return_to_game, only: %i[ new create edit update destroy ]

  # GET /players or /players.json
  def index
    @players = Player.all
  end

  # GET /players/1 or /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = @game.players.build
    # @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players or /players.json
  def create
    @player = @game.players.build(player_params)
    # @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @game, notice: "Player was successfully created." }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @game, notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy!

    respond_to do |format|
      format.html { redirect_to @game, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = @game.players.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def player_params
    params.require(:player).permit(:name)
  end

  def can_create_player?
    return unless @game.finished?

    redirect_to game_path(@game), notice: "This game is in progress and players can't be added"
  end
end
