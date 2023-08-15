import 'package:albatrus/custom_colors.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  RatingWidget({super.key, required this.onSelect, required this.initialValue, required this.changable, required this.size});

  final ValueChanged<int> onSelect;
  final bool changable;
  final double size;
  int initialValue;

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {

  final starColor = CustomColors().strokeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final int ratingValue = index + 1;
        return IconButton(
          onPressed: () {
            if(widget.changable){
            setState(() {
              widget.initialValue = ratingValue;
              widget.onSelect(ratingValue);
            });}
          },
          icon: Icon(
            widget.initialValue >= ratingValue ? Icons.star : Icons.star_border,
            color: starColor,
            size: widget.size,
          ),
        );
      }),
    );
  }
}