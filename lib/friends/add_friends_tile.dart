import 'package:albatrus/database_service.dart';
import 'package:albatrus/models/user.dart';
import 'package:albatrus/rounded_elevated_button.dart';
import 'package:flutter/material.dart';

class AddFriendsTile extends StatefulWidget {
  AddFriendsTile({Key? key, required this.ownerId, required this.user})
      : super(key: key);
  final String ownerId;
  final UserData user;

  @override
  State<AddFriendsTile> createState() => _AddFriendsTileState();
}

class _AddFriendsTileState extends State<AddFriendsTile> {
  bool _isLoading = false;
  bool _isSent = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.user.username, style: TextStyle(color: Colors.white)),
        Visibility(
          visible: _isSent,
          replacement: RoundedElevatedButton(onPress: () async {
            setState(() {
              _isLoading = true;
            });
            await DatabaseService.addFriendRequestToUser(
                widget.user.id, widget.ownerId);
            setState(() {
              _isSent = true;
            });
          },title: "Add"),
          child: const Text("request sent", style: TextStyle(color: Colors.white)),
        )
      ],
    ));
  }
}
