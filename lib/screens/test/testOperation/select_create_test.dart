import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_managment/core/widgets/testCard.dart';
import 'package:test_managment/router/app_routes.dart';
import 'package:test_managment/screens/test/cubit/test/tab1/testTab1State.dart';
import 'package:test_managment/screens/test/cubit/test/tab2/testTab2Cubit.dart';
import 'package:test_managment/screens/test/model/unitModel.dart';

import '../../../core/widgets/UnitCard.dart';
import '../../../core/widgets/space.dart';
import '../cubit/fileInsertCubit.dart';
import '../cubit/test/tab1/testTab1Cubit.dart';
import '../cubit/test/tab2/testTab2State.dart';
import '../cubit/unit/Tab1Cubit.dart';
import '../cubit/unit/Tab1State.dart';
import '../model/testModel.dart';

class SelectCreateTest extends StatefulWidget {
  UnitModel unit;

  SelectCreateTest({required this.unit, super.key});

  @override
  State<SelectCreateTest> createState() => _SelectCreateTestState();
}

class _SelectCreateTestState extends State<SelectCreateTest>
    with SingleTickerProviderStateMixin {
  late TabController _testTabController;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _testName = TextEditingController();

// tab 2
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
  void initState() {
    _testTabController = TabController(length: 2, vsync: this);
    context.read<TestTab1Cubit>().loadTest(unit: widget.unit);

    super.initState();
  }

  @override
  void dispose() {
    testNameCtrl.dispose();
    testDiscriptionCtrl.dispose();
    testTimeCtrlHr.dispose();
    testTimeCtrlMn.dispose();
    totalMarksCtrl.dispose();
    negativeMarksCtrl.dispose();
    _testTabController.dispose();
    _testName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unit.unitName),
        bottom: TabBar(
          controller: _testTabController,
          tabs: const [
            Tab(text: "Test List"),
            Tab(text: "Create Test"),
          ],
        ),
      ),
      body: TabBarView(controller: _testTabController, children: [
        // ----------------- Tab 1: Show Test
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<TestTab1Cubit, TestTab1State>(
              builder: (context, state) {
            if (state is TestTab1Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TestTab1Success) {
              return ListView.builder(
                  itemCount: state.tests.length,
                  itemBuilder: (context, index) {
                    final test = state.tests[index];
                    return TestCard(
                      testName: test.testName,
                      testDescription: test.testDescription == "description"
                          ? "-"
                          : test.testDescription,
                      onTap: () {
                        context.pushNamed(AppRoutes.questionsCrudServices, extra: {'test' : test, 'unit' : widget.unit});
                      },
                      onDelete: (){
                        context.read<TestTab1Cubit>().deleteTest(test.id.toString());
                        context.read<TestTab1Cubit>().loadTest(unit: widget.unit);
                      },
                    );
                  });
            }
            if (state is TestTab1NoTestFound) {
              return const Center(
                child: Text("No Test Found"),
              );
            }
            return const Center(
              child: Text("Somthing Went Wrong"),
            );
          }, listener: (context, state) {
            if (state is TestTab1Error) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Error In Fetching'),
                backgroundColor: Colors.red,
              ));
            }
            if (state is TestTab1DeleteSuccess) {
              context.read<TestTab1Cubit>().loadTest(unit: widget.unit);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Test Delete Successfully'),
                backgroundColor: Colors.green,
              ));
            }
          }),
        ),

        // ---------------- Tab 2: Create Unit ----------------
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: BlocConsumer<TestTab2Cubit, TestTab2State>(
                  builder: (context, state) {
                if (state is TestTab2Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            validator: (v) {
                              if (v == null || v.isEmpty) return "Required";
                              final h = int.tryParse(v);
                              if (h == null || h < 0 || h > 12)
                                return "Invalid";
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            validator: (v) {
                              if (v == null || v.isEmpty) return "Required";
                              final h = int.tryParse(v);
                              if (h == null || h < 0 || h > 59)
                                return "Invalid";
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
                                  context
                                      .read<TestTab2Cubit>()
                                      .createTest(TestModel(
                                        testName: result['testName'],
                                        testDescription:
                                            result['testDescription'],
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
                if (state is TestTab2Success) {
                  context.read<TestTab1Cubit>().loadTest(unit: widget.unit);
                  _testTabController.animateTo(0);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Test Created Successfully'),
                    backgroundColor: Colors.green,
                  ));
                }

                if (state is TestTab2Error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.msg),
                    backgroundColor: Colors.red,
                  ));
                }
              }),
            )),
      ]),
    );
  }
}
