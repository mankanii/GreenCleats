const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  player_id: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  email_address: {
    type: String,
    required: true,
  },
  contact_number: {
    type: Number,
    required: true,
  },
  date_of_birth: {
    type: String,
    required: true,
  },
  gender: {
    type: String,
    required: true,
  },
  position: {
    type: String,
  },
  description: {
    type: String,
  },
  achievements: {
    type: String,
  },
  experience: {
    type: String,
  },
  age: {
    type: String,
  },
  team_id: {
    type: String,
  },
  picture_url: {
    type: String,
  },
  picture_public_id: {
    type: String,
  },
});

module.exports = mongoose.model("players", schema);
