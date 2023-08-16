const express = require("express");
const router = express.Router();
const groundOwners = require("../models/groundOnwers");

// Sample data for trainers
const sampleGroundOwners = [
  {
    id: 1,
    name: "Chacha Wali",
    ground_name: "Sportswing",
    type: "Futsal",
    email: "chacha.wali@szabist.pk",
    contact_number: 03200000000,
    location: "PECHS Block 2",
  },
];

router.get("/groundOwners", (req, res) => {
  res.render("groundOwners", { groundOwners: sampleGroundOwners });
});

module.exports = router;
