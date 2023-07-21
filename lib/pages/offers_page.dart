import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(5.0),
      children: const [
        Offer(
          title: "Offer Title",
          description: "Im the offer description",
        ),
        Offer(
          title: "Offer Title",
          description: "Im the offer description",
        ),
        Offer(
          title: "Offer Title",
          description: "Im the offer description",
        ),
        Offer(
          title: "Offer Title",
          description: "Im the offer description",
        ),
        Offer(
          title: "Offer Title",
          description: "Im the offer description",
        )
      ],
    );
  }
}

class Offer extends StatelessWidget {
  final String title;
  final String description;

  const Offer({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 180,
        child: Card(
          color: Colors.amber.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                15), // Set the desired border radius for the card
          ),
          elevation: 5,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: .7,
                image: AssetImage("images/background.png"),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
