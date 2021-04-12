import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -20,
            right: 0,
            child: Image.asset(
              'assets/images/top_left.png',
              width: size.width * .6,
            ),
          ),
          Positioned(
            top: 50,
            left: -10,
            child: Image.asset(
              'assets/images/circle.png',
              width: size.width * .4,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/bottom_left.png',
              width: size.width * .8,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
