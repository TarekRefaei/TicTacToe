import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../resources/socket_methods.dart';
import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  static const String routeName = '/join-room';

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccurredListener(context);
    _socketMethods.updatePlayerStateListener(context);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: "Join Room",
                  textSize: 70,
                  shadows: [
                    Shadow(
                      blurRadius: 40,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
                Gap(
                  size.height * 0.08,
                ),
                CustomTextField(
                  controller: _nameController,
                  hintText: "Enter Player Name",
                ),
                Gap(
                  size.height * 0.05,
                ),
                CustomTextField(
                  controller: _gameIdController,
                  hintText: "Enter game ID",
                ),
                Gap(
                  size.height * 0.05,
                ),
                CustomButton(
                  onPressed: () {
                    _socketMethods.joinRoom(
                      _nameController.text,
                      _gameIdController.text,
                    );
                  },
                  text: "Join Room",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
