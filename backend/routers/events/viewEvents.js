const express = require("express");

const Events = require("../../models/events/event");

const router = express.Router();

router
  .get("/viewEvents", (req, res) => {
    Events.find({}, (err, event) => {
      if (err) {
        res.status(404).send({ message: "Events Not Found" });
      } else {
        res.status(200).send({ events: event });
      }
    });
  })

  .get("/viewEvents/:eventid", (req, res) => {
    const eventid = req.params.eventid;
    Events.findOne(
      {
        _id: eventid,
      },
      (err, event) => {
        if (err) {
          res.status(404).send({ message: "Event Not Found" });
        } else if (event) {
          res.status(200).send({ events: event });
        } else {
          res.status(400).send("Bad Request");
        }
      }
    );
  });

module.exports = router;
