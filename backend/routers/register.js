const express = require("express");

const router = express.Router();

const Players = require("../models/players");
const Users = require("../models/users");
const adminGroundApprovalAccounts = require("../models/adminGroundApprovalAccounts");
const adminTrainerApprovalAccounts = require("../models/adminTrainerApprovalAccounts");

router

  .post("/registerPlayer", async (req, res) => {
    var {
      name,
      email_address,
      password,
      contact_number,
      date_of_birth,
      gender,
    } = req.body;

    await Users.exists({ email_address: email_address }, async (err, doc) => {
      if (doc) {
        res.status(403).send({ message: "User Already Present" });
      } else if (!doc) {
        const user = new Users({
          email_address: email_address,
          password: password,
          role: "Player",
        });

        Users.create(user, (err) => {
          if (!err) {
            const player = new Players({
              player_id: user._id,
              name: name,
              email_address: email_address,
              password: password,
              contact_number: contact_number,
              date_of_birth: date_of_birth,
              gender: gender,
              team_id: "none",
            });
            Players.create(player, (err) => {
              if (!err) {
                res.status(200).send({ message: "Registration Succesful" });
              } else {
                res.status(402).send({ message: "Error Occured" });
              }
            });
          }
        });
      }
    });
  })

  .post("/registerGroundOwner", async (req, res) => {
    var { full_name, email_address, contact_number, ground_name, location } =
      req.body;

    await Users.exists({ email_address: email_address }, async (err, doc) => {
      if (doc) {
        res.status(403).send({ message: "User Already Registered" });
      } else if (!doc) {
        await adminGroundApprovalAccounts.exists(
          { email_address: email_address },
          async (error, doc) => {
            if (doc) {
              res
                .status(403)
                .send({ message: "User Already Applied for registration" });
            } else if (!doc) {
              const groundOwner = new adminGroundApprovalAccounts({
                full_name: full_name,
                email_address: email_address,
                contact_number: contact_number,
                ground_name: ground_name,
                location: location,
              });

              await groundOwner.save();
              res.status(200).send({
                message:
                  "Your ground registration on GreenCleats is complete, and you will receive an approval email within 3 working days.",
              });
            }
          }
        );
      } else {
        res.status(400).send({
          message:
            "There has been error in registering process please try again",
        });
      }
    });
  })

  .post("/registerTrainer", async (req, res) => {
    var {
      full_name,
      email_address,
      contact_number,
      date_of_birth,
      profession_category,
      gender,
    } = req.body;

    console.log(req.body);
    try {
      await Users.exists({ email_address: email_address }, async (err, doc) => {
        if (doc) {
          res.status(403).send({ message: "User Already Registered" });
        } else if (!doc) {
          await adminTrainerApprovalAccounts.exists(
            { email_address: email_address },
            async (err, doc) => {
              if (!err) {
                if (doc) {
                  res
                    .status(403)
                    .send({ message: "User Already Applied For Registration" });
                } else if (!doc) {
                  const trainer = new adminTrainerApprovalAccounts({
                    full_name: full_name,
                    email_address: email_address,
                    contact_number: contact_number,
                    date_of_birth: date_of_birth,
                    profession_category: profession_category,
                    gender: gender,
                  });

                  await trainer.save();
                  res.status(200).send({
                    message:
                      "Your trainer registration on GreenCleats is complete, and you will receive an approval email within 3 working days.",
                  });
                }
              } else {
                res.status(400).send({
                  message:
                    "There has been error in registering process please try again",
                });
              }
            }
          );
        } else {
          res.status(400).send({
            message:
              "There has been error in registering process please try again",
          });
        }
      });
    } catch (error) {
      res.status(500).send(error);
    }
  });

module.exports = router;
