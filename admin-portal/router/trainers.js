const express = require("express");
const router = express.Router();
const trainers = require("../models/trainers");

// Sample data for trainers
const sampleTrainers = [
  {
    id: 1,
    name: "Shayan Ali Mankani",
    type: "Football Coach",
    age: 22,
    gender: "Male",
    email: "shayan@gmail.com",
    number: 03200000000,
  },
  {
    id: 1,
    name: "Shayan Ali Mankani",
    type: "Football Coach",
    age: 22,
    gender: "Male",
    email: "shayan@gmail.com",
    number: 03200000000,
  },
  {
    id: 1,
    name: "Shayan Ali Mankani",
    type: "Football Coach",
    age: 22,
    gender: "Male",
    email: "shayan@gmail.com",
    number: 03200000000,
  },
];

router.get("/trainers", (req, res) => {
  res.render("trainers", { trainers: sampleTrainers });
});

module.exports = router;
