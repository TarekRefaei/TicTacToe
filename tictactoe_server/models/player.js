const mongoose = require("mongoose");

const playerSchema = new mongoose.Schema({
  playerName: {
    type: String,
    trim: true,
  },
  socketID: {
    type: String,
  },
  points: {
    type: Number,
    default: 0,
  },
  playerType: {
    require: true,
    type: String,
  },
  // isPlaying: {
  //   require: true,
  //   type: Boolean,
  //   default: false,
  // },
});

module.exports = playerSchema;