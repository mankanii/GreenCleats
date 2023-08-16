const mongoose = require("mongoose");

const schema = mongoose.Schema({
  ground_id: {
    type: String,
    required: true,
  },
  date: {
    type: String,
    required: true,
  },
  start_time: {
    type: String,
    required: true,
  },
  end_time: {
    type: String,
    required: true,
  },
  booking_status: {
    type: String,
    default: "vacant",
  },
});

module.exports = mongoose.model("slots", schema);
