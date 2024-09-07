class RoundsController < ApplicationController
  before_action :set_game
  before_action :set_round, only: %i[ show edit update destroy ]
  before_action :return_to_game, only: %i[ new create edit update destroy ]

  # GET /rounds or /rounds.json
  def index
    @rounds = @game.rounds
  end

  # GET /rounds/1 or /rounds/1.json
  def show
  end

  # GET /rounds/new
  def new
    @round = @game.rounds.build
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds or /rounds.json
  def create
    # @round = Round.new(round_params)
    @round = @game.rounds.build(round_params)

    respond_to do |format|
      if @round.save
        format.html { redirect_to [@game, @round], notice: "Round was successfully created." }
        format.json { render :show, status: :created, location: @round }
      else
        format.html { redirect_to game_url(@game), notice: "Round could not be created. #{@round.errors.full_messages.to_sentence}" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rounds/1 or /rounds/1.json
  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to games_round_url(@game, @round), notice: "Round was successfully updated." }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1 or /rounds/1.json
  def destroy
    @round.destroy!

    respond_to do |format|
      format.html { redirect_to game_rounds_url, notice: "Round was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def finish
    @round = @game.rounds.find(params[:round_id])
    @round.finish!

    respond_to do |format|
      format.html { redirect_to game_path(@game), notice: "Round #{@round.sid} was successfully finished." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_round
    @round = @game.rounds.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def round_params
    params.fetch(:round, {})
  end
end
