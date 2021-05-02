import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lu93rr/PrimitiveWrapper.dart';

class TiliTile extends StatelessWidget {

  final Function callback;
  final displayNumber;

  final size;
  final canvasColor;

  final isBlank;

  TiliTile(this.callback, this.displayNumber, this.canvasColor, this.size, this.isBlank );

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        child: Container(
            margin: EdgeInsets.all(1),
            width: size -2 ,
            height: size -2,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.0,
                    color : isBlank ? this.canvasColor : Colors.red
                ),
                color: isBlank ? this.canvasColor : Colors.redAccent
            ),

            child: Center(
              child: Text(isBlank ? '': (displayNumber + 1).toString()),
            )
        ),
        onTap: () {
          callback(displayNumber);
        },
      );
  }
}