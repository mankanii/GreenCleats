const express = require("express");

const router = express.Router();
const Message = require("../../models/chat/messages");
const Players = require("../../models/players");

router.get("/getMessages/:sender_id/:receiver_id", (req, res) => {
  try {
    const sender_id = req.params.sender_id;
    const receiver_id = req.params.receiver_id;
    Message.aggregate(
      [
        {
          $lookup: {
            from: "players",
            localField: "sender_id",
            foreignField: "player_id",
            as: "sender",
          },
        },
        {
          $lookup: {
            from: "players",
            localField: "receiver_id",
            foreignField: "player_id",
            as: "receiver",
          },
        },
        {
          $match: {
            $or: [
              { sender_id: sender_id, receiver_id: receiver_id },
              { sender_id: receiver_id, receiver_id: sender_id },
            ],
          },
        },
      ],
      (err, data) => {
        if (!err) {
          res.status(200).send({ message: "Success", messages: data });
        } else {
          res.status(400).send({ message: "Error Occurred" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Server Error Occur" });
  }
});

router.get("/messagedPlayers/:id", (req, res) => {
  const id = req.params.id;
  try {
    Message.aggregate(
      [
        {
          $lookup: {
            from: "players",
            let: { senderId: "$sender_id", receiverId: "$receiver_id" },
            pipeline: [
              {
                $match: {
                  $expr: {
                    $or: [
                      { $eq: ["$player_id", "$$senderId"] },
                      { $eq: ["$player_id", "$$receiverId"] },
                    ],
                  },
                },
              },
            ],
            as: "players",
          },
        },
        {
          $project: {
            date: 1,
            players: {
              $filter: {
                input: "$players",
                as: "player",
                cond: { $ne: ["$$player.player_id", id] },
              },
            },
          },
        },
      ],
      (err, data) => {
        if (!err) {
          res.status(200).send({ message: "Success", players: data });
        } else {
          res.status(400).send({ message: "Error Occurred" });
        }
      }
    );
  } catch (error) {
    res.status(500).send({ message: "Internal Error Occurred" });
  }
});

router.post("/sendMessage", (req, res) => {
  const { sender_id, receiver_id, message_content } = req.body;
  console.log(req.body);
  try {
    if (
      message_content === null ||
      message_content === "" ||
      message_content === undefined
    ) {
      res.status(402).send({ message: "Message is empty" });
    } else {
      const message = new Message({
        sender_id: sender_id,
        receiver_id: receiver_id,
        message_content: message_content,
      });

      Message.create(message, (err) => {
        if (!err) {
          res.status(200).send({ message: "Message Sent Succesfully" });
        } else {
          res.status(400).send({ message: "Error Occurred" });
        }
      });
    }
  } catch (error) {
    res.status(500).send({ message: "Internal Server Occurred" });
  }
});

module.exports = router;
