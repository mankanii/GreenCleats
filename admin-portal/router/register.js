const express = require("express");

const router = express.Router();

// const Players = require("../models/players");
const Users = require("../models/users");

router.post("/registerGroundOwners", async (req, res) => {
  var {
    first_name,
    last_name,
    email_address,
    gender,
    contact_number,
    password,
  } = req.body;

  await Users.exists({ email_address: email_address }, async (err, doc) => {
    if (doc) {
      res.send({ message: "User Already Present" });
    } else if (!doc) {
      const user = new Users({
        email_address: email_address,
        password: password,
        role: "Ground Owner",
      });

      const player = new Players({
        first_name: first_name,
        last_name: last_name,
        email_address: email_address,
        gender: gender,
        contact_number: contact_number,
      });

      await user.save();
      await player.save();
    } else {
      res.status(402).send({ message: "Error Occured" });
    }
  });
});

router.post("/registerTrainers", async (req, res) => {
  var {
    name,
    email_address,
    contact_number,
    date_of_birth,
    coach_category,
    gender,
  } = req.body;

  await Users.exists({ email_address: email_address }, async (err, doc) => {
    if (doc) {
      res.send({ message: "User Already Present" });
    } else if (!doc) {
      const user = new Users({
        email_address: email_address,
        password: password,
        role: "Trainer",
      });

      const player = new Players({
        first_name: first_name,
        last_name: last_name,
        email_address: email_address,
        gender: gender,
        contact_number: contact_number,
      });

      await user.save();
      await player.save();
    } else {
      res.status(402).send({ message: "Error Occured" });
    }
  });
});

module.exports = router;
