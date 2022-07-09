import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final double barrierHeight;
  final double barrierXaxis;
  final double barrierYaxis;

  const Barrier(
      {Key? key,
      required this.barrierHeight,
      required this.barrierXaxis,
      required this.barrierYaxis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const barrierWidth = 0.4;
    return AnimatedContainer(
        duration: Duration(milliseconds: 0),
        alignment: Alignment(barrierXaxis, barrierYaxis),
        child: Container(
          
          width: MediaQuery.of(context).size.width * barrierWidth / 2,
          height:
              MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
          decoration:
              BoxDecoration(
                color: Colors.green,
                border: Border.all(width: 10, color: Color.fromARGB(255, 74, 179, 80)),
                borderRadius: BorderRadius.circular(10)),
        ));
  }
}
