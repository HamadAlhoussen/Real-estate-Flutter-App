import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearch extends SearchDelegate {
  final List suggestions = [
    "Damascus Apartment",
    "Latakia Sea View",
    "Cheap Flats",
    "Luxury Apartments",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(icon: const Icon(Icons.close), onPressed: () => query = ""),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => Center(
    child: Wrap(
      children: [
        Text(
          "76".tr,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        Text(
          " : $query",
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
      ],
    ),
  );

  @override
  Widget buildSuggestions(BuildContext context) {
    final filtered = suggestions
        .where((s) => s.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.search),
        title: Text(filtered[index]),
        onTap: () {
          query = filtered[index];
          showResults(context);
        },
      ),
    );
  }
}
