import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key, required this.onSelect});

  final ValueChanged<int> onSelect;

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _rating = 3;

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
                  _rating = ratingValue;
                  widget.onSelect(_rating);
                });
              },
              icon: Icon(
                _rating >= ratingValue ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
            );
          }),
        ),
      ],
    );
  }
}