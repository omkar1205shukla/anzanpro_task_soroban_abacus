import 'dart:math';

import 'package:get/get.dart';

import '../../domain/entities/bead_entity.dart';

class SorobanController extends GetxController {
  RxList<BeadEntity> beads = <BeadEntity>[].obs;

  final int columns = 13;

  final int lowerBeads = 4;

  final List<List<BeadEntity>> _historyStack = [];

  int calculateSorobanValue() {
    int total = 0;

    for (int col = 0; col < columns; col++) {
      int colValue = 0;

      final upperBead = beads.firstWhere((b) => b.column == col && b.isUpper);

      final lower = beads.where((b) => b.column == col && !b.isUpper);

      if (upperBead.isActive) colValue += 5;

      colValue += lower.where((b) => b.isActive).length;

      total += colValue * pow(10, columns - col - 1).toInt();
    }

    return total;
  }

  @override
  void onInit() {
    super.onInit();
    _initBeads();
  }

  void resetBeads() {
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

  void toggleBead(BeadEntity bead) {
    _historyStack.add(List<BeadEntity>.from(beads));
    final index = beads.indexWhere((b) =>
        b.column == bead.column &&
        b.row == bead.row &&
        b.isUpper == bead.isUpper);

    beads[index] = bead.toggle();
  }

  void undoLast() {
    if (_historyStack.isNotEmpty) {
      beads.value = _historyStack.removeLast();
    }
  }

  void _initBeads() {
    final temp = <BeadEntity>[];

    for (int col = 0; col < columns; col++) {
      // Upper bead (worth 5)
      temp.add(BeadEntity(row: 0, column: col, isUpper: true, isActive: false));

      for (int r = 1; r <= lowerBeads; r++) {
        temp.add(
            BeadEntity(row: r, column: col, isUpper: false, isActive: false));
      }
    }

    beads.value = temp;
  }
}
