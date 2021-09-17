import 'package:flutter/material.dart';
import 'package:flutter_note/widgets/HomePage.dart';
import 'package:flutter_note/widgets/MyPage.dart';
import 'package:flutter_note/widgets/SearchPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  List<Widget> _list = [
    HomePage(),
    SearchPage(),
    MyPage(),
  ];
  int _selectedIndex = 2;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _list,
        onPageChanged: (int) {
          setState(() {
            _selectedIndex = int;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        currentIndex: _selectedIndex,
        enableFeedback: false,
        elevation: 12,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: '首页',
              backgroundColor: Colors.blueAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '搜索',
              backgroundColor: Colors.blueAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '我的',
              backgroundColor: Colors.blueAccent),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
