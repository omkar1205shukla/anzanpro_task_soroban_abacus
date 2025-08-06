class BeadEntity {
  final int row;
  final int column;
  final bool isUpper;
  final bool isActive;

  const BeadEntity({
    required this.row,
    required this.column,
    required this.isUpper,
    required this.isActive,
  });

  BeadEntity toggle() => BeadEntity(
        row: row,
        column: column,
        isUpper: isUpper,
        isActive: !isActive,
      );
}
