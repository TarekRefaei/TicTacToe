import 'package:flutter/material.dart';
import 'package:tictactoe/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};

  Map<String, dynamic> get roomData => _roomData;

  Player _player1 = Player(
    playerName: "",
    socketID: "",
    points: 0.0,
    playerType: "",
  );

  Player get player1 => _player1;

  Player _player2 = Player(
    playerName: "",
    socketID: "",
    points: 0.0,
    playerType: "",
  );

  Player get player2 => _player2;

  List<String> _gridState = List.generate(9, (index) => '');
  List<String> get gridState => _gridState;

  int _filledBoxes = 0;
  int get filledBoxes => _filledBoxes;

  void updateRoomData(Map<String, dynamic> roomData) {
    _roomData = roomData;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateGridState(int index,String choice) {
    _gridState[index] = choice;
    _filledBoxes++;
    notifyListeners();
  }

  void resetGridState() {
    _gridState = List.generate(9, (index) => '');
    _filledBoxes = 0;
    notifyListeners();
  }

  void setFilledBoxesToZero() {
    _filledBoxes = 0;
    notifyListeners();
  }
}
