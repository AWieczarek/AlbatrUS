import 'package:albatrus/database_service.dart';
import 'package:albatrus/models/user.dart';
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
        Text(widget.user.username),
        Visibility(
          visible: _isSent,
          replacement: ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await DatabaseService.addFriendRequestToUser(
                    widget.user.id, widget.ownerId);
                setState(() {
                  _isSent = true;
                });
              },
              child: Visibility(
                visible: _isLoading,
                replacement: const Text("Add"),
                child: const CircularProgressIndicator(),
              )),
          child: const Text("request sent"),
        )
      ],
    ));
  }
}
