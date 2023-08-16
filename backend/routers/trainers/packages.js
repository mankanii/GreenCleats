const express = require("express");

const router = express.Router();

const Packages = require("../../models/trainer_app/packages");
const Booking = require("../../models/trainer_app/bookings");

router.get("/trainerPackages/:id", (req, res) => {
  const trainerId = req.params.id;
  try {
    Packages.find({ trainer_id: trainerId }, (err, packages) => {
      if (!err) {
        res.status(200).send({ message: "Success", packages: packages });
      } else {
        res.status(404).send({ message: "Packages not found" });
      }
    });
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred" });
  }
});

router.post("/trainerPackages", (req, res) => {
  const { packages } = req.body;
  // console.log("Length: " + packages.length);
  const operations = [];
  packages.forEach((package) => {
    // console.log(package);
    operations.push({
      updateOne: {
        filter: {
          trainer_id: package.trainer_id,
          package_name: package.package_name,
        },
        update: {
          $set: {
            trainer_id: package.trainer_id,
            package_name: package.package_name,
            package_price: package.package_price,
            package_description: package.package_description,
          },
        },
        upsert: true,
      },
    });
  });
  try {
    Packages.bulkWrite(operations, (err) => {
      if (!err) {
        res.status(200).send({ message: "Packages Insertion Succesful" });
      } else {
        res.status(404).send({ message: "Packages Insertion Failed" + err });
      }
    });
  } catch (error) {
    res.status(500).send({ message: "Inetrnal Error Occurred" });
  }
});

router.post("/bookPackage", (req, res) => {
  const {
    package_id,
    trainer_id,
    player_id,
    payment_method,
    payment_details,
    date,
  } = req.body;
  try {
    Booking.findOne(
      { player_id: player_id, subscription_status: "active" },
      (err, result) => {
        if (!err) {
          if (result === null || result === undefined) {
            const booking = new Booking({
              package_id: package_id,
              trainer_id: trainer_id,
              player_id: player_id,
              payment_method: payment_method,
              payment_details: payment_details,
              date_booking: date,
            });
            Booking.create(booking, (err) => {
              if (!err) {
                res.status(200).send({ message: "Booking Successfull" });
              } else {
                res.status(400).send({ message: "Booking Failed" + err });
              }
            });
          } else {
            // console.log(result);
            res.status(400).send({
              message:
                "You are already subscribed to another package of the trainer",
            });
          }
        } else {
          res.status(400).send({ message: "Error Occurred ~ Try Again" + err });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred" + error });
  }
});

module.exports = router;
