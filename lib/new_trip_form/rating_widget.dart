import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key, required this.onSelect, required this.initialValue});

  final ValueChanged<int> onSelect;
  final int initialValue;

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {

  @override
  Widget build(BuildContext context) {
    int rating = widget.initialValue;
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
                  rating = ratingValue;
                  widget.onSelect(rating);
                });
              },
              icon: Icon(
                rating >= ratingValue ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
            );
          }),
        ),
      ],
    );
  }
}