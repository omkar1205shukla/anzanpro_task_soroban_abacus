import 'dart:math';

import 'package:get/get.dart';

import '../../domain/entities/bead_entity.dart';

/// Controller that handles the state and logic of the Soroban abacus
class SorobanController extends GetxController {
  /// Reactive list of all beads in the Soroban
  RxList<BeadEntity> beads = <BeadEntity>[].obs;

  /// Number of columns in Soroban (typical Japanese Soroban has 13 columns)
  final int columns = 13;

  /// Number of lower beads per column (4 in Soroban)
  final int lowerBeads = 4;

  // 🔄 Stack to hold previous states for undo functionality
  final List<List<BeadEntity>> _historyStack = [];

  /// Calculate total value based on bead states
  int calculateSorobanValue() {
    int total = 0;

    // For each column (right to left → increasing place values)
    for (int col = 0; col < columns; col++) {
      int colValue = 0;

      // Get upper bead in this column
      final upperBead = beads.firstWhere((b) => b.column == col && b.isUpper);

      // Get lower beads in this column
      final lower = beads.where((b) => b.column == col && !b.isUpper);

      // Upper bead = 5 if active
      if (upperBead.isActive) colValue += 5;

      // Lower beads = 1 each if active
      colValue += lower.where((b) => b.isActive).length;

      // Apply place value (right to left = increasing powers of 10)
      total += colValue * pow(10, columns - col - 1).toInt();
    }

    return total;
  }

  @override
  void onInit() {
    super.onInit();
    _initBeads(); // Initialize the beads on controller load
  }

  /// Reset all beads to inactive (default) state
  void resetBeads() {
    // 🧹 Clear undo history
    _historyStack.clear();
    beads.value = beads
        .map((b) => BeadEntity(
              row: b.row,
              column: b.column,
              isUpper: b.isUpper,
              isActive: false,
            ))
        .toList();
  }

  /// Toggle a bead's active state
  void toggleBead(BeadEntity bead) {
    // 🧠 Save current state to undo history
    _historyStack.add(List<BeadEntity>.from(beads));
    final index = beads.indexWhere((b) =>
        b.column == bead.column &&
        b.row == bead.row &&
        b.isUpper == bead.isUpper);

    // Flip the active state
    beads[index] = bead.toggle();
  }

  void undoLast() {
    if (_historyStack.isNotEmpty) {
// ⏪ Restore last state
      beads.value = _historyStack.removeLast();
    }
  }

  /// Initialize all beads with their default states
  void _initBeads() {
    final temp = <BeadEntity>[];

    // For each column, add 1 upper bead and 4 lower beads
    for (int col = 0; col < columns; col++) {
      // Upper bead (worth 5)
      temp.add(BeadEntity(row: 0, column: col, isUpper: true, isActive: false));

      // Lower beads (worth 1 each)
      for (int r = 1; r <= lowerBeads; r++) {
        temp.add(
            BeadEntity(row: r, column: col, isUpper: false, isActive: false));
      }
    }

    beads.value = temp;
  }
}
