import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_managment/screens/test/cubit/fileInsertState.dart';
import 'package:test_managment/screens/test/cubit/test/tab2/testTab2Cubit.dart';
import 'package:test_managment/screens/test/model/testModel.dart';
import 'package:test_managment/screens/test/model/unitModel.dart';

import '../../../core/widgets/space.dart';
import '../cubit/fileInsertCubit.dart';

class CreateTest extends StatefulWidget {
  UnitModel unit;

  CreateTest({required this.unit, super.key});

  @override
  State<CreateTest> createState() => _CreateTestState();
}

class _CreateTestState extends State<CreateTest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController testNameCtrl = TextEditingController();
  TextEditingController testDiscriptionCtrl = TextEditingController();
  TextEditingController testTimeCtrlHr = TextEditingController();
  TextEditingController testTimeCtrlMn = TextEditingController();
  TextEditingController totalMarksCtrl = TextEditingController();
  TextEditingController negativeMarksCtrl = TextEditingController();

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
  void dispose() {
    testNameCtrl.dispose();
    testDiscriptionCtrl.dispose();
    testTimeCtrlHr.dispose();
    testTimeCtrlMn.dispose();
    totalMarksCtrl.dispose();
    negativeMarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create test"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child:
              BlocConsumer<FileInsertCubit, InsertState>(builder: (context, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: testNameCtrl,
                        decoration: const InputDecoration(
                          labelText: "Test Name",
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Required";
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
                              context.read<TestTab2Cubit>().createTest(TestModel(
                                    testName: result['testName'],
                                    testDescription: result['testDescription'],
                                    timeHr: result['testTimeHr'],
                                    timeMin: result['testTimeHr'],
                                    marks: result['marks'],
                                    negativeMarks: result['negativeMarks'],
                                    unit_id: widget.unit.id,
                                  ));
                            } else {
                              print("Enter At Least One Value From time ");
                            }
                          },
                          child: const Text("Upload"))
                    ],
                  ),
                ),
              ),
            );
          }, listener: (context, state) {
                if(state is CreateTestError){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error in create test${state.message}"), backgroundColor: Colors.red,));
                }if(state is CreateTestExistError){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${state.message}"), backgroundColor: Colors.red,));
                }
            if (state is CreateTestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${state.testName} Create Successfully"), backgroundColor: Colors.green,));
              context.pushNamed('insert_test', extra: state.testName);
            }
          }),
        ));
  }
}
