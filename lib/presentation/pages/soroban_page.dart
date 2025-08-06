// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/soroban_controller.dart';
// import '../widgets/bead_widget.dart';

// class SorobanPage extends StatelessWidget {
//   final SorobanController controller = Get.put(SorobanController());

//   SorobanPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown.shade100,
//       appBar: AppBar(
//         title: const Text("Soroban Abacus"),
//         centerTitle: true,
//         backgroundColor: Colors.brown,
//       ),
//       body: Obx(() => Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 const Text("Tap on beads to toggle"),
//                 const SizedBox(height: 20),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: List.generate(controller.columns, (col) {
//                         final colBeads = controller.beads
//                             .where((b) => b.column == col)
//                             .toList();

//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: colBeads.map((bead) {
//                             return BeadWidget(
//                               bead: bead,
//                               onTap: () => controller.toggleBead(bead),
//                             );
//                           }).toList(),
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/soroban_controller.dart';
// import '../widgets/bead_widget.dart';

// /// Main Soroban page that shows all beads and total value
// class SorobanPage extends StatelessWidget {
//   /// Inject controller using GetX
//   final SorobanController controller = Get.put(SorobanController());

//   SorobanPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.brown.shade400,
//         centerTitle: true,
//         title: const Text("Japanese Soroban",
//             style: TextStyle(color: Colors.white)),
//         actions: [
//           IconButton(
//             tooltip: "Reset Soroban",
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             onPressed: () => controller.resetBeads(),
//           ),
//         ],
//       ),
//       body: Obx(() => Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // Display total Soroban value
//                 Text(
//                   "Total Value: ${controller.calculateSorobanValue()}",
//                   style: const TextStyle(
//                       fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 20),

//                 // Scrollable Soroban columns
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: List.generate(controller.columns, (col) {
//                         // Get all beads in this column
//                         final columnBeads = controller.beads
//                             .where((b) => b.column == col)
//                             .toList()
//                           ..sort((a, b) => a.row
//                               .compareTo(b.row)); // ensure top-to-bottom order

//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: columnBeads.map((bead) {
//                             return BeadWidget(
//                               bead: bead,
//                               onTap: () => controller.toggleBead(bead),
//                             );
//                           }).toList(),
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/soroban_controller.dart';
import '../widgets/bead_widget.dart';

/// Main Soroban UI page with value display and responsive layout
class SorobanPage extends StatelessWidget {
  final SorobanController controller = Get.put(SorobanController());

  SorobanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade400,
        centerTitle: true,
        title: const Text(
          "Japanese Soroban",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: "Undo",
            icon: const Icon(Icons.undo, color: Colors.white),
            onPressed: () => controller.undoLast(),
          ),
          IconButton(
            tooltip: "Reset",
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => controller.resetBeads(),
          ),
        ],
      ),
      body: Obx(() {
        final value = controller.calculateSorobanValue();

        return LayoutBuilder(builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Value display card
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.orange.shade50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calculate_rounded,
                            size: 28, color: Colors.brown),
                        const SizedBox(width: 12),
                        Text(
                          "Total: $value",
                          style: TextStyle(
                            fontSize: isWide ? 28 : 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Scrollable Soroban columns
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(controller.columns, (col) {
                          final columnBeads = controller.beads
                              .where((b) => b.column == col)
                              .toList()
                            ..sort((a, b) => a.row.compareTo(b.row));

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: columnBeads.map((bead) {
                              return BeadWidget(
                                bead: bead,
                                onTap: () => controller.toggleBead(bead),
                              );
                            }).toList(),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      }),
    );
  }
}
