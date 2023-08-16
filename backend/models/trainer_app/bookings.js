const mongoose = require("mongoose");

const schema = mongoose.Schema({
  package_id: {
    type: String,
    require: true,
  },
  trainer_id: {
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
  payment_details: {
    type: String,
    require: true,
  },
  date_booking: {
    type: String,
    require: true,
  },
  subscription_status: {
    type: String,
    default: "active",
  },
});

module.exports = mongoose.model("trainerbooking", schema);
