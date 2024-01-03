import 'package:flutter/material.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/avaiable_tshirt_page.dart';
import 'package:frontendapp/views/feed/feed_page.dart';
import 'package:frontendapp/constants/icons.dart';
import 'package:frontendapp/constants/color.dart';
import 'package:frontendapp/constants/size.dart';
import 'package:frontendapp/views/home/home_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = [
    const HomePage(),
    const FeedPage(),
    OrderPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icFeatured,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icFeaturedOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icWishlist,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icWishlistOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "Wishlist",
            ),
            const BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.local_mall,
                size: kBottomNavigationBarItemSize,
              ),
              icon: Icon(
                Icons.local_mall_outlined,
                size: kBottomNavigationBarItemSize,
              ),
              label: 'Order T-shirt',
            )
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
