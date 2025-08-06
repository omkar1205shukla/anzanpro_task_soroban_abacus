import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/soroban_controller.dart';
import '../widgets/bead_widget.dart';

class SorobanPage extends StatelessWidget {
  final SorobanController controller = Get.put(SorobanController());

  SorobanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    final bool isTablet = screenWidth > 600;
    final double beadSize = isTablet ? 48 : 36;
    final double fontSize = isTablet ? 24 : 18;
    final double titleSize = isTablet ? 28 : 22;
    final double padding = isTablet ? 24 : 16;
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade400,
        centerTitle: true,
        title: Text(
          "Japanese Soroban",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: titleSize,
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Undo",
            icon: Icon(Icons.undo, color: Colors.white, size: fontSize),
            onPressed: () => controller.undoLast(),
          ),
          IconButton(
            tooltip: "Reset",
            icon: Icon(Icons.refresh, color: Colors.white, size: fontSize),
            onPressed: () => controller.resetBeads(),
          ),
        ],
      ),
      body: Obx(() {
        final value = controller.calculateSorobanValue();

        return LayoutBuilder(builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                // Value display card
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.orange.shade50,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: padding / 2,
                      horizontal: padding,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calculate_rounded,
                            size: 28, color: Colors.brown),
                        const SizedBox(width: 12),
                        Text(
                          "Total: $value",
                          style: TextStyle(
                            fontSize: fontSize + 4,
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

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: isTablet ? 10 : 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: columnBeads.map((bead) {
                                return BeadWidget(
                                  bead: bead,
                                  onTap: () => controller.toggleBead(bead),
                                  size: beadSize,
                                );
                              }).toList(),
                            ),
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
