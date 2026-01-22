class TestModel {
  final String id;
  final String unitId;
  final String testName;
  final String? description;
  final double totalMarks;    // float
  final double negativeMarks; // float
  final int timeHr;
  final int timeMin;

  TestModel({
    required this.id,
    required this.unitId,
    required this.testName,
    this.description,
    required this.totalMarks,
    required this.negativeMarks,
    required this.timeHr,
    required this.timeMin,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'],
      unitId: json['unit_id'],
      testName: json['test_name'],
      description: json['description'],
      totalMarks: (json['total_marks'] as num).toDouble(),
      negativeMarks: (json['negative_marks'] as num).toDouble(),
      timeHr: json['time_hr'],
      timeMin: json['time_min'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit_id': unitId,
      'test_name': testName,
      'description': description,
      'total_marks': totalMarks,
      'negative_marks': negativeMarks,
      'time_hr': timeHr,
      'time_min': timeMin,
    };
  }
}
