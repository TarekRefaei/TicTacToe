import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';

import '../resources/socket_methods.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  static const String routeName = '/create-room';

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.createRoomSuccessListener(context);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                  text: "Create Room",
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
                CustomButton(
                  onPressed: () {
                    _socketMethods.createRoom(
                      _nameController.text,
                    );
                  },
                  text: "Create Room",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
