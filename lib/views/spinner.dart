import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SpinWheel extends StatefulWidget {
  final List items;
  final List colors;
  const SpinWheel({
    Key? key,
    this.items = const [],
    this.colors = const [],
  }) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  StreamController<int> selected = StreamController<int>();

  // static randomColor() {
  //   // Create integer random color
  //   final random = Random();
  //   final randomColor = Color.fromARGB(
  //     random.nextInt(256),
  //     random.nextInt(256),
  //     random.nextInt(256),
  //     random.nextInt(256),
  //   );
  //   return randomColor;
  // }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final colors = widget.colors;
    // final items = [
    //   'Right',
    //   'Left',
    //   'Straight',
    //   'Up',
    //   'Down',
    // ];
    // List<Color> colors = [];
    // for (var i = 0; i < items.length; i++) {
    //   Color color = randomColor();
    //   colors.add(color);
    // }
    // final List<int> colors = [
    //   900, 800, 700, 600, 500, 400, 300, 200, 100
    //   // Colors.red[100],
    //   // Colors.blue[200],
    //   // Colors.green[300]
    // ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spin Wheel'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected.add(
              Fortune.randomInt(0, items.length),
            );
          });
        },
        child: Column(
          children: [
            Expanded(
                child: FortuneWheel(
              indicators: const [
                FortuneIndicator(
                  alignment: Alignment.topCenter,
                  child: TriangleIndicator(
                    color: Colors.red,
                  ),
                )
              ],
              rotationCount: 10,
              animateFirst: false,
              selected: selected.stream,
              items: [
                // for (var item in items)
                for (var i = 0; i < items.length; i++)
                  FortuneItem(
                    child: Text(items[i]),
                    style: FortuneItemStyle(
                      color: colors[i],
                      borderColor: Colors.black38,
                      borderWidth: 2,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.5, 1.5),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
