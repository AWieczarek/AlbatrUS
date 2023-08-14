import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  RatingWidget({super.key, required this.onSelect, required this.initialValue});

  final ValueChanged<int> onSelect;
  int initialValue;

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Rating"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final int ratingValue = index + 1;
            return IconButton(
              onPressed: () {
                setState(() {
                  widget.initialValue = ratingValue;
                  widget.onSelect(ratingValue);
                });
              },
              icon: Icon(
                widget.initialValue >= ratingValue ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
            );
          }),
        ),
      ],
    );
  }
}