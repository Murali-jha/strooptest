import 'package:flutter/material.dart';

import 'home.dart';

class resultpage extends StatefulWidget {
  int marks;
  resultpage({Key key , @required this.marks}) : super(key : key);
  @override
  _resultpageState createState() => _resultpageState(marks);
}

class _resultpageState extends State<resultpage> {

  List<String> images = [
    "images/success.png",
    "images/good.jpg",
    "images/bad.jpg",
  ];



  String message;
  String image;
  double number;


  @override
  void initState(){
    if(marks <= 20){
      image = images[2];
      message = "Try Hard!\n" + "You Scored $marks points";
    }else if(marks > 20 && marks<=35){
      image = images[1];
      message = "Good job!\n" + "You Scored $marks points";
    }else{
      image = images[0];
      message = "Excellent!\n" + "You Scored $marks points";
    }
    super.initState();
    number = (((marks/5)/15)*100);
  }

  int marks;
  _resultpageState(this.marks);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text("Result",style: TextStyle(fontSize: 26.0),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 12.0,
                        ),
                        child: Center(
                          child: Text(
                               message,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 12.0,
                        ),
                        child: Center(
                          child: Text(
                            "Accuracy: ${number.toStringAsFixed(2)} %",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => homepage(i: 1,),
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  minWidth: 200.0,
                  height: 45.0,
                  color: Colors.teal,
                  splashColor: Colors.teal,
                  highlightColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}