import 'package:dynamic_programming_project/consts/consts.dart';
import 'package:flutter/material.dart';

class ProblemDefinetionScreen extends StatelessWidget {
  const ProblemDefinetionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Best Boxes for Packages"),
      ),
      body: Column(
        children: [
          //!
          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Text(Consts.problemExplainText),
          ),
          //!
          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child:  Text(Consts.whatWeNeed,style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
          ),
        ],
      ),
    );
  }
}
