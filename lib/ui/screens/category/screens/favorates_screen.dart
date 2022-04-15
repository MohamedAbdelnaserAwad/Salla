import 'package:flutter/cupertino.dart';
import 'package:salla/core/viewmodels/base_view.dart';
import 'package:salla/ui/screens/category/viewmodels/favorate_viewmodel.dart';
import 'package:salla/utils/locator.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    locator<FavoritesViewModel >().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FavoritesViewModel>(
        onModelReady: (mo) {},
        builder: (context, model, child) {
          print('home momomo');
          return ListView.separated(
            itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel.data.data[index].product, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          );

        }
    );


  }
}
