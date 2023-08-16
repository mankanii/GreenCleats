const express = require("express");
const RequesPlayers = require("../models/requestPlayers");
const Player = require("../models/players");
const Team = require("../models/teams");
const { json } = require("body-parser");
const router = express.Router();

// API to Fetch requests Users have received
router.get("/receivedRequestPlayer/:player_id", async (req, res) => {
  const player_id = req.params.player_id;
  try {
    RequesPlayers.aggregate(
      [
        {
          $match: { requestToPlayer: player_id },
        },
        {
          $lookup: {
            from: "players",
            localField: "requestFromPlayer",
            foreignField: "player_id",
            as: "playersData",
          },
        },
        { $addFields: { teamId: { $toObjectId: "$team_id" } } },
        {
          $lookup: {
            localField: "teamId",
            from: "teams",
            foreignField: "_id",
            as: "teamsData",
          },
        },
        { $unwind: "$playersData" },
        { $unwind: "$teamsData" },
        {
          $project: {
            "playersData.player_id": 1,
            "playersData.name": 1,
            "teamsData._id": 1,
            "teamsData.team_name": 1,
            "teamsData.picture_url": 1,
          },
        },
      ],
      (err, data) => {
        if (!err) {
          res.status(200).send({ message: "Success", data: data });
        } else {
          console.log("Error: " + err);
          res.status(404).send({ message: "Record Not Found" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Error" + error });
  }
});

// API to send the request to a player
router.post("/sendRequestPlayer", (req, res) => {
  const { requestToPlayer, requestFromPlayer, teamID } = req.body;
  try {
    const requestPlayer = RequesPlayers({
      requestFromPlayer: requestFromPlayer,
      requestToPlayer: requestToPlayer,
      team_id: teamID,
    });
    RequesPlayers.create(requestPlayer, (err) => {
      if (!err) {
        res.status(200).send({ message: "Request Sent" });
      } else {
        res.status(404).send({ message: "Bad Request" });
      }
    });
  } catch (error) {
    res.status(500).send({ message: "Error Occurred " + error });
  }
});

// API to cancel the "sent request" to a player
router.post("/requestCancel", (req, res) => {
  const { requestFromPlayer, requestToPlayer } = req.body;
  try {
    RequesPlayers.deleteOne(
      {
        requestFromPlayer: requestFromPlayer,
        requestToPlayer: requestToPlayer,
      },
      (err) => {
        if (!err) {
          console.log("Record Deleted");
          res.status(200).send({ message: "Request Cancelled" });
        } else {
          res.status(400).send({ message: "Request Cancellation Failed" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Error Occurred" });
  }
});

//API to accept the request sent by the captain of the team
router.post("/requestAccept", (req, res) => {
  const { sender_player_id, team_id, own_player_id } = req.body;

  try {
    Player.findOneAndUpdate(
      { player_id: own_player_id },

      {
        team_id: team_id,
      },

      (err) => {
        if (!err) {
          RequesPlayers.deleteMany(
            { requestToPlayer: own_player_id },
            (err) => {
              if (!err) {
                console.log("Request accepted");
                res.status(200).send({ message: "Request Accepted" });
              } else {
                console.log("Request Error");
                res.status(400).send({ message: "No Request Found" });
              }
            }
          );
        } else {
          console.log("Request Error 2");
          res.status(400).send({ message: "Player Not Found" });
        }
      }
    );
  } catch (error) {
    console.log("Error " + error);
    res.status(500).send({ message: "Error Occurred" });
  }
});

//API to reject the request sent by the captain of the team
router.post("/requestReject", (req, res) => {
  const { requestFromPlayer, teamId, requestToPlayer } = req.body;
  try {
    RequesPlayers.findOneAndDelete(
      {
        requestFromPlayer: requestFromPlayer,
        requestToPlayer: requestToPlayer,
        team_id: teamId,
      },
      (err, doc) => {
        if (!err && doc) {
          console.log("Deleted");
          res.status(200).send({ message: "Request Rejected" });
        } else {
          console.log("Not Deleted");
          res.status(400).send({ message: "Request Rejection Failed" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error" });
  }
});

module.exports = router;
