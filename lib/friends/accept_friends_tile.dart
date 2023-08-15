import 'package:albatrus/database_service.dart';
import 'package:albatrus/models/user.dart';
import 'package:flutter/material.dart';

class AcceptFriendsTile extends StatefulWidget {
  AcceptFriendsTile({Key? key, required this.ownerId, required this.user})
      : super(key: key);
  final String ownerId;
  final UserData user;

  @override
  State<AcceptFriendsTile> createState() => _AcceptFriendsTileState();
}

class _AcceptFriendsTileState extends State<AcceptFriendsTile> {
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
                await DatabaseService.removeFriendRequestToUser(
                    widget.ownerId, widget.user.id);

                await DatabaseService.addFriendToAccepted(
                    widget.ownerId, widget.user.id);

                await DatabaseService.addFriendToAccepted(
                    widget.user.id, widget.ownerId);

                setState(() {
                  _isSent = true;
                });
              },
              child: Visibility(
                visible: _isLoading,
                replacement: const Text("Accept"),
                child: const CircularProgressIndicator(),
              )),
          child: const Text("friend accepted"),
        )
      ],
    ));
  }
}
