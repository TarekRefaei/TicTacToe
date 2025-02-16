import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/providers/room_data_provider.dart';

import '../utils/utils.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
      context,
      listen: false,
    );
    String winner = '';

    //horizontal check
    if (roomDataProvider.gridState[0] == roomDataProvider.gridState[1] &&
        roomDataProvider.gridState[0] == roomDataProvider.gridState[2] &&
        roomDataProvider.gridState[0] != '') {
      winner = roomDataProvider.gridState[0];
    }
    if (roomDataProvider.gridState[3] == roomDataProvider.gridState[4] &&
        roomDataProvider.gridState[3] == roomDataProvider.gridState[5] &&
        roomDataProvider.gridState[3] != '') {
      winner = roomDataProvider.gridState[3];
    }
    if (roomDataProvider.gridState[6] == roomDataProvider.gridState[7] &&
        roomDataProvider.gridState[6] == roomDataProvider.gridState[8] &&
        roomDataProvider.gridState[6] != '') {
      winner = roomDataProvider.gridState[6];
    }
    //vertical check
    if (roomDataProvider.gridState[0] == roomDataProvider.gridState[3] &&
        roomDataProvider.gridState[0] == roomDataProvider.gridState[6] &&
        roomDataProvider.gridState[0] != '') {
      winner = roomDataProvider.gridState[0];
    }
    if (roomDataProvider.gridState[1] == roomDataProvider.gridState[4] &&
        roomDataProvider.gridState[1] == roomDataProvider.gridState[7] &&
        roomDataProvider.gridState[1] != '') {
      winner = roomDataProvider.gridState[1];
    }
    if (roomDataProvider.gridState[2] == roomDataProvider.gridState[5] &&
        roomDataProvider.gridState[2] == roomDataProvider.gridState[8] &&
        roomDataProvider.gridState[2] != '') {
      winner = roomDataProvider.gridState[2];
    }
    //diagonal check
    if (roomDataProvider.gridState[0] == roomDataProvider.gridState[4] &&
        roomDataProvider.gridState[0] == roomDataProvider.gridState[8] &&
        roomDataProvider.gridState[0] != '') {
      winner = roomDataProvider.gridState[0];
    }
    if (roomDataProvider.gridState[2] == roomDataProvider.gridState[4] &&
        roomDataProvider.gridState[2] == roomDataProvider.gridState[6] &&
        roomDataProvider.gridState[2] != '') {
      winner = roomDataProvider.gridState[2];
    } else if (roomDataProvider.filledBoxes == 9 && winner == '') {
      winner = '';
      showGameDialog(context, 'Game Draw');
    }

    if (winner != '') {
      if (winner == roomDataProvider.player1.playerType) {
        showGameDialog(
          context,
          '${roomDataProvider.player1.playerName} Won',
        );
        socketClient.emit(
          "winner",
          {
            'winnerSocketId': roomDataProvider.player1.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          },
        );
      } else {
        showGameDialog(
          context,
          '${roomDataProvider.player2.playerName} Won',
        );
        socketClient.emit(
          "winner",
          {
            'winnerSocketId': roomDataProvider.player2.socketID,
            'roomId': roomDataProvider.roomData['_id'],
          },
        );
      }
    }
  }

  void resetGame(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
      context,
      listen: false,
    );
    for (int i = 0; i < roomDataProvider.gridState.length; i++) {
      roomDataProvider.updateGridState(i, '');
    }
    roomDataProvider.setFilledBoxesToZero();
  }
}
