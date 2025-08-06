import '../../domain/entities/bead_entity.dart';

class BeadModel extends BeadEntity {
  BeadModel({
    required super.row,
    required super.column,
    required super.isUpper,
    required super.isActive,
  });

  factory BeadModel.fromEntity(BeadEntity entity) => BeadModel(
        row: entity.row,
        column: entity.column,
        isUpper: entity.isUpper,
        isActive: entity.isActive,
      );
}
