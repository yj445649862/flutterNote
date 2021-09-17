import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey globalKey = GlobalKey();
  double top = 75;
  double left = 0;
  double width = 100;
  double height = 150;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      key: globalKey,
      children: [
        Container(
          color: Colors.red,
        ),
        AnimatedPositioned(
          top: top,
          left: left,
          width: width,
          height: height,
          child: GestureDetector(
            onTap: () {
              if (width == size.width) {
                setState(() {
                  width = 100;
                  height = 150;
                  top = 75;
                  left = size.width - 150;
                });
              } else {
                setState(() {
                  width = size.width;
                  height = size.height - kBottomNavigationBarHeight;
                  top = 0;
                  left = 0;
                });
              }
            },
            onPanStart: (details) {},
            onPanUpdate: (details) {
              setState(() {
                if (top >= -150 && top <= size.height) {
                  top += details.delta.dy;
                }
                if (left <= size.width && left >= -50) {
                  left += details.delta.dx;
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.call),
                  SizedBox(height: 30),
                  Text('等待接听'),
                ],
              ),
            ),
          ),
          duration: Duration(milliseconds: 100),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
