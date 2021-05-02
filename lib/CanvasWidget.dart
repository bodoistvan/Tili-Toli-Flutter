import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lu93rr/PrimitiveWrapper.dart';
import 'package:lu93rr/TiliTile.dart';

class MyCanvas extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => CanvasState();

}

class CanvasState extends State<MyCanvas> {
  static int columns = 6;
  static int rows = 6;

  final _canvasColor = Colors.orange;
  var _tileValues = List(columns * rows);

  var _stepCounter = 0;

  CanvasState(){
    for (var i = 0; i < columns * rows; i++){
      this._tileValues[i] = i;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Tili-Toli"),
      ),
      body: Center(
          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(55),
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(
                        width: 2,
                        color: Colors.redAccent
                      )
                    ),
                    child: Center(
                      child: Text("$_stepCounter", textScaleFactor: 1.5,),
                    ),
                  ),
                  Container(
                      width: columns.toDouble() * 50,
                      height: rows.toDouble() * 50,
                      color: _canvasColor,
                      child: Column(
                        children: (){
                          var counter = 0;
                          var columnWidgets = new List<Widget>();
                          for ( var i = 0; i < rows; i++) {
                            var rowWidgets = new List<Widget>();
                            for (var j = 0; j < columns; j++) {
                              var myKey = UniqueKey();
                              var tile = new TiliTile(onTileClicked, this._tileValues[counter], this._canvasColor);
                              rowWidgets.add(tile);
                              counter++;
                            }
                            columnWidgets.add(Row(children:rowWidgets));
                          }
                          return columnWidgets;
                        }(),
                      )
                  )
                ],
              )
          ),
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {this.restartGame()},
        tooltip: 'Restart',
        backgroundColor: Colors.red,
        splashColor: Colors.amber,
        child: Icon(Icons.autorenew),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  restartGame(){
    print("restart");
    setState(() {
      this._tileValues.shuffle();
      this._stepCounter = 0;
    });
  }

  onTileClicked(num value){
    if (value == 0)
      return;
    
    final index = this._tileValues.indexOf(value);
    //check neigbors
    //top
    if (index > rows -1){
      final tni = index - columns;
      if (changeValuePosition(index, tni))
        return;
    }
    //bottom
    if (index < columns * rows - rows){
      final bni = index + columns;
      if (changeValuePosition(index, bni))
        return;
    }
    //left
    if (index % columns != 0){
      final lni = index - 1;
      if (changeValuePosition(index, lni))
      return;
    }
    //right
    if (index % columns != columns-1){
      final rni = index + 1;
      if (changeValuePosition(index, rni))
      return;
    }

  }

  bool changeValuePosition(num index_x, num index_y) {
    num valy = this._tileValues[index_y];
    if (valy != 0){
      return false;
    }

    num valx = this._tileValues[index_x];

    setState(() {
      this._stepCounter++;
      this._tileValues[index_y] = valx;
      this._tileValues[index_x] = valy;
    });
    return true;
  }
}