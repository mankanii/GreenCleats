const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  event_name: {
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
  event_status: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("event", schema);
