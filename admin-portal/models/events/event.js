const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  event_title: {
    type: String,
    required: true,
  },
  event_description: {
    type: String,
    required: true,
  },
  event_date: {
    type: String,
    required: true,
  },
  event_date_posted: {
    type: String,
    required: true,
  },
  picture_url: {
    type: String,
  },
  picture_public_id: {
    type: String,
  },
});

module.exports = mongoose.model("event", schema);
