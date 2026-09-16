// import 'package:flutter/material.dart';
// import '../models/flat_model.dart';
// import 'HomeItem.dart';

// class HorizontalSection extends StatelessWidget {
//   final String title;
//   final List<FlatModel> homes;
//   final Function(FlatModel) onAddFavorite;

//   const HorizontalSection({
//     super.key,
//     required this.title,
//     required this.homes,
//     required this.onAddFavorite,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Text(
//             title,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 230,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             itemCount: homes.length,
//             itemBuilder: (context, index) {
//               final flat = homes[index];
//               return Row(
//                 children: [
//                   HomeItem(flat: flat, onAddFavorite: onAddFavorite),
//                   const SizedBox(width: 12),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/flat_model.dart';
import 'HomeItem.dart';

class HorizontalSection extends StatelessWidget {
  final String title;
  final List<FlatModel> homes;

  const HorizontalSection({
    super.key,
    required this.title,
    required this.homes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: homes.length,
            itemBuilder: (context, index) {
              final flat = homes[index];
              return Row(
                children: [
                  HomeItem(flat: flat),
                  const SizedBox(width: 12),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
