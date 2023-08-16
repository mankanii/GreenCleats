const express = require("express");
const path = require("path");
const Blog = require("../models/blogs");
const cloudinary = require("../utilities/cloudinary");
const router = express.Router();

router.get("/addBlogs", (req, res) => {
  res.render("addBlogs");
});

router.post("/addBlogs", async (req, res) => {
  const { category, blog_author, blog_title, blog_description, base64code } =
    req.body;
  const date =
    new Date().getDate() +
    " " +
    new Date().toLocaleString("default", { month: "short" }) +
    " " +
    new Date().getFullYear();
  const result = await cloudinary.uploader.upload(
    base64code,
    {
      folder: "Blogs",
    },
    async (err, response) => {
      if (!err) {
        const blogs = new Blog({
          category: category,
          blog_author: blog_author,
          blog_title: blog_title,
          blog_description: blog_description,
          date: date,
          picture_url: response.secure_url,
          picture_public_id: response.public_id,
        });
        await Blog.create(blogs, (err) => {
          if (!err) {
            console.log("Blog created");
            // res.status(200).send({ message: "Blog Created Successfully" });
            res.redirect("/viewBlogs");
          } else {
            console.log("Error Occurred while adding blog");
            res
              .status(400)
              .send({ message: "Error Occurred while adding blog" });
          }
        });
      } else {
        console.log("Error Occurred while adding blog");
      }
    }
  );
});

router.get("/viewBlogs", async (req, res) => {
  const blogs = await Blog.find({});
  res.render("viewBlogs", {
    blogs: blogs,
  });
});

router.get("/blogs/:blogid", (req, res) => {
  const blogid = req.params.blogid;
  Blog.findOne(
    {
      _id: blogid,
    },
    (err, blog) => {
      if (err) {
        res.redirect("/adminDashboard");
      } else {
        res.render("blog", {
          blogs: blog,
        });
      }
    }
  );
});

module.exports = router;
