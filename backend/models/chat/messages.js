const mongoose = require("mongoose");

const messageSchema = mongoose.Schema({
  sender_id: {
    type: String,
    required: true,
  },
  receiver_id: {
    type: String,
    required: true,
  },
  message_content: {
    type: String,
    required: true,
  },
  date: {
    type: String,
    default: new Date().toLocaleDateString(),
  },
});

module.exports = mongoose.model("message", messageSchema);
