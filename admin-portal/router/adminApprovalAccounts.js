const express = require("express");
const router = express.Router();
const GroundOwner = require("../models/groundOnwers");
const Trainer = require("../models/trainers");
const User = require("../models/users");
const { genPassword } = require("../utilities/passwordGenerator");
const { sendEmail, sendEmailReject } = require("../utilities/sendMail");
const adminGroundApprovalAccounts = require("../models/adminGroundApprovalAccounts");
const adminTrainerApprovalAccounts = require("../models/adminTrainerApprovalAccounts");

router.get("/adminApprovalAccounts", async (req, res) => {
  const groundOwnerapprovals = await adminGroundApprovalAccounts.find();

  const trainerApprovals = await adminTrainerApprovalAccounts.find();

  res.render("adminApprovalAccounts", {
    groundOwnerapprovals: groundOwnerapprovals,
    trainerApprovals: trainerApprovals,
  });
});

router.post("/adminGroundApprovalAccounts", async (req, res) => {
  const {
    full_name,
    email_address,
    contact_number,
    ground_name,
    location,
    button,
  } = req.body;

  try {
    if (button === "Approve") {
      const password = genPassword();

      var user = new User({
        email_address: email_address,
        password: password,
        role: "Ground Owner",
      });
      User.create(user, (err) => {
        var groundowner = new GroundOwner({
          ground_id: user._id,
          full_name: full_name,
          email_address: email_address,
          contact_number: contact_number,
          ground_name: ground_name,
          location: location,
        });
      });
      user.save();
      groundowner.save();

      await adminGroundApprovalAccounts.findOneAndDelete({
        email_address: email_address,
      });

      await sendEmail(email_address, password, "Ground Owner", full_name);
      console.log("Approved Ground Owner");
      res.redirect("/adminApprovalAccounts");
    } else {
      await adminGroundApprovalAccounts.deleteOne({
        email_address: email_address,
      });
      await sendEmailReject(email_address, "Ground Owner", full_name);
      console.log("Rejected Ground Owner");
      res.redirect("/adminApprovalAccounts");
    }
  } catch (error) {
    console.log(error);
    res.redirect("/adminApprovalAccounts");
  }
});

router.post("/adminTrainerApprovalAccounts", async (req, res) => {
  const {
    full_name,
    email_address,
    contact_number,
    date_of_birth,
    profession_category,
    gender,
    button,
  } = req.body;
  console.log(
    full_name,
    email_address,
    contact_number,
    date_of_birth,
    profession_category,
    gender,
    button
  );
  console.log(req.body);
  try {
    if (button === "Approve") {
      const password = genPassword();
      var trainer = new Trainer({
        full_name: full_name,
        email_address: email_address,
        contact_number: contact_number,
        date_of_birth: date_of_birth,
        profession_category: profession_category,
        gender: gender,
      });

      var user = new User({
        email_address: email_address,
        password: password,
        role: "Trainer",
      });

      await trainer.save();
      await user.save();

      await adminTrainerApprovalAccounts.findOneAndDelete({
        email_address: email_address,
      });
      sendEmail(email_address, password, "Trainer", full_name);
      console.log("Approved Trainer");
      res.redirect("/adminApprovalAccounts");
    } else {
      await adminTrainerApprovalAccounts.deleteOne({
        email_address: email_address,
      });
      sendEmailReject(email_address, "Trainer", full_name);
      console.log("Rejected Trainer");
      res.redirect("/adminApprovalAccounts");
    }
  } catch (error) {
    console.log(error);
    res.redirect("/adminApprovalAccounts");
  }
});

module.exports = router;
