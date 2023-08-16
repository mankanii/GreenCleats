const express = require("express");
const Players = require("../models/players");
const router = express.Router();

router.get("/requestPlayersList/:player_id", (req, res) => {
  Players.aggregate(
    [
      {
        $match: { team_id: "none" },
      },
      {
        $lookup: {
          from: "requestplayers",
          localField: "player_id",
          foreignField: "requestToPlayer",
          as: "playersData",
        },
      },
    ],
    (err, playersData) => {
      if (!err) {
        res.send({ message: "Success", players: playersData });
      }
    }
  );
});

router.get("/removePlayer/:player_id", (req, res) => {
  const player_id = req.params.player_id;
  try {
    Players.findOneAndUpdate(
      { player_id: player_id },
      { team_id: "none" },
      (err) => {
        if (!err) {
          res.status(200).send({ message: "Player Removed Succesfully" });
        } else {
          res.status(400).send({ message: "Error in Player Removing" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Error Occurred" });
  }
});

module.exports = router;
