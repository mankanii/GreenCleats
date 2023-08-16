const express = require("express");
const router = express.Router();
const players = require("../models/players");

// Sample data for players
const samplePlayers = [
  {
    id: 1,
    name: "Shayan Ali Mankani",
    age: 22,
    gender: "Male",
    position: "Forward",
    number: 03200000000,
  },
  {
    id: 2,
    name: "Aadesh Kumar",
    age: 22,
    gender: "Male",
    position: "Forward",
    number: 03200000000,
  },
  {
    id: 3,
    name: "Marta",
    age: 29,
    gender: "Female",
    position: "Forward",
    number: 03200000000,
  },
  {
    id: 4,
    name: "Neymar Jr.",
    age: 29,
    gender: "Male",
    position: "Forward",
    number: 03200000000,
  },
];

// router.get("/players", (req, res) => {
//   res.json(players);
// });

router.get("/players", (req, res) => {
  res.render("players", { players: samplePlayers });
});

module.exports = router;
