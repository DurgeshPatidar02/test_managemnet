
class TestModel {
  String testName;
  String testDescription;
  int timeHr;
  int timeMin;
  double negativeMarks;
  double marks;
  String unit_id;

  TestModel({
    required this.testName,
    required this.testDescription,
    required this.timeHr,
    required this.timeMin,
    required this.marks,
    required this.negativeMarks,
    required this.unit_id
  });

  Map<String, dynamic> toJson()=>{
    "testName" : testName,
    "testDescription" : testDescription,
    "timeHr" : timeHr,
    "timeMin" : timeMin,
    "negativeMarks" : negativeMarks,
    "marks" : marks,
    "unit_id" : unit_id,
  };
}