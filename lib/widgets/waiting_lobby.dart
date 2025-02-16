import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';

import '../providers/room_data_provider.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController roomIdController;

  @override
  void initState() {
    roomIdController = TextEditingController(
        text: Provider.of<RoomDataProvider>(context, listen: false)
            .roomData['_id']);
    super.initState();
  }

  @override
  void dispose() {
    roomIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 10,
          ),
          const Gap(20),
          const Text("Wait for another Player to join"),
          const Gap(20),
          CustomTextField(
            controller: roomIdController,
            hintText: "",
            isReadonly: true,
          ),
        ],
      ),
    );
  }
}
