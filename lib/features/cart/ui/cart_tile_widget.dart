import "package:flutter/material.dart";
import "package:grocery_app_bloc/features/cart/bloc/cart_bloc.dart";
import "package:grocery_app_bloc/features/home/models/home_product_data_model.dart";

class CartTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  const CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Container(
          height: 200,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(productDataModel.imageUrl))),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          productDataModel.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$ ${productDataModel.price.toString()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      // cartBloc.add(HomeProductWishlistButtonClickedEvent(
                      //     clickedProduct: productDataModel));
                    },
                    icon: const Icon(Icons.favorite)),
                IconButton(
                    onPressed: () {
                      cartBloc.add(CartRemovedEvent(clickedProduct: productDataModel));
                    },
                    icon: const Icon(Icons.shopping_bag))
              ],
            )
          ],
        )
      ]),
    );
  }
}
