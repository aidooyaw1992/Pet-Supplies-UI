import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:petsupplies/core/common_colors.dart';
import 'package:petsupplies/main.dart';
import 'package:petsupplies/view_detail/supply_item_detail.dart';
import 'package:provider/provider.dart';

import '../core/common_dimens.dart';

class FavouriteListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: CommonDimens.leftRightPadding / 4),
      height: 280,
      child: ChangeNotifierProvider<SupplyItemProviderModel>(
        create: (_) => SupplyItemProviderModel(),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: CommonDimens.leftRightPadding,
                bottom: CommonDimens.leftRightPadding / 2,
              ),
              child: GestureDetector(
                onTap: () {
                  Provider.of<SupplyItemProviderModel>(context, listen: false)
                      .assignSelectedItem(index);
                  Navigator.pushNamed(context, SupplyItemDetailRoute.routeName,
                      arguments: index);
                },
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 200, end: 0),
                  duration: Duration(
                    milliseconds: 300 * (index + 2),
                  ),
                  builder: (_, double progress, Widget child) {
                    return Transform.translate(
                      offset: Offset(progress, 0),
                      child: child,
                    );
                  },
                  child: SizedBox(
                    width: 200,
                    child: Hero(
                      tag: favouriteItemList[index].itemImage,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Card(
                            color: favouriteItemList[index].color,
                            margin: const EdgeInsets.all(0),
                            clipBehavior: Clip.antiAlias,
                            elevation:
                                Provider.of<SupplyItemProviderModel>(context)
                                            .selectedItem ==
                                        index
                                    ? 8
                                    : 2,
                            shadowColor:
                                Provider.of<SupplyItemProviderModel>(context)
                                            .selectedItem ==
                                        index
                                    ? CommonColors.accentColor.withOpacity(0.3)
                                    : CommonColors.cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(
                                  CommonDimens.leftRightPadding,
                                ),
                                bottomLeft: Radius.circular(
                                  CommonDimens.leftRightPadding / 10,
                                ),
                                topLeft: Radius.circular(
                                  CommonDimens.leftRightPadding / 10,
                                ),
                                topRight: Radius.circular(
                                  CommonDimens.leftRightPadding / 10,
                                ),
                              ),
                            ),
                            child: Image.network(
                              favouriteItemList[index].itemImage,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: CommonDimens.leftRightPadding / 2,
                                bottom: CommonDimens.leftRightPadding / 2,
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<CartModel>(context,
                                            listen: false)
                                        .addItemToCart(
                                            favouriteItemList[index]);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Added to your cart"),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: CommonColors.accentColor,
                                    ));
                                  },
                                  child: CircleAvatar(
                                    radius: 16,
                                    child: Icon(
                                      FlutterIcons.add_mdi,
                                      color: CommonColors.iconColor,
                                    ),
                                    backgroundColor: CommonColors.accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: favouriteItemList.length,
        ),
      ),
    );
  }
}

class SupplyItemModel {
  String itemImage;
  String itemName;
  double itemPrice;
  Color color;
  SupplyItemModel({
    @required this.itemImage,
    @required this.itemName,
    @required this.itemPrice,
    @required this.color,
  });
}

final favouriteItemList = [
  SupplyItemModel(
    itemImage:
        "https://petcentral.chewy.com/wp-content/uploads/2018/06/FriscoBlanket_HERO.png?x34063",
    itemName: "Comforters",
    itemPrice: 2132,
    color: Colors.white,
  ),
  SupplyItemModel(
    itemImage:
        "https://cdn.shopify.com/s/files/1/0025/1373/1702/products/BH_New_1kg_Puppy_Bag.png?v=1575222656",
    itemName: "Pet Food",
    itemPrice: 54324,
    color: Colors.white,
  ),
  SupplyItemModel(
    itemImage:
        "https://cdn.shopify.com/s/files/1/0086/0795/7054/files/cf-cat-banner-3_250x.jpg?v=1588483434",
    itemName: "Leashes",
    itemPrice: 2823,
    color: Colors.white,
  ),
  SupplyItemModel(
    itemImage:
        "https://cdn.shopify.com/s/files/1/0086/0795/7054/files/cf-cat-banner-2_250x.jpg?v=1588483433",
    itemName: "Clothes",
    itemPrice: 99722,
    color: Colors.white,
  ),
];

class SupplyItemProviderModel extends ChangeNotifier {
  int selectedItem = 0;
  void assignSelectedItem(int index) {
    selectedItem = index;
    notifyListeners();
  }
}
