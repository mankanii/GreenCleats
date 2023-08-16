const mongoose = require("mongoose");

const schema = mongoose.Schema({
  team_name: {
    type: String,
    required: [true, "Team Name can not be null"],
  },
  description: {
    type: String,
    required: [true, "Team Description can not be null"],
  },
  area: {
    type: String,
    required: [true, "Team Area can not be null"],
  },
  level: {
    type: String,
    required: [true, "Team Level can not be null"],
  },
  type: {
    type: String,
    required: [true, "Team Type can not be null"],
  },
  founder_id: {
    type: String,
    required: [true, "Founder Id can not be null"],
  },
  picture_url: {
    type: String,
  },
  picture_public_id: {
    type: String,
  },
});

module.exports = mongoose.model("teams", schema);
