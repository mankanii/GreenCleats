const express = require("express");

const Blogs = require("../models/blogs");

const router = express.Router();

router
  .get("/viewBlogs", (req, res) => {
    Blogs.find({}, (err, blogs) => {
      if (err) {
        res.status(404).send({ message: "Blogs Not Found" });
      } else {
        res.status(200).send({ blogs: blogs });
      }
    });
  })

  .get("/viewBlogs/:blogid", (req, res) => {
    const blogid = req.params.blogid;
    Blogs.findOne(
      {
        _id: blogid,
      },
      (err, blog) => {
        if (err) {
          res.status(404).send({ message: "Blog Not Found" });
        } else if (blog) {
          res.status(200).send({ blogs: blog });
        } else {
          res.status(400).send("Bad Request");
        }
      }
    );
  });

module.exports = router;
