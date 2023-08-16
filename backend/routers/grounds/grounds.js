const express = require("express");

const router = express.Router();

const Ground = require("../../models/grounds_app/grounds");
const GroundImages = require("../../models/grounds_app/groundImages");

const cloudinary = require("../../utils/cloudinary");

router.get("/viewGrounds", async (req, res) => {
  try {
    const grounds = await Ground.aggregate([
      {
        $lookup: {
          from: "groundimages",
          localField: "ground_id",
          foreignField: "ground_id",
          as: "data",
        },
      },
    ]);
    res.status(200).send({ grounds: grounds });
  } catch (error) {
    res.status(400).send({ message: "Error Occurred", error: error });
  }
});

router.get("/ground/:id", async (req, res) => {
  const groundID = req.params.id;
  try {
    const ground = await Ground.findOne({ ground_id: groundID });
    res.status(200).send({ message: "Success", ground: ground });
  } catch (error) {
    res.status(400).send({ message: "Error Occurred", error: error });
  }
});

router.get("/groundImages/:id", async (req, res) => {
  const groundID = req.params.id;
  try {
    const groundImages = await GroundImages.find({ ground_id: groundID });
    res.status(200).send({ message: "Success", images: groundImages });
  } catch (error) {
    res.status(500).send({ message: "Error Occurred", error: error });
  }
});

router.post("/updateGround/:id", (req, res) => {
  const groundID = req.params.id;
  const { ground_name, ground_fees, ground_description, location } = req.body;
  try {
    Ground.findOneAndUpdate(
      { ground_id: groundID },
      {
        ground_name: ground_name,
        fees: ground_fees,
        ground_description: ground_description,
        location: location,
      },
      (err) => {
        if (!err) {
          console.log("Ground Updated");
          res.status(200).send({ message: "Update Success" });
        } else {
          console.log("Error " + err);
          res.status(400).send({ message: "Error Occurred", error: err });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Server Error", error: error });
  }
});

router.post("/uploadGroundImages", async (req, res) => {
  const { groundId, images } = req.body;
  try {
    images.forEach(async (picture) => {
      await cloudinary.uploader
        .upload(
          picture,
          {
            folder: "Ground Images",
          },
          (err, response) => {
            if (!err) {
              console.log("Image uploaded");
              const groundImageSchema = new GroundImages({
                ground_id: groundId,
                picture_url: response.secure_url,
                public_id: response.public_id,
              });
              GroundImages.create(groundImageSchema, (err) => {
                if (!err) {
                  console.log("Image Uploaded Sucessfully");
                } else {
                  console.log("Image Uploaded ~ Error Occurred while saving");
                  res.status(400).send({
                    message: "Image Uploaded ~ Error Occurred while saving",
                  });
                }
              });
            } else {
              console.log("Error Uploading Images " + err);
            }
          }
        )
        .catch((err) => {
          console.log("Error in Uploading Images " + err);
        });
    });
    res.status(200).send({ message: "Images Uploaded Sucessfully" });
  } catch (error) {
    res.status(500).send({ message: "Internal Server Error" });
  }
});

router.post("/deleteGroundImage", (req, res) => {
  const { imageId, image_public_id } = req.body;
  try {
    GroundImages.findByIdAndDelete(imageId, async (err) => {
      if (!err) {
        res.status(200).send({ message: "Image Deleted Succesfully" });
        await cloudinary.uploader.destroy(image_public_id).catch((error) => {
          console.log("Error in deleting image from cloudinary " + error);
        });
      } else {
        res.status(404).send({ message: "Image Not Found" });
      }
    });
  } catch (error) {
    res.status(500).send({ message: "Internal Server Error" + error });
  }
});

module.exports = router;
