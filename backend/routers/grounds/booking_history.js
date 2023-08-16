const express = require("express");

const bookingHistory = require("../../models/grounds_app/bookings");

const router = express.Router();

router.get("/booking_history/:teamId", (req, res) => {
  const teamId = req.params.teamId;
  try {
    bookingHistory.aggregate(
      [
        { $match: { team_id: teamId } },
        { $addFields: { slotId: { $toObjectId: "$slot_id" } } },
        {
          $lookup: {
            from: "slots",
            localField: "slotId",
            foreignField: "_id",
            as: "bookingData",
          },
        },
        {
          $lookup: {
            from: "players",
            localField: "player_id",
            foreignField: "player_id",
            as: "playerData",
          },
        },
        {
          $lookup: {
            from: "groundowners",
            localField: "ground_id",
            foreignField: "ground_id",
            as: "groundData",
          },
        },
        {
          $lookup: {
            from: "groundimages",
            localField: "ground_id",
            foreignField: "ground_id",
            as: "groundImages",
          },
        },
        { $unwind: "$bookingData" },
        { $unwind: "$playerData" },
        { $unwind: "$groundData" },
        // { $unwind: "$groundImages" },
        {
          $project: {
            mode_of_payment: "$payment_method",
            date: "$bookingData.date",
            start_time: "$bookingData.start_time",
            end_time: "$bookingData.end_time",
            booking_owner: "$playerData.name",
            ground_name: "$groundData.ground_name",
            ground_image: "$groundImages",
          },
        },
      ],
      (err, result) => {
        if (!err) {
          if (result !== null || result !== undefined) {
            res.status(200).send({ message: "history found", data: result });
          } else {
            res.status(404).send({ message: "No history fond" });
          }
        } else {
          res.status(400).send({ message: "Error Occurred " + err });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred " + error });
  }
});

router.get("/groundBookingHistory/:groundId", (req, res) => {
  const groundId = req.params.groundId;
  try {
    bookingHistory.aggregate(
      [
        { $match: { ground_id: groundId } },
        {
          $lookup: {
            from: "players",
            localField: "player_id",
            foreignField: "player_id",
            as: "playerData",
          },
        },
        { $unwind: "$playerData" },
      ],
      (err, data) => {
        if (!err) {
          res.status(200).send({ message: "Success", history: data });
        } else {
          res.status(400).send({ message: "Error Occurred" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred" });
  }
});

module.exports = router;
