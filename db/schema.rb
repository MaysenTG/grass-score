# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_08_041739) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "winner_id"
    t.boolean "finished", default: false, null: false
    t.integer "winning_score", default: 0
    t.index ["winner_id"], name: "index_games_on_winner_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
    t.boolean "finished", default: false, null: false
    t.serial "sid", null: false
    t.bigint "winner_id"
    t.index ["game_id", "sid"], name: "index_rounds_on_game_id_and_sid", unique: true
    t.index ["game_id"], name: "index_rounds_on_game_id"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "round_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unprotected_peddle", default: 0, null: false
    t.integer "protected_peddle", default: 0, null: false
    t.integer "num_sold_out", default: 0, null: false
    t.integer "num_double_crossed", default: 0, null: false
    t.integer "num_utterly_wiped_out", default: 0, null: false
    t.boolean "banker", default: false, null: false
    t.bigint "player_id", null: false
    t.integer "banker_value", default: 0, null: false
    t.integer "highest_peddle_in_hand", default: 0
    t.integer "total_final_score", default: 0
    t.integer "total_pre_banker_score", default: 0
    t.integer "round_win_bonus", default: 0
    t.index ["player_id"], name: "index_scores_on_player_id"
    t.index ["round_id"], name: "index_scores_on_round_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "players", column: "winner_id"
  add_foreign_key "players", "games"
  add_foreign_key "rounds", "games"
  add_foreign_key "rounds", "players", column: "winner_id"
  add_foreign_key "scores", "players"
  add_foreign_key "scores", "rounds"
end
