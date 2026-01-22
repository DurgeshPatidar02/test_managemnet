class UnitModel {
  final String id;
  final String unitName;

  UnitModel({
    required this.id,
    required this.unitName,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as String,
      unitName: json['unit_name']  as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit_name': unitName,
    };
  }
}
