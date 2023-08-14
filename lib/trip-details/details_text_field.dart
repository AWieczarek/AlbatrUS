import 'package:flutter/material.dart';

class DetailsTextField extends StatelessWidget {
  final String detail;
  final String coto;

  DetailsTextField({
    super.key,
    required this.detail,
    required this.coto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0.0),
      child: Column(
        children: [
          Padding(
            padding:
            EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                coto,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 12, color: Color.fromRGBO(40, 50, 70, 1.0),),
              ),
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(40, 40, 40, 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    border: Border.all(
                        color: Color.fromRGBO(40, 50, 70, 1.0),
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      detail,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
