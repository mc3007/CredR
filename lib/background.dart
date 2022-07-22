import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    required this.child,
});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: -350,
                left: -200,
                child: Image.asset('assets/circle.png',
                  width: MediaQuery.of(context).size.width*1.5,
                  height: MediaQuery.of(context).size.height*1.5,)),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
