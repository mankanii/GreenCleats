const { json } = require("body-parser");
const express = require("express");
const Player = require("../models/players");
const Teams = require("../models/teams");

const cloudinary = require("../utils/cloudinary");
const router = express.Router();

router.get("/playerProfile/:id", (req, res) => {
  const id = req.params.id;
  Player.findOne({ player_id: id }, (err, player) => {
    if (!err) {
      Teams.findOne({ _id: player.team_id }, (err, team) => {
        if (!err && team !== null) {
          res.status(200).send({
            message: "Success",
            player: player,
            team_name: team.team_name,
          });
        } else {
          res.status(200).send({
            message: "No Team",
            player: player,
          });
        }
      });
    } else {
      res.status(500).send({
        message: "There has been some error in fetching profile data",
      });
    }
  });
});

router.post("/playerProfile/:id", (req, res) => {
  const id = req.params.id;

  var {
    full_name,
    position,
    age,
    description,
    achievements,
    experience,
    picture,
  } = req.body;

  Player.findOne({ player_id: id }, async (err, player) => {
    if (!err) {
      //Profile Update With Picture
      if (picture !== "") {
        // picture = "data:image/jpeg;base64," + picture;
        const result = await cloudinary.uploader.upload(
          picture,
          {
            folder: "Player",
          },
          async (err, response) => {
            if (!err) {
              Player.findOneAndUpdate(
                { player_id: id },
                {
                  name: full_name,
                  position: position,
                  age: age,
                  description: description,
                  achievements: achievements,
                  experience: experience,
                  picture_url: response.secure_url,
                  picture_public_id: response.public_id,
                },
                (err) => {
                  if (!err) {
                    res
                      .status(200)
                      .send({ message: "Profile updated Successfully" });
                  } else {
                    res.status(400).send({
                      message: "Profile could not be updated due to some error",
                    });
                  }
                }
              );
              await cloudinary.uploader
                .destroy(player.picture_public_id)
                .catch((err) => {
                  console.log("Error in deleting image");
                });
            }
          }
        );
      } else {
        //Profile Update Without Picture
        Player.findOneAndUpdate(
          { player_id: id },
          {
            name: full_name,
            position: position,
            age: age,
            description: description,
            achievements: achievements,
            experience: experience,
          },
          (err) => {
            if (!err) {
              res.status(200).send({ message: "Profile updated Successfully" });
            } else {
              res.status(400).send({
                message: "Profile could not be updated due to some error",
              });
            }
          }
        );
      }
    }
  });
});

module.exports = router;
