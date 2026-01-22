import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_managment/core/theme/theme.dart';
import 'package:test_managment/core/widgets/snackBar.dart';
import 'package:test_managment/screens/test/insert_test/testInfoForm2.dart';
import 'package:test_managment/screens/test/model/unitModel.dart';

import '../../../core/widgets/button.dart';
import '../../../core/widgets/space.dart';
import '../cubit/insertState.dart';
import '../cubit/insert_cubit.dart';

class InsertTest extends StatefulWidget {
  final UnitModel unit;

  const InsertTest({required this.unit, super.key});

  @override
  State<InsertTest> createState() => _InsertTestState();
}

class _InsertTestState extends State<InsertTest> {
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Test in ${widget.unit.unitName}"),
      ),
      body: ListView(
        children: [
          Space.height(height: 20.0),
          Center(
              child: EButton(
                  text: "Choose File",
                  onTap: () async {
                    context.read<InsertCubit>().excelPickAndRead();
                  },
                  context: context)),
          Space.height(height: 20),
          Column(
            children: [
              BlocConsumer<InsertCubit, InsertState>(builder: (_, state) {
                if (state is ExcelSuccess) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(border: BoxBorder.all()),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .88,
                                  height: 35,
                                  decoration:
                                      const BoxDecoration(color: ACCENT_COLOR),
                                  child: Center(
                                    child: Text(
                                      state.fileName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: appTheme.textTheme.headlineMedium,
                                    ),
                                  ),
                                ),
                                Space.height(height: 50),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Total Questions",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Space.height(height: 10),
                                        const Text(
                                          "No Ans Questions",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Space.height(height: 10),
                                        const Text(
                                          "Question No of no ans",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Space.height(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                                Space.width(width: 10),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .25,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(state.totalQuestions.toString()),
                                        Space.height(height: 10),
                                        Text(
                                          state.invalidAnswerIds.length
                                              .toString(),
                                          style: TextStyle(
                                              color: state.invalidAnswerIds
                                                      .isNotEmpty
                                                  ? Colors.red
                                                  : null),
                                        ),
                                        Space.height(height: 10),
                                        Text(
                                          state.invalidAnswerIds.length >= 0
                                              ? state.invalidAnswerIds
                                                  .toString()
                                              : "All Right",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Space.height(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        Space.height(height: 10),
                        state.invalidAnswerIds.isEmpty
                            ? TestInfoForm2(
                                testName: state.fileName,
                                questions: state.questions,
                                unit: widget.unit,
                              )
                            : const Text("Resolve Error First"),
                      ],
                    ),
                  );
                }

                return const Text("");
              }, listener: (_, state) {
                if (state is ExcelLoading) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ExcelError) {
                  AppSnackBar(Colors.red, msg: state.message, context: _);
                }
                if (state is ExcelSuccess) {
                  AppSnackBar(Colors.green,
                      msg: "file inserted Successfully", context: _);
                }
                if (state is UploadSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Test Uploded Successfully")));
                }
                if (state is UploadError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.msg)));
                }
              })
            ],
          ),
        ],
      ),
    );
  }
}
