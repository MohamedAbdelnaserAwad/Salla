import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/core/viewmodels/base_view.dart';
import 'package:salla/ui/screens/category/screens/search_sreen.dart';
import 'package:salla/ui/screens/category/viewmodels/categories_viewmodel.dart';
import 'package:salla/ui/screens/category/viewmodels/home_viewmodel.dart';
import 'package:salla/utils/locator.dart';

class MainLayoutScreen extends StatefulWidget {
  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {

  void initState() {
    super.initState();
    locator<HomeViewModel>().getCategories();
    locator<CategoriesViewModel>().getCategories();
  }


  @override
  Widget build(BuildContext context) {

    return BaseView<HomeViewModel>(
        onModelReady: (mo) {},
        builder: (context, model, child) {
          print('main mememem');
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Salla',
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                  },
                ),
              ],
            ),
            body: model.bottomScreens[model.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps_outlined ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              currentIndex: model.currentIndex,
              selectedItemColor: Colors.blue,
              onTap: (index){
                setState(() {
                  model.changeBottom(index);
                });

              },
            ),
          );

        }
    );
  }
}