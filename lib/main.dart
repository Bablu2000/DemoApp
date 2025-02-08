
import 'package:flutter/material.dart';
import 'Container1.dart';

void main(){
  runApp(Myapp());git
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: const Text("title1"),),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const Container1()));
              },
                  child: const Text("Go To next Page"))
            ],
          ),


        )
    );
  }

}