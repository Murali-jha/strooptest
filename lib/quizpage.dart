import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stroop_test/resultpage.dart';

class getjson extends StatelessWidget {
  String langname;
  getjson(this.langname);
  String assettoload;


  setasset() {
    if (langname == "Python") {
      assettoload = "assets/python.json";
    } else if (langname == "Java") {
      assettoload = "assets/java.json";
    } else if (langname == "Javascript") {
      assettoload = "assets/js.json";
    } else if (langname == "C++") {
      assettoload = "assets/cpp.json";
    } else {
      assettoload = "assets/linux.json";
    }
  }
  @override
  Widget build(BuildContext context) {
    setasset();
    return FutureBuilder(
        builder: (context,snapshot){
          List mydata = json.decode(snapshot.data.toString());
          if(mydata==null){
            return Scaffold(
              body: Center(
                child: Text(
                  "Loading..."
                ),
              ),
            );
          }else{
            return quizpage(mydata:mydata,stage: langname,);
          }
        },
      future: DefaultAssetBundle.of(context).loadString(assettoload),
    );
  }
}

class quizpage extends StatefulWidget {

  var mydata;
  String stage;
  quizpage({Key key,@required this.mydata,@required this.stage}) : super(key: key);

  @override
  _quizpageState createState() => _quizpageState(mydata,stage);
}

class _quizpageState extends State<quizpage> {




  var mydata;
  String stage;
  _quizpageState(this.mydata,this.stage);

  Color colorToShow = Colors.teal;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks =0;
  int i=1;
  int timer=15;
  String showTimer = "15";
  Color timerColor = Colors.green;
  Map<String,Color> btnColor = {
    "a": Colors.teal,
    "b": Colors.teal,
    "c": Colors.teal,
    "d": Colors.teal
  };

  List<Color> color = [
    Colors.green,
    Colors.green,
    Colors.blue,
    Colors.teal,
    Colors.pink,
    Colors.purple,
    Colors.deepOrange,
    Colors.red,
    Colors.amber,
    Colors.black,
    Colors.indigo,
    Colors.brown,
    Colors.pink,
    Colors.yellow,
    Colors.grey,
    Colors.purple
  ];

  setAsset(){
    setState(() {
      if(stage == "Python"){
        timer = 12;
        showTimer = "12";
      }
      else if(stage == "Java"){
        timer = 7;
        showTimer = "7";
      }
      else{
        timer = 3;
        showTimer = "3";
      }
    });
  }

  bool cancelTimer =false;
  Color questionColor = Colors.green;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    setAsset();
  }


  void startTimer() async{
    const oneSec = Duration(seconds: 1) ;
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if(timer<1){
          t.cancel();
          nextQuestion();
        }
        else if(cancelTimer == true){
          t.cancel();
        }
        else{
          timer = timer-1;
        }
        if(timer<7){
          timerColor = Colors.red;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion(){
    cancelTimer = false;
    setAsset();
    timerColor = Colors.green;
    setState(() {
      if(i<15){
        i++;
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return resultpage(marks: marks);
        }));
      }
      btnColor["a"] = Colors.teal;
      btnColor["b"] = Colors.teal;
      btnColor["c"] = Colors.teal;
      btnColor["d"] = Colors.teal;
      questionColor = color[i];
    });
    startTimer();
  }


  void checkAnswer(String k){
    if(mydata[2][i.toString()] == mydata[1][i.toString()][k]){
      marks = marks+5;
      colorToShow = right;
    }
    else{
      colorToShow = wrong;

    }
    setState(() {
      btnColor[k] = colorToShow;
      cancelTimer = true;
    });

    Timer(Duration(seconds: 1),nextQuestion);
  }

  Widget choiceButton(String k){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
      child: MaterialButton(
        onPressed: () => checkAnswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0
          ),
          maxLines: 1,
        ),
        color: btnColor[k],
        minWidth: 200.0,
        height: 45.0,
        splashColor: Colors.teal,
        highlightColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
            context: context,
          builder: (context){
              return AlertDialog(
                title: Text(
                  "Warning",
                  style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                ),
                content: Text(
                  "You Can't Go Back At This Stage"
                ),
                actions: [
                  FlatButton(
                    color: Colors.green,
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok!",style: TextStyle(fontSize: 15.0),)
                  )
                ],
              );
          }
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text("Stroop Test",style: TextStyle(fontSize: 26.0),),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Text(
                      "Time Remaining : $showTimer",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Times New Roman",
                          color: timerColor
                      ),
                    ),
                  )
              ),
              flex: 1,
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    mydata[0][i.toString()],
                    style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: "Quando",
                      color: questionColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              flex: 3,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    choiceButton('a'),
                    choiceButton('b'),
                    choiceButton('c'),
                    choiceButton('d'),
                  ],
                ),
              ),
              flex: 6,
            ),

          ],
        ),
      ),
    );
  }
}

