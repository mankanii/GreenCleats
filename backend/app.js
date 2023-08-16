const express = require("express");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const cors = require("cors");
const loginRouter = require("./routers/login");
const registerRouter = require("./routers/register");
const viewBlogs = require("./routers/viewBlogs");
const playerProfile = require("./routers/set_player_profile");
const teamRegister = require("./routers/team_registration");
const requestPlayer = require("./routers/players");
const request = require("./routers/requests");
const slotRouter = require("./routers/grounds/slots");
const viewGrounds = require("./routers/grounds/grounds");
const viewTrainers = require("./routers/trainers/trainers");
const trainersPackages = require("./routers/trainers/packages");

const viewEvents = require("./routers/events/viewEvents");
const GroundBookingHistory = require("./routers/grounds/booking_history");
const TrainerBookingHistory = require("./routers/trainers/booking_history");
const PostingPage = require("./routers/posting_page/posting_page");
const Chat = require("./routers/chat/messages");

const databaseURL =
  "mongodb://localhost:27017/greenCleats?readPreference=primary&ssl=false";

// Dependecies
const app = express();
app.set("view engine", "ejs");
app.use(express.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));
app.use(cors());

//Routers
app.use(loginRouter);
app.use(registerRouter);
app.use(viewBlogs);
app.use(playerProfile);
app.use(teamRegister);
app.use(requestPlayer);
app.use(request);
app.use(slotRouter);
app.use(viewEvents);
app.use(viewGrounds);
app.use(viewTrainers);
app.use(GroundBookingHistory);
app.use(TrainerBookingHistory);
app.use(trainersPackages);
app.use(PostingPage);
app.use(Chat);

app.listen(3000, (err) => {
  if (err) {
    console.log("Error occurred:  " + err);
  } else {
    console.log("Server running on port 3000");
  }
});

mongoose.connect(databaseURL, (err) => {
  if (err) {
    console.log("Could not connect to database");
  } else {
    console.log("Succesfully Connected to database");
  }
});
