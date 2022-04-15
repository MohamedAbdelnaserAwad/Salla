import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/core/viewmodels/base_view.dart';
import 'package:salla/ui/screens/category/models/categories_response.dart';
import 'package:salla/ui/screens/category/viewmodels/categories_viewmodel.dart';
import 'package:salla/ui/shared/components.dart';
import 'package:salla/utils/locator.dart';
import 'package:salla/utils/navigation_service.dart';
import 'package:salla/utils/routes_path.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    locator<CategoriesViewModel>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return BaseView<CategoriesViewModel>(
        onModelReady: (mo) {},
        builder: (context, model, child) {

          return Scaffold(

            body: model.categories != null
                ? ListView.separated(
              itemBuilder: (context, index) => buildCatItem(CategoriesResponse.data!.data![index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: CategoriesResponse.data!.data!.length,
            )

                : const Text(""),
          );

        }
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage('${model.image}'),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );

}
