const mongoose = require("mongoose");

const schema = mongoose.Schema({
  post_owner_id: {
    type: String,
    required: true,
  },
  post_content: {
    type: String,
    required: true,
  },
  // likes: {
  //   type: Number,
  //   default: 0,
  // },
  // liked_by: {
  //   type: String,
  //   default: "",
  // },
  post_image_url: {
    type: String,
  },
  post_public_id: {
    type: String,
  },
  post_date: {
    type: String,
    default:
      new Date().toLocaleDateString() + "-" + new Date().toLocaleTimeString(),
  },
});

module.exports = mongoose.model("posts", schema);
