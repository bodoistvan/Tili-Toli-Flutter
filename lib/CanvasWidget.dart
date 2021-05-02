import 'package:flutter/material.dart';
import 'package:lu93rr/PrimitiveWrapper.dart';
import 'package:lu93rr/TiliTile.dart';

class MyCanvas extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => CanvasState();

}

class CanvasState extends State<MyCanvas> {
  static int columns = 6;
  static int rows = 6;

  var _tileValues = List(columns * rows);

  CanvasState(){
    for (var i = 0; i < columns * rows; i++){
      this._tileValues[i] = i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: columns.toDouble() * 50,
        height: rows.toDouble() * 50,
        margin: EdgeInsets.all((5)),
        color: Colors.orange,
        child: Column(
          children: (){
                var counter = 0;
                var columnWidgets = new List<Widget>();
                for ( var i = 0; i < rows; i++) {
                  var rowWidgets = new List<Widget>();
                  for (var j = 0; j < columns; j++) {
                    var myKey = UniqueKey();
                    var tile = new TiliTile(onTileClicked, this._tileValues[counter]);
                    rowWidgets.add(tile);
                    counter++;
                  }
                  columnWidgets.add(Row(children:rowWidgets));
                }
              return columnWidgets;
          }(),
        )
    );
  }

  onTileClicked(num value){
    if (value == 0)
      return;
    
    final index = this._tileValues.indexOf(value);
    print("index: $index");
    //check neigbors
    //top
    if (index > rows -1){
      print("top");
      final tni = index - columns;
      if (changeValuePosition(index, tni))
        return;
    }
    //bottom
    if (index < columns * rows - rows){
      print("bottom");
      final bni = index + columns;
      if (changeValuePosition(index, bni))
        return;
    }
    //left
    if (index % columns != 0){
      print("left");
      final lni = index - 1;
      if (changeValuePosition(index, lni))
      return;
    }
    //right
    if (index % columns != columns-1){
      print("right");
      final rni = index + 1;
      if (changeValuePosition(index, rni))
      return;
    }

  }

  bool changeValuePosition(num index_x, num index_y) {
    num valy = this._tileValues[index_y];
    if (valy != 0){
      print("nem");
      return false;
    }


    num valx = this._tileValues[index_x];

    setState(() {
      this._tileValues[index_y] = valx;
      this._tileValues[index_x] = valy;
    });
    print("igen");
    return true;
  }
}