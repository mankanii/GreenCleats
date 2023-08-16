const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  email_address: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  role: {
    type: String,
    reqired: true,
  },
});

module.exports = mongoose.model("users", schema);
