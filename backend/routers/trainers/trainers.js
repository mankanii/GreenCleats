const express = require("express");

const router = express.Router();

const Trainer = require("../../models/trainer_app/trainers");

const cloudinary = require("../../utils/cloudinary");

router.get("/viewAllTrainer", (req, res) => {
  try {
    Trainer.aggregate(
      [
        {
          $lookup: {
            from: "packages",
            localField: "trainer_id",
            foreignField: "trainer_id",
            as: "data",
          },
        },
      ],
      (err, data) => {
        if (!err) {
          res.status(200).send({ message: "Data Fetched", trainers: data });
        } else {
          res.status(400).send({ message: "Error While Fetching Data" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred" });
  }
});

router.get("/trainer/:id", (req, res) => {
  const trainerId = req.params.id;
  // console.log(trainerId);
  try {
    Trainer.findOne({ trainer_id: trainerId }, (err, trainer) => {
      if (!err) {
        if (trainer === null || trainer === undefined) {
          res.status(404).send({ message: "Trainer Not Found" });
        } else {
          // console.log(trainer);
          res.status(200).send({ message: "Success", trainer: trainer });
        }
      } else {
        res.status(404).send({ message: "Trainer Not Found" });
      }
    });
  } catch (error) {
    res.status(500).send({ message: "Internal Error" });
  }
});

router.post("/updateTrainer", (req, res) => {
  const { trainerId, full_name, contact_number, description, location } =
    req.body;
  try {
    Trainer.findOneAndUpdate(
      { trainer_id: trainerId },
      {
        full_name: full_name,
        contact_number: contact_number,
        description: description,
        location: location,
      },
      (err) => {
        if (!err) {
          res.status(200).send({ message: "Updated Succesfully" });
        } else {
          res.status(404).send({ message: "Updated Failed" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred" });
  }
});

router.post("/uploadTrainerImage", async (req, res) => {
  const { trainerId, image, image_public_id } = req.body;
  (req.body);
  try {
    await cloudinary.uploader.upload(
      image,
      {
        folder: "Trainer",
      },
      (err, result) => {
        Trainer.findOneAndUpdate(
          { trainer_id: trainerId },
          {
            picture_url: result.secure_url,
            public_id: result.public_id,
          },
          (err) => {
            if (!err) {
              if (
                image_public_id !== null ||
                image_public_id !== undefined ||
                image_public_id !== ""
              ) {
                cloudinary.uploader.destroy(image_public_id).catch((error) => {
                  console.log("Error While deleting image " + error);
                });
              }
              res.status(200).send({ message: "Updated Succesfully" });
            } else {
              res.status(404).send({ message: "Updated Failed" });
            }
          }
        );
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred" });
  }
});

module.exports = router;
