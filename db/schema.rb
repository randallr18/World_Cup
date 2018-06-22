
ActiveRecord::Schema.define(version: 2018_06_22_182348) do

  create_table "matches", force: :cascade do |t|
    t.integer "stadium_id"
    t.integer "team_id"
    t.boolean "win"
    t.string "score"
    t.string "opponent"
    t.string "home_or_away"
  end

  create_table "stadia", force: :cascade do |t|
    t.string "name"
    t.string "city"
  end

  create_table "teams", force: :cascade do |t|
    t.string "country"
    t.integer "fifa_id"
    t.string "fifa_code"
    t.integer "group_id"
    t.string "group_letter"
  end

end
