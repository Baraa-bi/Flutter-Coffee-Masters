import 'package:coffee_masters/models/product.dart';

class ItemInCart {
  Product product;
  int quantity;

  ItemInCart({
    required this.product,
    required this.quantity,
  });
}
