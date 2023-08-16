const mongoose = require("mongoose");

const schema = mongoose.Schema({
  ground_id: {
    type: String,
    require: true,
  },
  picture_url: {
    type: String,
    require: true,
  },
  public_id: {
    type: String,
    require: true,
  },
});

module.exports = mongoose.model("groundImages", schema);
