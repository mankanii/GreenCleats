const express = require("express");

const Users = require("../models/users");

const router = express.Router();

router.get("/loginAdmin", (req, res) => {
  res.render("login", {
    message: "",
  });
});

router.post("/loginAdmin", (req, res) => {
  const { email_address, password } = req.body;

  Users.findOne(
    { email_address: email_address, role: "Admin" },
    (err, user) => {
      if (!err) {
        // If no error occurred
        if (user === null || user === undefined) {
          // Checks if user exists
          res.render("login", {
            message: "Admin not Found",
          });
        } else {
          // If exists then match the password
          if (user.password === password) {
            res.status(200).redirect("/adminDashboard");
          } else {
            res.render("login", {
              message: "Unauthorized Access",
            });
          }
        }
      } else {
        res.status(400).send({ message: "Error Occured " + err });
      }
    }
  );
});

module.exports = router;
