const express = require("express");
const Teams = require("../models/teams");
const Player = require("../models/players");
const cloudinary = require("../utils/cloudinary");

const router = express.Router();

router.get("/fetchPlayers/:team_id", (req, res) => {
  const team_id = req.params.team_id;
  try {
    Player.find({ team_id: team_id }, (err, playersData) => {
      if (!err && playersData !== null) {
        res.status(200).send({ message: "Success", players: playersData });
      } else {
        res.status(400).send({ message: "Players not Found!" });
      }
    });
  } catch (error) {
    res.status(500).send({ message: "Error Occured" });
  }
});

router.get("/fetchTeam/:team_id", (req, res) => {
  const team_id = req.params.team_id;
  try {
    Teams.findById(team_id, (err, teamData) => {
      if (!err && teamData !== null) {
        res.status(200).send({
          team: teamData,
        });
      }
    });
  } catch (error) {}
});
router.get("/team/:id", (req, res) => {
  const id = req.params.id;
  try {
    Player.findOne({ player_id: id }, (err, player) => {
      if (!err && player !== null) {
        Teams.findOne({ _id: player.team_id }, (err, teamData) => {
          if (!err && teamData !== null) {
            Player.find({ team_id: teamData._id }, (err, players) => {
              if (!err) {
                res.status(200).send({
                  team: teamData,
                  players: players,
                });
              } else {
                res.status(404).send({ message: "Players Not Found" });
              }
            });
          }
        });
      }
    });

  } catch (error) {
    res.status(500).send({ message: "Error Occurred" });
  }
});

router.get("/teamList", (req, res) => {
  try {
    Teams.find({}, (err, teams) => {
      res.status(200).send({ message: "Success", teams: teams });
    });
  } catch (error) {
    res.status(500).send({ message: "Error\n" + error });
  }
});

router.post("/registerTeam", async (req, res) => {
  const { team_name, description, area, level, type, founder_id } = req.body;

  const team = Teams({
    team_name: team_name,
    description: description,
    area: area,
    level: level,
    type: type,
    founder_id: founder_id,
  });

  await Teams.create(team, (err) => {
    if (!err) {
      Player.findOneAndUpdate(
        { player_id: founder_id },
        {
          team_id: team._id,
        },
        (err) => {
          if (!err) {
            res.status(200).send({ message: "Team created Successfully", teamId: team._id });
          } else {
            res.status(400).send({
              message: "Team created but Error Occurred Check Log File",
            });
          }
        }
      );
    } else {
      res.status(500).send({ message: "Error Occurred\nTry Again" });
    }
  });
});

router.post("/updateTeam/:team_id", async (req, res) => {
  // const readFile = Buffer.from(req.body.picture, "base64");
  const teamId = req.params.team_id;
  var { teamName, description, area, level, type, picture } = req.body;
  try {
    Teams.findById({ _id: teamId }, async (err, team) => {
      if (!err && team !== null) {
        if (picture !== "") {
          picture = "data:image/jpeg;base64," + picture;
          const result = await cloudinary.uploader.upload(
            picture,
            {
              folder: "Teams",
            },
            async (err, response) => {
              if (!err) {
                Teams.findOneAndUpdate(
                  { _id: teamId },
                  {
                    team_name: teamName,
                    description: description,
                    area: area,
                    level: level,
                    type: type,
                    picture_url: response.secure_url,
                    picture_public_id: response.public_id,
                  },
                  (err) => {
                    if (!err) {
                      res
                        .status(200)
                        .send({ message: "Team updated Successfully" });
                    } else {
                      res.status(400).send({
                        message: "Team could not be updated due to some error",
                      });
                    }
                  }
                );
                await cloudinary.uploader
                  .destroy(team.picture_public_id)
                  .catch((err) => {
                    console.log("Error in deleting image");
                  });
              } else {
                console.log("Error in Cloudinary " + err);
              }
            }
          );
        } else {
          Teams.findOneAndUpdate(
            { _id: teamId },
            {
              team_name: teamName,
              description: description,
              area: area,
              level: level,
              type: type,
            },
            (err) => {
              if (!err) {
                res.status(200).send({ message: "Team updated Successfully" });
              } else {
                res.status(400).send({
                  message: "Team could not be updated due to some error",
                });
              }
            }
          );
        }
      }
    });
  } catch (error) {
    console.log("--->" + error);
    res.status(500).send({ message: "An Internal Error Occurred" + error });
  }
});

module.exports = router;
