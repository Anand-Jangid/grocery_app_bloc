import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app_bloc/features/cart/ui/cart.dart';
import 'package:grocery_app_bloc/features/home/bloc/home_bloc.dart';
import 'package:grocery_app_bloc/features/home/ui/product_tile_widget.dart';
import 'package:grocery_app_bloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if (state is HomeProductsItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Item added to cart")));
        } else if (state is HomeProductsItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Item added to wish list")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Grocery App"),
                  backgroundColor: Colors.amberAccent,
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishlistButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_bag_outlined))
                  ],
                ),
                body: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                        productDataModel: successState.products[index],
                        homeBloc: homeBloc,
                      );
                    }));

          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text("Error")),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
