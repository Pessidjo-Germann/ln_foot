// import 'package:flutter/material.dart';

// enum OrderStatusd { ongoing, completed, review }

// class EmptyOrdersView extends StatelessWidget {
//   final OrderStatusd status;

//   const EmptyOrdersView({super.key, required this.status});

//   String _getTitle() {
//     switch (status) {
//       case OrderStatusd.ongoing:
//         return "Aucune commande en cours !";
//       case OrderStatusd.completed:
//         return "Aucune commande complétée.";
//       case OrderStatusd.review:
//         return "Aucune commande à évaluer.";
//     }
//   }

//   String _getSubtitle() {
//     switch (status) {
//       case OrderStatusd.ongoing:
//         return "en cours";
//       case OrderStatusd.completed:
//         return "complétée";
//       case OrderStatusd.review:
//         return "à évaluer";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//    // final colorScheme = Theme.of(context).colorScheme;

//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0), // Add some padding
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.receipt_long_outlined, // Use outlined icon for a lighter look
//               size: 80,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 24), // Increased spacing
//             Text(
//               _getTitle(),
//               style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 12), // Increased spacing
//             Text(
//               "Vous n'avez aucune commande\n${_getSubtitle()} pour le moment.",
//               textAlign: TextAlign.center,
//               style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
//             ),
//             // Optionally, add a button to browse products or similar action
//             // const SizedBox(height: 32),
//             // ElevatedButton(
//             //   onPressed: () { /* Navigate to home or products screen */ },
//             //   child: const Text('Découvrir nos produits'),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }
