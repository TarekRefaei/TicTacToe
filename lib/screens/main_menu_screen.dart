import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/widgets/custom_button.dart';

import '../responsive/responsive.dart';
import 'join_room_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  static const String routeName = '/main-menu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Responsive(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    CreateRoomScreen.routeName,
                  );
                },
                text: "Create Room",
              ),
              const Gap(
                20,
              ),
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    JoinRoomScreen.routeName,
                  );
                },
                text: "Join Room",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
