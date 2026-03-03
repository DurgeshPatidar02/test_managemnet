import 'dart:ffi';

class TestModel {
  final String? id;
  String testName;
  String testDescription;
  int timeHr;
  int timeMin;
  double negativeMarks;
  double marks;
  String unit_id;

  TestModel(
      {this.id,
      required this.testName,
      required this.testDescription,
      required this.timeHr,
      required this.timeMin,
      required this.marks,
      required this.negativeMarks,
      required this.unit_id});

  Map<String, dynamic> toJson() => {
        "testName": testName,
        "testDescription": testDescription,
        "timeHr": timeHr,
        "timeMin": timeMin,
        "negativeMarks": negativeMarks,
        "marks": marks,
        "unit_id": unit_id,
      };

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'],
      testName: json['testName'] as String,
      testDescription: json['testDescription'] as String,
      timeHr: json['timeHr']!,
      timeMin: json['timeMin'],
      negativeMarks:(json['negativeMarks'] as num).toDouble(),
      marks: (json['marks'] as num).toDouble(),
      unit_id: json['unit_id'] as String,
    );
  }
}
