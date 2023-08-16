const bodyParser = require("body-parser");
const express = require("express");
const app = express();
const mongoose = require("mongoose");

const loginRouter = require("./router/login");
const registerRouter = require("./router/register");
const dashboardRouter = require("./router/dashboard");
const playersRouter = require("./router/players");
const trainersRouter = require("./router/trainers");
const groundOnwersRouter = require("./router/groundOwners");
const adminApprovalAccounts = require("./router/adminApprovalAccounts");
const addBlogs = require("./router/addBlogs");
const addEvents = require("./router/addEvent");

const databaseURL =
  "mongodb://localhost:27017/greenCleats?readPreference=primary&ssl=false";

app.set("view engine", "ejs");
app.use(express.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));
app.use(express.static("public"));

app.use(loginRouter);
app.use(registerRouter);
app.use(dashboardRouter);
app.use(playersRouter);
app.use(trainersRouter);
app.use(groundOnwersRouter);
app.use(adminApprovalAccounts);
app.use(addBlogs);
app.use(addEvents);

app.get("*", (req, res) => {
  res.render("404");
});

mongoose.set("strictQuery", false);

app.listen(4000, (err) => {
  if (err) {
    console.log("Error running in server " + err);
  } else {
    console.log("Server Running on port 4000");
  }
});

mongoose.connect(databaseURL, (err) => {
  if (err) {
    console.log("Could not connect to database");
  } else {
    console.log("Succesfully Connected to database");
  }
});
