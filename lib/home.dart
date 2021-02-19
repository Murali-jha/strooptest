import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:stroop_test/quizpage.dart';

class homepage extends StatefulWidget {
  int i;
  homepage({Key k,this.i}):super(key: k);
  @override
  _homepageState createState() => _homepageState(i: i);
}

class _homepageState extends State<homepage> {
  int i;
  _homepageState({this.i});
  List<String> images =[
    "images/level1.jpeg",
    "images/level2.jpeg",
    "images/level3.jpeg",
  ];

  List<String> description =[
    "Easy",
    "Medium",
    "Hard",
  ];

  Widget customcard(String langname,String images,String description){
    return Padding(
        padding: EdgeInsets.all(20.0),
      child: InkWell(
        onTap: (){
          debugPrint("Card Tapped");
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return getjson(langname);
          }));
        },
        child: Material(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(20.0),
          elevation: 10.0,
          child: Container(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(300.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            images
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(i!=1) {
      assetsAudioPlayer.open(
        Audio("audios/backgroundmusic.mp3"),
      );
    }
  }

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
        title: Text("Stroop Test",style: TextStyle(fontSize: 26.0),),
      ),
      body: ListView(
        children: [
          customcard("Python", images[0], description[0]),
          customcard("Java", images[1], description[1]),
          customcard("Javascript", images[2], description[2]),
        ],
      ),
    );
  }
}
