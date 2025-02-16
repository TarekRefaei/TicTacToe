import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/responsive/responsive.dart';

import '../providers/room_data_provider.dart';
import '../resources/socket_methods.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.gridUpdateListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Responsive(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: size.height * 0.7,
          maxWidth: size.width,
        ),
        child: AbsorbPointer(
          absorbing: roomDataProvider.roomData['turn']['socketID'] !=
              _socketMethods.socketClient?.id,
          child: GridView.builder(
            itemCount: 9,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _socketMethods.gridUpdate(
                    index,
                    roomDataProvider.roomData['_id'],
                    roomDataProvider.gridState,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green.shade800,
                    ),
                  ),
                  child: Center(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        roomDataProvider.gridState[index],
                        style: TextStyle(
                          color: roomDataProvider.gridState[index] == "O"
                              ? Colors.blueAccent
                              : Colors.red,
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 20,
                              color: roomDataProvider.gridState[index] == "O"
                                  ? Colors.blueAccent
                                  : Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
