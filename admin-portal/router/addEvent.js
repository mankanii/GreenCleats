const express = require("express");
const path = require("path");
const Event = require("../models/events/event");
const cloudinary = require("../utilities/cloudinary");
const router = express.Router();

router.get("/addEvents", (req, res) => {
  res.render("addEvents");
});

router.post("/addEvents", async (req, res) => {
  const { event_title, event_description, event_date, imageCode } = req.body;
  console.log(event_title, event_description, event_date, imageCode);
  const date =
    new Date().getDate() +
    " " +
    new Date().toLocaleString("default", { month: "short" }) +
    " " +
    new Date().getFullYear();


  const result = await cloudinary.uploader.upload(
    imageCode,
    {
      folder: "Events",
    },
    async (err, response) => {
      if (!err) {
        const events = new Event({
          event_title: event_title,
          event_description: event_description,
          event_date: event_date,
          event_date_posted: date,
          picture_url: response.secure_url,
          picture_public_id: response.public_id,
        });
        await Event.create(events, (err) => {
          if (!err) {
            console.log("Event created");
            res.redirect("/addEvents");
          } else {
            console.log("Error Occurred while adding event");
            res
              .status(400)
              .send({ message: "Error Occurred while adding event" });
          }
        });
      } else {
        console.log("Error Occurred while adding event");
      }
    }
  );
});

router.get("/viewEvents", async (req, res) => {
  const events = await Event.find({});
  res.render("viewEvents", {
    events: events,
  });
});

router.get("/event/:eventid", (req, res) => {
  const eventid = req.params.eventid;
  Event.findOne(
    {
      _id: eventid,
    },
    (err, event) => {
      if (err) {
        res.redirect("/adminDashboard");
      } else {
        res.render("event", {
          events: event,
        });
      }
    }
  );
});

module.exports = router;
