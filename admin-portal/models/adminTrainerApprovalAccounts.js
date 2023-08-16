const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  full_name: {
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
  profession_category: {
    type: String,
    required: true,
  },
  gender: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("adminTrainerApprovalAccounts", schema);
