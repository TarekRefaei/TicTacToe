const express = require("express");
const socket = require("socket.io");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/room");

//initialize express
const app = express();

//create server and socket io
const server = http.createServer(app);
const io = socket(server);

io.on("connection", (socket) => {
  console.log("socket connected");

  socket.on("createRoom", async ({ playerName }) => {
    try {
      //create room
      let room = new Room();
      let player = {
        socketID: socket.id,
        playerName: playerName,
        playerType: "X",
      };
      // add properties to room object
      room.players.push(player);
      room.turn = player;

      //save room in database
      room = await room.save();
      const roomId = room._id.toString();
      //join room
      socket.join(roomId);
      //inform client that room has been created
      io.to(roomId).emit("createRoomSuccess", room);
      console.log(playerName);
    } catch (error) {
      console.log(error);
    }
  });

  socket.on("joinRoom", async ({ playerName, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-f]{24}$/)) {
        socket.emit("error occurred,", "Please Enter a valid room id");
        return;
      }
      let room = await Room.findById(roomId);
      if (room == null) {
        socket.emit("error occurred , No Game Room Found");
        return;
      }
      if (room.canJoin) {
        let player = {
          playerName: playerName,
          socketID: socket.id,
          playerType: "O",
        };
        socket.join(roomId);
        room.players.push(player);
        room.canJoin = false;
        room = await room.save();
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.players);
        io.to(roomId).emit("updateRoom", room);
        console.log(room.players);
      } else {
        socket.emit(
          "error occurred,",
          "The game is already in progress .. choose another room,"
        );
      }
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("tapOnEmptyIndex", async ({ index, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let choice = room.turn.playerType;

      if (room.turnIndex == 0) {
        room.turn = room.players[1];
        room.turnIndex = 1;
      } else {
        room.turn = room.players[0];
        room.turnIndex = 0;
      }
      room = await room.save();
      io.to(roomId).emit("tappedOnEmptyIndex", {
        index,
        choice,
        room,
      });
    } catch (error) {
      console.log(error);
    }
  });

  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let player = room.players.find(
        (player) => player.socketID == winnerSocketId
      );

      player.points += 1;
      room = await room.save();

      if (player.points >= room.maxRounds) {
        io.to(roomId).emit('endGame',player);
        io.to(roomId).emit('updateRoom',room);
      } else {
        io.to(roomId).emit('pointIncrease',player);
        io.to(roomId).emit('updateRoom',room);
      }
    } catch (error) {
      console.log(error);
    }
  });
});

//middleware : manipulate data coming from client to server and vice versa
app.use(express.json()); //convert incoming data to JSON

const PORT = process.env.PORT || 3000;
const DB =
//Add url
  "MONGODB_URI";
mongoose
  .connect(DB)
  .then(() => {
    console.log("Database connected");
  })
  .catch((error) => {
    console.log(error);
  });

server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
