import 'dart:math';

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
  var columns = 3;
  var rows = 3;

  var gameover = false;

  final _canvasColor = Colors.orange;
  final _canvasWidth = 350.0;
  final _canvasHeight = 350.0;
  var _tileValues = new List<int>();

  var _stepCounter = 0;

  CanvasState(){
    for (var i = 0; i < columns * rows; i++){
      this._tileValues.add(i);
    }

  }

  onMenuSelected(String selected){
    if (selected == '3x3'){
      setState(() {
        this.rows = 3;
        this.columns = 3;
        this.restartGame();
      });
    }
    if (selected == '4x4'){
      setState(() {
        this.rows = 4;
        this.columns = 4;
        this.restartGame();
      });
    }
    if (selected == '5x5'){
      setState(() {
        this.rows = 5;
        this.columns = 5;
        this.restartGame();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Tili-Toli"),
        actions: [
          PopupMenuButton<String>(
            onSelected: onMenuSelected,
            color: Colors.redAccent,

            itemBuilder: (BuildContext context) {
              return {'3x3', '4x4', '5x5'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Center(
                    child:
                    Text(choice,
                        style: TextStyle(
                          color: Colors.white,
                        )
                    ),
                  )
                );
              }).toList();
            },
          ),
        ],
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
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.orange,
                      border: Border.all(
                        width: 2,
                        color: Colors.redAccent
                      )
                    ),
                    child: Center(
                      child: Text("$_stepCounter", textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _canvasColor,
                      ),
                      width: _canvasHeight,
                      height: _canvasWidth,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (){

                          if (gameover == true){
                            return [Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "YOU WON!",
                                  style: TextStyle(
                                      color: Colors.white,
                                  ),
                                  textScaleFactor: 3,
                                ),
                              )
                          )];
                          }

                          var counter = -1;
                          var columnWidgets = new List<Widget>();
                          for ( var i = 0; i < rows; i++) {
                            var rowWidgets = new List<Widget>();
                            for (var j = 0; j < columns; j++) {
                              var myKey = UniqueKey();
                              counter++;
                              var tile = new TiliTile(onTileClicked, this._tileValues[counter], this._canvasColor, this._canvasWidth / rows, this._tileValues[counter] + 1 == rows*columns);
                              rowWidgets.add(tile);
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
      backgroundColor: Colors.orange[400],
      floatingActionButton: FloatingActionButton(
        onPressed: () => {this.restartGame()},
        tooltip: 'Restart',
        backgroundColor: Colors.redAccent,
        splashColor: Colors.amber,
        child: Icon(Icons.autorenew),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  restartGame(){
    _tileValues.clear();
    for (var i = 0; i < columns * rows; i++){
      this._tileValues.add(i);
    }

    shuffleTiles();

    setState(() {
      this.gameover = false;
      this._tileValues = this._tileValues;
      this._stepCounter = 0;
    });
  }
  Random r = new Random();
  shuffleTiles(){

      var count = 0;
      var blankValue=this.columns *this.rows -1;

      do {
        var index = this._tileValues.indexOf(blankValue);
        var direction = r.nextInt(4);
//check neigbors
        //top
        if (index > rows -1 && direction == 0){
          final other = index - columns;
          this._tileValues[index] = this._tileValues[other];
          this._tileValues[other] = blankValue;
          count++;
        }
        //bottom
        if (index < columns * rows - rows && direction == 1 ){
          final other = index + columns;
          this._tileValues[index] = this._tileValues[other];
          this._tileValues[other] = blankValue;
          count++;
        }
        //left
        if (index % columns != 0 && direction == 2){
          final other = index - 1;
          this._tileValues[index] = this._tileValues[other];
          this._tileValues[other] = blankValue;
          count++;
        }
        //right
        if (index % columns != columns-1 && direction == 3){
          final other = index + 1;
          this._tileValues[index] = this._tileValues[other];
          this._tileValues[other] = blankValue;
          count++;
        }



      }while(count != 1000);

      print(this._tileValues);
  }

  onTileClicked(num value){
    num blankedValue = (rows* columns) -1 ;
    if (value == blankedValue)
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
    num blankedValue = ( rows * columns ) -1 ;
    num valy = this._tileValues[index_y];
    if (valy != blankedValue){
      return false;
    }

    num valx = this._tileValues[index_x];

    setState(() {
      this._stepCounter++;
      this._tileValues[index_y] = valx;
      this._tileValues[index_x] = valy;
    });
    checkGameOver();
    return true;
  }

  void checkGameOver(){
    var itIsGameOver= true;
    for (int i = 0; i < this._tileValues.length -1; i++){
      if (this._tileValues[i] > this._tileValues[i+1]){
        itIsGameOver = false;
        break;
      }
    }

    if (itIsGameOver == true){
      setState(() {
        this.gameover = true;
      });
    }
  }
}