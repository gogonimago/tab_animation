import 'dart:io';

import 'package:flutter/material.dart';

class TabAnimation extends StatefulWidget {
  final double safeAreaHeight;

  const TabAnimation({Key key, this.safeAreaHeight}) : super(key: key);
  @override
  _TabAnimationState createState() => _TabAnimationState();
}

class _TabAnimationState extends State<TabAnimation> {
  bool openFavorites = false;
  double _windowWidth = 0;
  double _windowHeight = 0;
  double _favoritesHeight = 0;

  double _favoritesYOffset = 0;
  double _favoritesXOffset = 0;

  List<String> itemsList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
  ];
  List<String> favoritesItemsList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
  ];

  @override
  Widget build(BuildContext context) {
    _windowHeight = MediaQuery.of(context).size.height;
    _windowWidth = MediaQuery.of(context).size.width;

    double safeAreaHeight = _windowHeight - widget.safeAreaHeight;
    double yOffset = 0;

    _favoritesHeight = widget.safeAreaHeight;
    if (safeAreaHeight > 20 && Platform.isIOS) {
      yOffset = 84.5;
    } else {
      yOffset = 105;
    }

    if (openFavorites) {
      _favoritesYOffset = 5;
    } else {
      _favoritesYOffset = _favoritesHeight - yOffset;
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1.0, -2),
                  blurRadius: 5.0,
                  spreadRadius: 0.1,
                ),
              ],
            ),
            child: Column(
              children: [
                _buildTabTitle(
                    title: 'Items',
                    count: itemsList.length.toString(),
                    tabTitleTap: () {
                      setState(() {
                        openFavorites = false;
                      });
                    }),
                Expanded(
                  child: ListView(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: itemsList.map(
                        (item) {
                          return ListTile(
                            title: Text(item),
                          );
                        },
                      ),
                    ).toList(),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          top: 50,
          child: AnimatedContainer(
            width: _windowWidth,
            height: _favoritesHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(
                _favoritesXOffset, _favoritesYOffset, 1),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1.0, -2),
                    blurRadius: 5.0,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildTabTitle(
                      title: 'Favorite items',
                      count: favoritesItemsList.length.toString(),
                      tabTitleTap: () {
                        setState(() {
                          openFavorites = true;
                        });
                      }),
                  favoritesItemsList.isEmpty
                      ? Container()
                      : Expanded(
                          child: ListView(
                            children: ListTile.divideTiles(
                              context: context,
                              tiles: favoritesItemsList.map(
                                (beaconData) {
                                  return ListTile(
                                    title: Text(beaconData),
                                  );
                                },
                              ),
                            ).toList(),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabTitle({String title, String count, Function tabTitleTap}) {
    return GestureDetector(
      onTap: tabTitleTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0),
        height: 70.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  ),
                ),
                Text(count),
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            Divider(
              height: 4.0,
              thickness: 4.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
