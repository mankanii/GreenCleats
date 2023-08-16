const express = require("express");
const { default: mongoose } = require("mongoose");
const User = require("../models/users");
const router = express.Router();

router.post("/changePassword", (req, res) => {
  const { id, current_password, new_password } = req.body;
  try {
    id = mongoose.Types.ObjectId(id);
    User.findById(id, (err, user) => {
      if (!err) {
        if (user === null || user === undefined) {
          res.status(404).send({ message: "User not Found" });
        } else {
          if (user.password === current_password) {
            User.updateOne(
              id,
              {
                password: new_password,
              },
              (err) => {
                if (!err) {
                  res
                    .status(200)
                    .send({ message: "Password Changed Succesfully" });
                } else {
                  res.status(200).send({
                    message: "Error Occurred while changing Password ",
                  });
                }
              }
            );
          } else {
            res
              .status(400)
              .send({ message: "Current Password is not correct" });
          }
        }
      } else {
        res.status(200).send({
          message: "Error Occurred while changing Password ",
        });
      }
    });
  } catch (error) {
    res.status(500).send({
      message: "Internal Error Occured ",
    });
  }
});
