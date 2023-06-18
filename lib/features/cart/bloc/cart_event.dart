part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemovedEvent extends CartEvent {
  final ProductDataModel clickedProduct;

  CartRemovedEvent({required this.clickedProduct});
}
