import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_managment/screens/test/insert_test/questionModel.dart';
import 'package:test_managment/screens/test/insert_test/testModel.dart';

import '../../../core/widgets/space.dart';
import '../cubit/insert_cubit.dart';
import '../model/unitModel.dart';

class TestInfoForm2 extends StatefulWidget {
  final String testName;
  final List<QuestionModel> questions;
  final UnitModel unit;

  const TestInfoForm2(
      {super.key,
      required this.testName,
      required this.questions,
      required this.unit});

  @override
  State<TestInfoForm2> createState() => _TestInfoForm2State();
}

class _TestInfoForm2State extends State<TestInfoForm2> {
  TextEditingController testNameCtrl = TextEditingController();
  TextEditingController testDiscriptionCtrl = TextEditingController();
  TextEditingController testTimeCtrlHr = TextEditingController();
  TextEditingController testTimeCtrlMn = TextEditingController();
  TextEditingController totalMarksCtrl = TextEditingController();
  TextEditingController negativeMarksCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    testNameCtrl = TextEditingController(text: widget.testName);
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> testInfo = [];

  Map<String, dynamic>? submit() {
    if (_formKey.currentState!.validate()) {
      if (int.parse(testTimeCtrlHr.text.trim()) == 0 &&
          int.parse(testTimeCtrlMn.text.trim()) == 0) {
        testTimeCtrlHr = TextEditingController(text: "1");
      }
      if (double.parse(totalMarksCtrl.text.trim()) == 0 &&
          double.parse(negativeMarksCtrl.text.trim()) == 0) {
        totalMarksCtrl = TextEditingController(text: "1");
      }
      return {
        "testName": testNameCtrl.text.trim(),
        "testDescription": testDiscriptionCtrl.text.trim().isEmpty
            ? "description"
            : testDiscriptionCtrl.text.trim(),
        "testTimeHr": int.parse(testTimeCtrlHr.text.trim()),
        "testTimeMn": int.parse(testTimeCtrlMn.text.trim()),
        "marks": double.parse(totalMarksCtrl.text.trim()),
        "negativeMarks": double.parse(negativeMarksCtrl.text.trim()),
      };
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: testNameCtrl,
                    decoration: const InputDecoration(),
                    validator: (v) {
                      if (RegExp(r'^\d+$').hasMatch(v!.trim())) {
                        return "Only text allowed, numbers not allowed";
                      }
                      return null;
                    },
                  ),
                  Space.height(height: 10),
                  TextFormField(
                    controller: testDiscriptionCtrl,
                    decoration: const InputDecoration(
                      labelText: "Test Discription (Optional)",
                    ),
                    validator: (v) {
                      if (RegExp(r'^\d+$').hasMatch(v!.trim())) {
                        return "Only text allowed, numbers not allowed";
                      }
                      return null;
                    },
                  ),
                  Space.height(height: 10),
                  TextFormField(
                    controller: testTimeCtrlHr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Hours",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Required";
                      final h = int.tryParse(v);
                      if (h == null || h < 0 || h > 12) return "Invalid";
                      return null;
                    },
                  ),
                  Space.height(height: 10),
                  TextFormField(
                    controller: testTimeCtrlMn,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Minutes",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Required";
                      final h = int.tryParse(v);
                      if (h == null || h < 0 || h > 59) return "Invalid";
                      return null;
                    },
                  ),
                  Space.height(height: 10),
                  TextFormField(
                    controller: totalMarksCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Marks (single question)",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  Space.height(height: 10),
                  TextFormField(
                    controller: negativeMarksCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Negative Marks (single question)",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  Space.height(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic>? result = submit();

                        if (result != null) {
                          context.read<InsertCubit>().uploadTest(
                              TestModel(
                                testName: result['testName'],
                                testDescription: result['testDescription'],
                                timeHr: result['testTimeHr'],
                                timeMin: result['testTimeHr'],
                                marks: result['marks'],
                                negativeMarks: result['negativeMarks'],
                                unit_id: widget.unit.id,
                              ),
                              widget.questions);

                          // context.read<InsertCubit>().uploadTest(
                          //       testName: result['testName'],
                          //       timeHr: result['testTimeHr'],
                          //       timeMin: result['testTimeMn'],
                          //       negativeMarks: result['negativeMarks'],
                          //       marks: result['marks'],
                          //       questions: widget.questions,
                          //       testDescription: result['testDescription'],
                          //     );
                        } else {
                          print("Enter At Least One Value From time ");
                        }
                      },
                      child: const Text("Upload"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
