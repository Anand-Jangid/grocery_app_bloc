import 'dart:async';
import 'package:grocery_app_bloc/data/cart_items.dart';
import 'package:grocery_app_bloc/data/grocery_data.dart';
import 'package:grocery_app_bloc/data/wishlist_item.dart';
// import 'package:grocery_app_bloc/features/wishlist/ui/wishlist.dart';

import '../models/home_product_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    //home initial event handler
    on<HomeInitialEvent>(homeInitialEvent);

    //navigate to wishlist event handler
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);

    //navigate to cart event handler
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);

    //wishlist clicked event handler
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);

    //cart clicked event handler
    on<HomeProductsCartButtonClickedEvent>(homeProductsCartButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    await Future.delayed(const Duration(seconds: 2));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((product) => ProductDataModel(
                id: product['id'],
                name: product['name'],
                price: product['price'],
                imageUrl: product['image']))
            .toList()));
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("cart page clicked");
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductsItemWishlistedActionState());
  }

  FutureOr<void> homeProductsCartButtonClickedEvent(
      HomeProductsCartButtonClickedEvent event, Emitter<HomeState> emit) {
    cartItems.add(event.clickedProduct);
    emit(HomeProductsItemCartedActionState());
  }
}
