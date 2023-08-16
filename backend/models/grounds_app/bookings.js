const mongoose = require("mongoose");

const schema = mongoose.Schema({
  slot_id: {
    type: String,
    require: true,
  },
  ground_id: {
    type: String,
    require: true,
  },
  team_id: {
    type: String,
    require: true,
  },
  player_id: {
    type: String,
    require: true,
  },
  payment_method: {
    type: String,
    require: true,
  },
  date: {
    type: String,
    require: true,
  },
});

module.exports = mongoose.model("groundBooking", schema);
