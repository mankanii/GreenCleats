const express = require("express");

const router = express.Router();
const cloudinary = require("../../utils/cloudinary");

const PostingPage = require("../../models/posting_page/posting_page");

router.get("/postingPage", (req, res) => {
  try {
    PostingPage.aggregate(
      [
        {
          $lookup: {
            from: "players",
            localField: "post_owner_id",
            foreignField: "player_id",
            as: "playerData",
          },
        },
        { $unwind: "$playerData" },
        {
          $project: {
            _id: 1,
            "post_owner_id": 1,
            "post_content": 1,
            "post_date": 1,
            "post_image_url": 1,
            "playerData.name": 1,
            "playerData.picture_url": 1,
          },
        },
      ],
      (err, data) => {
        if (!err) {
          res.status(200).send({ data: data });
        } else {
          res.status(400).send({ message: "Error Occurred! Try Again" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Server Error" });
  }
});

router.post("/postingPage", async (req, res) => {
  const { data, image, owner_id } = req.body;
  console.log(req.body);
  try {
    let post;
    if (image === null || image === undefined || image === "") {
      console.log("herre 2");
      post = new PostingPage({
        post_owner_id: owner_id,
        post_content: data,
      });
    } else {
      console.log("In else condition");
      await cloudinary.uploader.upload(
        image,
        {
          folder: "Posts",
        },
        (err, response) => {
          if (!err) {
            console.log("Image uploaded");
            console.log("herre 1");
            post = new PostingPage({
              post_owner_id: owner_id,
              post_content: data,
              post_image_url: response.secure_url,
              post_public_id: response.public_id,
            });
          }
        }
      );
    }
    console.log("post about to be post = " + post);
    PostingPage.create(post, (err, postedPost) => {
      if (!err) {
        console.log(postedPost);
        res.status(200).send({ message: "Post Succesful", post: postedPost });
      } else {
        res.status(400).send({ message: "Could not upload post " + err });
      }
    });
  } catch (error) {
    res.status(500).send({ message: "Internal Server Error" });
  }
});

router.post("/likePost", (req, res) => {
  const { owner_id, post_id } = req.body;
  PostingPage.findByIdAndUpdate(post_id, {
    $inc: { likes: 1 },
  });
});

module.exports = router;
