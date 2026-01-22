class QuestionModel {
  final String id;
  final String testId;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String answer;          // 'A', 'B', 'C', 'D'
  final String? ansDescription;

  QuestionModel({
    required this.id,
    required this.testId,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.answer,
    this.ansDescription,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      testId: json['test_id'],
      question: json['question'],
      optionA: json['option_a'],
      optionB: json['option_b'],
      optionC: json['option_c'],
      optionD: json['option_d'],
      answer: json['answer'],
      ansDescription: json['ans_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'test_id': testId,
      'question': question,
      'option_a': optionA,
      'option_b': optionB,
      'option_c': optionC,
      'option_d': optionD,
      'answer': answer,
      'ans_description': ansDescription,
    };
  }
}
