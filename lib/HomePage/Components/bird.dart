import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Bird extends StatelessWidget {
  final double birdY;
  final double birdHeight;
  final double birdWidth;
  const Bird(
      {Key? key,
      required this.birdY,
      required this.birdHeight,
      required this.birdWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment(0, (2 * birdY + birdHeight) / (2 - birdHeight)),
      child: Image.asset(
        "assets/images/flappybird.png",
        height: _screenSize.height * 3 / 4 * birdHeight / 2,
        width: _screenSize.width * birdWidth / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
