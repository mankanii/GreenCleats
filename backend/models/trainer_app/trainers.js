const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  trainer_id: {
    type: String,
    required: true,
  },
  full_name: {
    type: String,
    required: true,
  },
  email_address: {
    type: String,
    required: true,
  },
  contact_number: {
    type: String,
    required: Number,
  },
  date_of_birth: {
    type: String,
    required: true,
  },
  profession_category: {
    type: String,
    required: true,
  },
  gender: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  location: {
    type: String,
    required: true,
  },
  picture_url: {
    type: String,
    require: true,
  },
  public_id: {
    type: String,
    require: true,
  },
});

module.exports = mongoose.model("trainer", schema);
