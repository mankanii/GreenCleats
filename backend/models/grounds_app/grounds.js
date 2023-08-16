const mongoose = require("mongoose");

const groundSchema = new mongoose.Schema({
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
  ground_description: {
    type: String,
    default: "Welcome",
  },
  location: {
    type: String,
    required: true,
  },
  fees: {
    type: String,
    default: "500",
  },
});

module.exports = mongoose.model("groundowners", groundSchema);
