import 'package:dynamic_programming_project/logic/logic_project_dc.dart';
import 'package:dynamic_programming_project/screen/problem_definetion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TextEditingController _package = TextEditingController();
  final TextEditingController _boxes = TextEditingController();
  List<List<int>> boxSizes = [];
  String minEmptySpace = "";
  bool isLoading = false;
  List<String> pairs = [];
  List<int> packageSizes = [];
  int packagesLength = 0;
  bool rightBoxesFormat = false;
  bool rightPackagesFormat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  pairs = [];
                  minEmptySpace = "";
                  packageSizes = [];
                  packagesLength = 0;
                  boxSizes = [];
                });
              },
              icon: const Icon(CupertinoIcons.refresh)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ProblemDefinetionScreen()));
              },
              icon: const Icon(CupertinoIcons.info)),
        ],
        title: const Text("DIVIDE AND CONQUER "),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 30, right: 30),
              child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.08,
                  child: TextField(
                    controller: _package,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_package.text.isEmpty) {
                                  packageSizes.clear();
                                  packagesLength = 0;
                                } else {
                                  packageSizes = _package.text
                                      .split(' ')
                                      .map(int.parse)
                                      .toList();
                                  packagesLength = packageSizes.length;
                                  _package.text = "";
                                }
                              });
                            },
                            icon: Icon(
                              Icons.send_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        icon: const Icon(Icons.add_task_rounded),
                        hintText: "ADD YOUR PACKAGE"),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 30, right: 30),
              child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.08,
                  child: TextField(
                    controller: _boxes,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                boxSizes.add(_boxes.text
                                    .split(' ')
                                    .map(int.parse)
                                    .toList());
                                _boxes.text = "";
                              });
                            },
                            icon: Icon(
                              Icons.send_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        icon: const Icon(CupertinoIcons.cube_box_fill),
                        hintText: "ADD YOUR BOXES (3  5   6  10  13)"),
                  )),
            ),
            Title(color: Colors.green, child: const Text("packases")),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: packagesLength,
                  itemBuilder: (context, index) {
                    var item = packageSizes[index];
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(4)),
                          height: 55,
                          child: Center(
                            child: Text(item.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer)),
                          ),
                        ));
                  }),
            ),
            Title(color: Colors.green, child: const Text("Boxes")),
            SizedBox(
              width: double.infinity,
              height: 65,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: boxSizes.length,
                  itemBuilder: (context, index) {
                    var item = boxSizes[index].join(" ");
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(4)),
                        height: 65,
                        child: Center(
                          child: Text(item,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer)),
                        ),
                      ),
                    );
                  }),
            ),
            Title(color: Colors.black, child: const Text("logs")),
            Expanded(
                child: isLoading
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.green, size: 30)
                    : ListView.builder(
                        itemCount: pairs.length,
                        itemBuilder: (context, index) {
                          var item = pairs[index];
                          return index == 0
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  width: 70,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: item == "NO SOLUTION FOUND"
                                        ? Theme.of(context).colorScheme.error
                                        : Theme.of(context).colorScheme.surfaceTint,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(child: Text(item ,style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 50, right: 50),
                                  width: 70,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color:Theme.of(context).colorScheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(child: Text(item,style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant,),)),
                                );
                        }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<String> res = computeBestPackagingCost(
              packagesLength, boxSizes.length, boxSizes, packageSizes);
          setState(() {
            isLoading = true;

            pairs = res;

            isLoading = false;
          });
        },
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
