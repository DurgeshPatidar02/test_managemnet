class QuestionModel {
  final int no;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String disc;
  final String? ans;

  QuestionModel({
    required this.no,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.disc,
    required this.ans,

  });

  Map<String, dynamic> toJson() =>
      {
        "no": no,
        "question": question,
        "option_A": optionA,
        "option_B": optionB,
        "option_C": optionC,
        "option_D": optionD,
        "disc": disc,
        "ans": ans,

      };

  factory QuestionModel.fromJson(Map<String, dynamic> json){
    return QuestionModel(no: json['no'],
        question: json['question'],
        optionA: json['optionA'],
        optionB: json["optionB"],
        optionC: json['optionC'],
        optionD: json['optionD'],
        disc: json['disc'],
        ans: json['ans'],);
  }
}
