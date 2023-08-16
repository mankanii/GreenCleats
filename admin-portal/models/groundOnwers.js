const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  ground_id: {
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
  ground_name: {
    type: String,
    required: true,
  },
  location: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("groundOwners", schema);
