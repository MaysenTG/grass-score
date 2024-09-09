class ScoresController < ApplicationController
  before_action :set_game
  before_action :set_round
  before_action :set_score, only: %i[ show edit update destroy ]
  before_action :return_to_rounds, if: -> { @round.scores.count == @game.players.count }, only: %i[ new ]
  before_action :return_to_game, only: %i[ new create edit update destroy ]

  # GET /scores or /scores.json
  def index
    redirect_to game_round_path(@game, @round)
  end

  # GET /scores/1 or /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    return redirect_to game_round_path(@game, @round), notice: "All players have been scored" if @round.scores.count == @game.players.count

    if params[:player_id]
      @score = @round.scores.build(player_id: params[:player_id])
    else
      @score = @round.scores.build
    end

    @player = @game.players.find_by(id: params[:player_id])
  end

  # GET /scores/1/edit
  def edit
    redirect_to game_round_path(@game, @round), notice: "This round has already finished" if @round.finished?
  end

  # POST /scores or /scores.json
  def create
    player_id = params[:player_id] || score_params[:player_id]
    updated_score_params = score_params.merge(player_id: player_id)
    @score = @round.scores.build(updated_score_params)

    respond_to do |format|
      if @score.save && CalculateScores.call(@round)
        format.html { redirect_to game_round_path(@game, @round), notice: "Score was successfully created." }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1 or /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params) && CalculateScores.call(@round)
        format.html { redirect_to game_round_path(@game, @round), notice: "Score was successfully updated." }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1 or /scores/1.json
  def destroy
    @score.destroy!

    respond_to do |format|
      format.html { redirect_to game_round_scores_url, notice: "Score was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def return_to_rounds
    redirect_to game_round_path(@game, @round), notice: "All players have been scored"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = current_account.games.find(params[:game_id])
  end

  def set_round
    @round = @game.rounds.find(params[:round_id])
  end

  def set_score
    @score = @round.scores.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def score_params
    params.require(:score).permit(:round_id, :player_id, :protected_peddle, :unprotected_peddle, :num_sold_out, :num_double_crossed, :num_utterly_wiped_out, :banker, :highest_peddle_in_hand).to_h
  end
end
