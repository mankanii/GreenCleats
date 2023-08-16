const express = require("express");

const router = express.Router();

const TrainerBookingHistory = require("../../models/trainer_app/bookings");
const { default: mongoose } = require("mongoose");

router.get("/trainerBookingHistory/:trainerId", (req, res) => {
  const trainerId = req.params.trainerId;
  // console.log(trainerId);
  try {
    TrainerBookingHistory.aggregate(
      [
        { $match: { trainer_id: trainerId } },
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
          // console.log(data);
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

router.get("/trainerHired/:id", (req, res) => {
  const playerId = req.params.id;
  try {
    TrainerBookingHistory.aggregate(
      [
        {
          $match: {
            player_id: playerId,
            subscription_status: "active",
          },
        },
        {
          $lookup: {
            from: "trainers",
            localField: "trainer_id",
            foreignField: "trainer_id",
            as: "trainer",
          },
        },
        { $addFields: { packageId: { $toObjectId: "$package_id" } } },
        {
          $lookup: {
            from: "packages",
            localField: "packageId",
            foreignField: "_id",
            as: "package",
          },
        },
        { $unwind: "$trainer" },
        { $unwind: "$package" },
        {
          $project: {
            _id: 1,
            subscription_status: "$subscription_status",
            trainer_name: "$trainer.full_name",
            trainer_type: "$trainer.profession_category",
            package_type: "$package.package_name",
            booking_date: "$date_booking",
            image: "$trainer.picture_url",
          },
        },
      ],
      (err, booking) => {
        if (!err) {
          res.status(200).send({ message: "Success", booking: booking });
        } else {
          res.status(404).send({ message: "Booking Not Found" + err });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred" + error });
  }
});

module.exports = router;
