const mongoose = require("mongoose");

const schema = mongoose.Schema({
  trainer_id: {
    type: String,
    required: true,
  },
  package_name: {
    type: String,
    required: true,
  },
  package_price: {
    type: Number,
    required: true,
  },
  package_description: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("packages", schema);
