import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';

import '../providers/room_data_provider.dart';
import '../widgets/game_board.dart';
import '../widgets/score_board.dart';
import '../widgets/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  static const routeName = '/game-screen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.updateRoomListener(context);
    _socketMethods.errorOccurredListener(context);
    _socketMethods.updatePlayerStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game Screen',
        ),
      ),
      body: roomDataProvider.roomData['canJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ScoreBoard(),
                  const GameBoard(),
                  const Gap(20),
                  roomDataProvider.filledBoxes != 9
                      ? Text(
                          "${roomDataProvider.roomData['turn']['playerName']}'s turn",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: roomDataProvider.roomData['turn']
                                        ['socketID'] ==
                                    _socketMethods.socketClient?.id
                                ? Colors.red
                                : Colors.blue,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }
}
