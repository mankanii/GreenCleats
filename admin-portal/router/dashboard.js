const express = require("express");

const router = express.Router();
const users = require("../models/users");
const adminGroundApprovalAccounts = require("../models/adminGroundApprovalAccounts");
const adminTrainerApprovalAccounts = require("../models/adminTrainerApprovalAccounts");

router.get("/adminDashboard", async (req, res) => {
  const groundOwnerapprovals = await adminGroundApprovalAccounts.count();

  const trainerApprovals = await adminTrainerApprovalAccounts.count();
  const user_num = await users.count({ role: "Player" });
  const ground_num = await users.count({ role: "Ground Owner" });
  const trainer_num = await users.count({ role: "Trainer" });
  res.render("adminDashboard", {
    user_num: user_num,
    ground_num: ground_num,
    trainer_num: trainer_num,
    approval_num: groundOwnerapprovals + trainerApprovals,
  });
});

module.exports = router;
