const express = require("express");
const router = express.Router();

const Slots = require("../../models/grounds_app/slots");
const Booking = require("../../models/grounds_app/bookings");
const Ground = require("../../models/grounds_app/grounds");

router.post("/addSlot/:groundID", (req, res) => {
  const groundID = req.params.groundID;
  const { date, slots } = req.body;
  // console.log(slots);
  const slotsData = [];
  slots.forEach((element) => {
    const slot = new Slots({
      ground_id: groundID,
      date: element.date,
      start_time: element.start_time,
      end_time: element.end_time,
    });

    slotsData.push(slot);
  });
  Slots.insertMany(slotsData, (err) => {
    if (err) {
      console.log(err);
      res
        .status(400)
        .send({ message: "Slots could not be created", error: err });
    } else {
      res.status(200).send({ message: "Slots created succesfully" });
      console.log("Done");
    }
  });
});

// Slots For User
router.get("/getSlots/:ground_id/:date", async (req, res) => {
  const groundID = req.params.ground_id;
  const date = req.params.date;
  try {
    const slots = await Ground.aggregate([
      {
        $match: { ground_id: groundID },
      },
      {
        $lookup: {
          from: "slots",
          localField: "ground_id",
          foreignField: "ground_id",
          as: "slots",
        },
      },
      {
        $project: {
          _id: 0,
          bs: {
            $filter: {
              input: "$slots",
              cond: {
                // $eq: ["$$this.booking_status", "vacant"],
                $eq: ["$$this.date", date],
              },
            },
          },
        },
      },
    ]);
    res.status(200).send({ message: "Success", slots: slots });
  } catch (error) {
    res.status(400).send({ message: "Error Occured", error: error });
  }
});

router.post("/checkSlot/:slotId", (req, res) => {
  const slot_id = req.params.slotId;
  const slot1 = Slots.findOne(
    { _id: slot_id },

    (err, doc) => {
      if (err) {
        console.log("Error is " + err);
        res.status(400).send({ message: "Slot not found" });
      } else if (doc.booking_status !== "vacant") {
        // console.log("Slot1 is " + doc);
        res.status(404).send({ message: "Slot already booked" });
      } else {
        // console.log("Slot2 is " + doc);
        res.status(200).send({ message: "Slot Available" });
      }
    }
  );
});

router.post("/bookSlot", (req, res) => {
  const { slot_id, ground_id, team_id, player_id, payment_method } = req.body;
  const booking = new Booking({
    slot_id: slot_id,
    ground_id: ground_id,
    team_id: team_id,
    player_id: player_id,
    payment_method: payment_method,
    date: Date.now(),
  });
  Booking.create(booking, (err) => {
    if (err) {
      console.log("Error is " + err);
      res.status(400).send({ message: "Slot not found" });
    } else {
      Slots.findOneAndUpdate(
        { _id: slot_id },
        {
          booking_status: "booked",
        },
        {
          new: true,
        },
        (err, doc) => {
          if (err) {
            console.log("Error is " + err);
            res.status(400).send({ message: "Slot not found" });
          } else if (doc.booking_status === "booked") {
            // console.log("Slot1 is " + doc);
            res.status(200).send({ message: "Slot succesfully booked" });
          } else {
            // console.log("Slot2 is " + doc);
            res
              .status(404)
              .send({ message: "Slot could not be booked. Try again" });
          }
        }
      );
    }
  });
});

router.post("/updateSlot", (req, res) => {
  const { slotsToUpdate, slotsToDelete } = req.body;
  const operations = [];

  try {
    slotsToUpdate.forEach((element) => {
      operations.push({
        updateOne: {
          filter: { _id: element._id },
          update: {
            $set: {
              start_time: element.start_time,
              end_time: element.end_time,
            },
          },
        },
      });
    });
    slotsToDelete.forEach((element) => {
      operations.push({
        deleteOne: {
          filter: { _id: element._id },
        },
      });
    });

    // console.log(operations);

    Slots.bulkWrite(operations, (err) => {
      if (err) {
        console.log("Error " + err);
        res.status(400).send({ message: "Error in updating slot", error: err });
      } else {
        console.log("Slots Updated");
        res.status(200).send({ message: "Slots Updated Succesfully" });
      }
    });
  } catch (error) {
    console.log("Internal Error " + error);
    res.status(500).send({ message: "Internal Error Occurred", error: error });
  }
});

router.post("/deleteSlot", (req, res) => {
  const { slots } = req.body;
  try {
    slots.forEach((element) => {
      deleteOperations.push({
        deleteOne: {
          filter: { _id: element._id },
        },
      });
    });
    // console.log(deleteOperations);
    // Slots.bulkWrite(deleteOperations, (err) => {
    //   if (err) {
    //     console.log("Error " + err);
    //     res.status(400).send({ message: "Error in updating slot", error: err });
    //   } else {
    //     console.log("Slots Updated");
    //     res.status(200).send({ message: "Slots Updated Succesfully" });
    //   }
    // });
  } catch (error) {
    console.log("Internal Error " + error);
    res.status(500).send({ message: "Internal Error Occurred", error: error });
  }
});

router.post("/cancelSlotBooking", (req, res) => {
  const { slotId } = req.body;
  console.log(slotId);
  try {
    Slots.findByIdAndUpdate(
      slotId,
      {
        booking_status: "vacant",
      },
      (error) => {
        if (!error) {
          Booking.deleteOne({ slot_id: slotId }, (err) => {
            if (!err) {
              res.status(200).send({ message: "Ground Booking Cancelled" });
            } else {
              res
                .status(400)
                .send({
                  message: "Error occur while cancelling the booking",
                  error: err,
                });
            }
          });
        } else {
          res
            .status(400)
            .send({
              message: "Error occur while cancelling the booking",
              error: error,
            });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred", error: error });
  }
});

module.exports = router;
