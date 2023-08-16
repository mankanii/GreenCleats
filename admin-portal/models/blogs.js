const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  category: {
    type: String,
    required: true,
  },
  blog_author: {
    type: String,
    required: true,
  },
  blog_title: {
    type: String,
    required: true,
  },
  blog_description: {
    type: String,
    required: true,
  },
  date: {
    type: String,
    required: true,
  },
  picture_url: {
    type: String,
  },
  picture_public_id: {
    type: String,
  },
});

module.exports = mongoose.model("blogs", schema);
