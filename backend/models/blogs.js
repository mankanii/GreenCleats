const mongoose = require("mongoose");

const schema = new mongoose.Schema({
  blog_author: {
    type: String,
    required: true,
  },
  blog_category: {
    type: String,
    required: true,
  },
  date: {
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
});

module.exports = mongoose.model("blogs", schema);
