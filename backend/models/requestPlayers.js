const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  requestToPlayer: {
    type: String,
    required: true,
  },
  requestFromPlayer: {
    type: String,
    required: true,
  },
  team_id: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("requestPlayers", schema);
