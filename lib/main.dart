import 'package:animated/animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:just_audio/just_audio.dart';

import 'package:sensors_plus/sensors_plus.dart';
void main() {
  runApp( GetMaterialApp(home: MyHomePage(title: 'Anasayfa'),));
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class Controller extends GetxController{
  var x="assets/drop-fill.svg".obs,y=0.obs,xp=0.obs;
  change_cord(x1){xp.value=(x1).round();
    if((x1).round()*10>20 || (x1).round()*10<-20 ){
      x.value="assets/focus-fill.svg";
    }else{ x.value="assets/drop-fill.svg";}
  }
}
class _MyHomePageState extends State<MyHomePage> {
  final _player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
    _player.setAsset('assets/dink.mp3');
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,

    ]);
    _player.setAsset('assets/dink.wav');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    accelerometerEvents.listen((AccelerometerEvent event) {
      c.change_cord(event.x);

      if((event.x).round()*10>20 || (event.x).round()*10<-20 ){
        _player.play().then((value) => _player.seek(Duration(seconds: 1)));
        
      }
    });

    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[

             Obx(()=> Animated(
               child: SvgPicture.asset('${c.x.toString()}',width: 250),
               value: c.xp.toDouble(),
               curve: Curves.decelerate,
               duration: Duration(milliseconds: 300),
               builder: (context,child,animation)=>Transform.scale(scale: animation.value,
                   child: child),

             ),

             ),

          ],
        ),
      ),
      
    );
  }
}
