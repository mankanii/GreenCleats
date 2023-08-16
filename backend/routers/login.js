const express = require("express");

const Users = require("../models/users");

const router = express.Router();

router
  .get("/login", (req, res) => {
    res.render("login");
  })

  .post("/login", (req, res) => {
    const { email_address, password } = req.body;
    Users.findOne({ email_address: email_address }, (err, user) => {
      if (!err) {
        // If no error occurred
        if (user === null || user === undefined) {
          // Checks if user exists
          res.status(404).send({ message: "User not Found" });
        } else {
          // If exists then match the password
          if (user.password === password) {
            res.status(200).send({
              message: user.role + " Login Succesful",
              id: user._id,
              role: user.role,
            });
          } else {
            res.status(401).send({ message: "Unauthorized Access" });
          }
        }
      } else {
        res.status(400).send({ message: "Error Occured ~ Check Your Internet Connection and Try Again" });
      }
    });
  });

module.exports = router;
