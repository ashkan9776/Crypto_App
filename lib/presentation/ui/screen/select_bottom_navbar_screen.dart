import 'package:crypto_app/presentation/ui/screen/home_screen.dart';
import 'package:crypto_app/presentation/ui/screen/market_view_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final PageController _controller = PageController();
  final pages = [
    const HomeScreen(),
    const MarketViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[pageIndex], bottomNavigationBar: buildMyNavBar(context));
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.currency_bitcoin,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.currency_bitcoin_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              // setState(() {
              //   pageIndex = 2;
              // });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              // setState(() {
              //   pageIndex = 3;
              // });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}
