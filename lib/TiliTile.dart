import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lu93rr/PrimitiveWrapper.dart';

class TiliTile extends StatelessWidget {

  final Function callback;
  final displayNumber;

  TiliTile(this.callback, this.displayNumber);

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        child: Container(
            margin: EdgeInsets.all(1),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.0, color: Colors.red
                ),
                color: displayNumber != 0 ? Colors.redAccent : Colors
                    .deepPurpleAccent
            ),

            child: Center(
              child: Text(displayNumber.toString()),
            )
        ),
        onTap: () {
          callback(displayNumber);
        },
      );
  }
}