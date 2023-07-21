import 'package:coffee_masters/models/product.dart';
import 'package:coffee_masters/manager/data_manager.dart';
import 'package:coffee_masters/models/category.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;

  const MenuPage({super.key, required this.dataManager});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Category>>(
        future: dataManager.getMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // EACH CATEGORY STARTS HERE
                  var category = snapshot.data![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, bottom: 8.0, left: 8.0),
                        child: Text(
                          category.name,
                          style: TextStyle(color: Colors.brown.shade400),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: category.products.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                            product: category.products[index],
                            onAdd: (p) => dataManager.addToCart(p),
                          );
                        },
                      )
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  final Function onAdd;

  const ProductItem({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              10), // Set the desired border radius for the card
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "\$${product.price}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onAdd(product);
                      },
                      child: const Text("Add"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
