import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/providers/room_data_provider.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/screens/main_menu_screen.dart';
import 'package:tictactoe/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return RoomDataProvider();
      },
      child: MaterialApp(
        title: 'TicTacToe',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: bgColor
        ),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}