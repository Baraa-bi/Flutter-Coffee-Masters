import 'package:coffee_masters/manager/data_manager.dart';
import 'package:coffee_masters/models/cart.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  final DataManager dataManager;
  const OrdersPage({Key? key, required this.dataManager}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataManager.cart.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("Your order is empty"),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.dataManager.cart.length,
                itemBuilder: (context, index) {
                  var item = widget.dataManager.cart[index];
                  return OrderItem(
                      item: item,
                      onRemove: (product) {
                        setState(() {
                          widget.dataManager.removeFromCart(product);
                        });
                      });
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Total: \$${widget.dataManager.cartTotal().toStringAsFixed(2)}"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade600),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => const OrderAlert());
                      setState(() {
                        // we update the cart within setState so the current widget will get re-rendered
                        widget.dataManager.clearCart();
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Send Order",
                        style: TextStyle(fontSize: 25),
                      ),
                    )),
              ),
            )
          ],
        ),
      );
    }
  }
}

class OrderItem extends StatelessWidget {
  final ItemInCart item;
  final Function onRemove;
  const OrderItem({Key? key, required this.item, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("${item.quantity}x"),
                )),
            Expanded(
                flex: 6,
                child: Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(
              flex: 2,
              child: Text(
                  "\$${(item.product.price * item.quantity).toStringAsFixed(2)}"),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      onRemove(item.product);
                    },
                    icon: const Icon(Icons.delete)))
          ],
        ),
      ),
    );
  }
}

class OrderAlert extends StatelessWidget {
  const OrderAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Order Placed Successfully"),
      content: const Text("Your order is being prepared. Thanks!"),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'))
      ],
    );
  }
}
