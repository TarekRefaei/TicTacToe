import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:socket_io_client/socket_io_client.dart";
import "package:tictactoe/providers/room_data_provider.dart";
import "package:tictactoe/resources/game_methods.dart";
import "package:tictactoe/screens/game_screen.dart";
import "package:tictactoe/utils/utils.dart";

import "socket_client.dart";

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;

  Socket? get socketClient => _socketClient;

  final String _createRoom = "createRoom";
  final String _createRoomSuccess = "createRoomSuccess";
  final String _joinRoom = "joinRoom";
  final String _joinRoomSuccess = "joinRoomSuccess";
  final String _updatePlayers = "updatePlayers";
  final String _updateRoom = "updateRoom";
  final String _tapOnEmptyIndex = "tapOnEmptyIndex";
  final String _tappedOnEmptyIndex = "tappedOnEmptyIndex";
  final String _endGame = "endGame";
  final String _pointIncreased = "pointIncreased";
  final String _errorOccurred = "errorOccurred";

  void createRoom(String playerName) {
    if (playerName.isNotEmpty) {
      _socketClient?.emit(
        _createRoom,
        {
          'playerName': playerName,
        },
      );
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient?.on(
      _createRoomSuccess,
      (roomData) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(roomData);
        Navigator.of(context).pushNamed(GameScreen.routeName);
      },
    );
  }

  void joinRoom(String playerName, String roomId) {
    if (playerName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient?.emit(
        _joinRoom,
        {
          'playerName': playerName,
          'roomId': roomId,
        },
      );
    }
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient?.on(
      _joinRoomSuccess,
      (roomData) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(roomData);
        Navigator.of(context).pushNamed(
          GameScreen.routeName,
        );
      },
    );
  }

  void updatePlayerStateListener(BuildContext context) {
    _socketClient?.on(
      _updatePlayers,
      (playerData) {
        Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
          playerData[0],
        );
        Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
          playerData[1],
        );
      },
    );
  }

  void updateRoomListener(BuildContext context) {
    _socketClient?.on(
      _updateRoom,
      (data) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(data);
      },
    );
  }

  void gridUpdate(int index, String roomId, List<String> gridState) {
    if (gridState[index] == '') {
      _socketClient?.emit(
        _tapOnEmptyIndex,
        {
          'index': index,
          'roomId': roomId,
        },
      );
    }
  }

  void gridUpdateListener(BuildContext context) {
    _socketClient?.on(
      _tappedOnEmptyIndex,
      (data) {
        RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
          context,
          listen: false,
        );
        roomDataProvider.updateRoomData(
          data['room'],
        );
        roomDataProvider.updateGridState(
          data['index'],
          data['choice'],
        );
        GameMethods().checkWinner(context, _socketClient);
      },
    );
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient?.on(
      _pointIncreased,
      (playerData) {
        RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(
          context,
          listen: false,
        );
        if (playerData['socketID'] == roomDataProvider.player1.socketID) {
          roomDataProvider.updatePlayer1(playerData);
        } else {
          roomDataProvider.updatePlayer2(playerData);
        }
      },
    );
  }

  void endGameListener(BuildContext context) {
    _socketClient?.on(
      _endGame,
      (playerData) {
        showGameDialog(context, "${playerData['playerName']} won the game");
        Navigator.popUntil(context, (route) => false);
      },
    );
  }

  void errorOccurredListener(BuildContext context) {
    _socketClient?.on(
      _errorOccurred,
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error,
            ),
          ),
        );
      },
    );
  }
}
