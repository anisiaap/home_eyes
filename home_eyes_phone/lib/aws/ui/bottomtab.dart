import 'package:flutter/material.dart';

import 'package:home_eyes/aws/cardrfid/cardrfid.dart';
import 'package:home_eyes/aws/doorlock/doorlock.dart';
import 'package:home_eyes/aws/user/profile.dart';
import 'package:home_eyes/aws/homepage/homepage.dart';
import 'package:home_eyes/aws/faceid/faceid.dart';

class BottomTabs extends StatefulWidget {
  final int _selectedIndex;
  const BottomTabs(Key? key, this._selectedIndex) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();

  int get_selectedIndex() {
    return _selectedIndex;
  }
}

class _BottomTabsState extends State<BottomTabs> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget._selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        _navigateToPage(index);
      },
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: const IconThemeData(size: 30, opacity: 1),
      unselectedIconTheme: const IconThemeData(size: 24, opacity: 1),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lock),
          label: 'DoorLock',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'FaceId',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'CardRfid',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoorLockPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FaceIdPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CardRfidPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }
}
