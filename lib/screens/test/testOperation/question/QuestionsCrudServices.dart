
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:test_managment/screens/test/cubit/bottomNavBar/BNBCubit.dart';
import 'package:test_managment/screens/test/cubit/bottomNavBar/BNBState.dart';
import 'package:test_managment/screens/test/model/unitModel.dart';
import 'package:test_managment/screens/test/testOperation/question/services/questionsTable/questionsHtml.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/snackBar.dart';
import '../../../../core/widgets/space.dart';
import '../../cubit/fileInsertCubit.dart';
import '../../cubit/fileInsertState.dart';
import '../../cubit/question/addQuestionCubit.dart';
import '../../cubit/question/addQuestionState.dart';
import '../../cubit/question/cmsCubit/cmsFileCubit.dart';
import '../../cubit/question/cmsCubit/cmsFileState.dart';
import '../../model/questionModel.dart';
import '../../model/testModel.dart';
import 'services/cmsServices/cmsWithWord.dart';

class QuestionsCrudServices extends StatefulWidget {
  final TestModel test;
  final UnitModel unit;

  const QuestionsCrudServices({super.key, required this.test, required this.unit});

  @override
  State<QuestionsCrudServices> createState() => _QuestionsCrudServicesState();
}

class _QuestionsCrudServicesState extends State<QuestionsCrudServices> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<BNBCubit>().checkBNB(index: 0);
    // context.read<CmsFileCubit>().getQuestions(test: widget.test);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BNBCubit, BNBState>(
      builder: (_, state) {
        if (state is BNBIndex) {
          if (state.index == 1) {
            context.read<FileInsertCubit>().zero();
            late List<QuestionModel> submitQuestion;
            return Scaffold(
                appBar: AppBar(
                  title: Text("${widget.unit.unitName} - ${widget.test.testName}"),
                ),
                body: ListView(
                  children: [
                    Space.height(height: 20.0),
                    Center(
                        child: EButton(
                            text: "Choose File",
                            onTap: () async {
                              context
                                  .read<FileInsertCubit>()
                                  .excelPickAndRead(test_id: widget.test.id);
                            },
                            context: context)),
                    Space.height(height: 20),
                    Column(
                      children: [
                        BlocConsumer<FileInsertCubit, InsertState>(
                            builder: (_, state) {
                              if (state is ExcelLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is ExcelSuccess) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width * .9,
                                        decoration:
                                        BoxDecoration(border: BoxBorder.all()),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    .88,
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                    color: ACCENT_COLOR),
                                                child: Center(
                                                  child: Text(
                                                    state.fileName,
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: appTheme
                                                        .textTheme
                                                        .headlineMedium,
                                                  ),
                                                ),
                                              ),
                                              Space.height(height: 50),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    .6,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 5, right: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "Total Questions",
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                      Space.height(height: 10),
                                                      const Text(
                                                        "No Ans Questions",
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                      Space.height(height: 10),
                                                      const Text(
                                                        "Question No of no ans",
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                      Space.height(height: 10),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Space.width(width: 10),
                                              SizedBox(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    .25,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      right: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      Text(state.totalQuestions
                                                          .toString()),
                                                      Space.height(height: 10),
                                                      Text(
                                                        state
                                                            .invalidAnswerIds
                                                            .length
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: state
                                                                .invalidAnswerIds
                                                                .isNotEmpty
                                                                ? Colors.red
                                                                : null),
                                                      ),
                                                      Space.height(height: 10),
                                                      Text(
                                                        state.invalidAnswerIds
                                                            .length >=
                                                            0
                                                            ? state
                                                            .invalidAnswerIds
                                                            .toString()
                                                            : "All Right",
                                                        maxLines: 3,
                                                        overflow:
                                                        TextOverflow.ellipsis,
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
                                          ? EButton(
                                        text: "Add Questions",
                                        onTap: () {
                                          context
                                              .read<QuestionCubit>()
                                              .addQuestions(submitQuestion);
                                        },
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
                            AppSnackBar(Colors.red,
                                msg: state.message, context: _);
                          }
                          if (state is ExcelSuccess) {
                            submitQuestion = state.questions;
                            AppSnackBar(Colors.green,
                                msg: "file inserted Successfully", context: _);
                          }
                          if (state is UploadSuccess) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Test Uploaded Successfully"),
                              duration: Duration(seconds: 2),
                            ));
                          }
                          if (state is UploadError) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.msg),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        }),
                        BlocConsumer<QuestionCubit, QuestionsState>(
                            builder: (_, state) {
                              if (state is AddQuestionLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Text("");
                            }, listener: (_, state) {
                          if (state is AddQuestionSuccess) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Questions Added in database"),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ));
                            context.read<FileInsertCubit>().zero();
                          }
                          if (state is AddQuestionError) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.msg),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }),
                        // BlocListener<QuestionCubit, QuestionsState>(
                        //   listener: (context, state) {
                        //
                        //   },
                        //   child: const Center(
                        //     child: Text(""),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (index) {
                    if (index == 0) {
                      context.read<BNBCubit>().checkBNB(index: 0);
                    }
                    // if (index == 1) {
                    //   context.read<BNBCubit>().checkBNB(index: 1);
                    // }
                    if (index == 2) {
                      context.read<BNBCubit>().checkBNB(index: 2);
                    }
                    if (index == 3) {
                      context.read<BNBCubit>().checkBNB(index: 3);
                    }
                  },
                  currentIndex: state.index,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list_alt_rounded), label: "Questions"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add), label: "Add"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.delete_outline), label: "Delete"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.table_chart_outlined), label: "CMS"),
                  ],
                ));
          }
          if (state.index == 2) {
            context.read<CmsFileCubit>().zero();
            context.read<CmsFileCubit>().getQuestions(test: widget.test);
            return Scaffold(
              appBar: AppBar(
                title: Text("${widget.unit.unitName} - ${widget.test.testName}"),
              ),
              body: BlocConsumer<CmsFileCubit, CmsState>(
                  builder: (_, state) {
                    if(state is CMSNoQuestionFound){
                      return const Center(child: Text("No Question Found "),);
                    }
                    if (state is CmsLoading) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if (state is CMSDeleteError) {
                      return const Center(
                        child: Text("Error Occurred"),
                      );
                    }
                    if (state is CMSDeleteSuccess) {
                      return const Center(
                        child: Text("All Questions Deleted"),
                      );
                    }
                    return Center(
                        child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CmsFileCubit>()
                                  .deleteQuestions(test: widget.test);
                            },
                            child: const Text("Delete All Questions")));
                  },
                  listener: (_, state) {

                    if (state is CMSDeleteError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.msg),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),));
                    }
                    if (state is CMSDeleteSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Deleted Successfully "),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),));
                    }
                  }),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  if (index == 0) {
                    context.read<BNBCubit>().checkBNB(index: 0);
                  }
                  if (index == 1) {
                    context.read<BNBCubit>().checkBNB(index: 1);
                  }
                  // if (index == 2) {
                  //   context.read<BNBCubit>().checkBNB(index: 2);
                  // }
                  if (index == 3) {
                    context.read<BNBCubit>().checkBNB(index: 3);
                  }
                },
                currentIndex: state.index,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list_alt_rounded), label: "Questions"),
                  BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.delete_outline), label: "Delete"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.table_chart_outlined), label: "CMS"),
                ],
              ),
            );
          }
          if (state.index == 3) {
            context.read<CmsFileCubit>().getQuestions(test: widget.test);
            return Scaffold(
                appBar: AppBar(
                  title: Text("${widget.unit.unitName} - ${widget.test.testName}"),
                ),
                body: BlocConsumer<CmsFileCubit, CmsState>(
                    builder: (context, state) {
                      if (state is CmsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is CMSNoQuestionFound) {
                        return const Center(
                          child: Text("No Question Found"),
                        );
                      }
                      if (state is CmsSuccess) {
                        String htmlData = generateHtmlContent(data: state.data);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Space.height(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    saveAndShareHtmlFile(
                                      htmlContent: htmlData,
                                      testName: widget.test.testName,
                                      unitName: widget.unit.unitName
                                    );
                                  },
                                  child: Text("Generate CMS Word File"),
                                ),
                                Space.height(height: 20),
                                HtmlWidget(
                                  htmlData,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Text("data");
                    },
                    listener: (context, state) {}),
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (index) {
                    if (index == 0) {
                      context.read<BNBCubit>().checkBNB(index: 0);
                    }
                    if (index == 1) {
                      context.read<BNBCubit>().checkBNB(index: 1);
                    }
                    if (index == 2) {
                      context.read<BNBCubit>().checkBNB(index: 2);
                    }
                    // if (index == 3) {
                    //   context.read<BNBCubit>().checkBNB(index: 3);
                    // }
                  },
                  currentIndex: state.index,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list_alt_rounded), label: "Questions"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add), label: "Add"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.delete_outline), label: "Delete"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.table_chart_outlined), label: "CMS"),
                  ],
                ));
          }
        }
        context.read<CmsFileCubit>().getQuestions(test: widget.test);
        return Scaffold(
            appBar: AppBar(
              title: Text("${widget.unit.unitName} - ${widget.test.testName}"),
            ),
            body: BlocConsumer<CmsFileCubit, CmsState>(
                builder: (context, state) {
                  if (state is CmsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CmsSuccess) {
                    String htmlData =
                    generateQuestionsHtmlContent(data: state.data);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Space.height(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                saveAndShareQuestionsHtmlFile(
                                  htmlContent: htmlData,
                                  testName: widget.test.testName,
                                );
                              },
                              child: const Text("Generate Word File"),
                            ),
                            Space.height(height: 20),
                            HtmlWidget(
                              htmlData,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is CMSNoQuestionFound) {
                    return const Center(
                      child: Text("No Question Found"),
                    );
                  }

                  return const Center(
                    child: Text("Something went wrong"),
                  );
                },
                listener: (context, state) {}),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                // if (index == 0) {
                //   context.read<BNBCubit>().checkBNB(index: 1);
                // }
                if (index == 1) {
                  context.read<BNBCubit>().checkBNB(index: 1);
                }
                if (index == 2) {
                  context.read<BNBCubit>().checkBNB(index: 2);
                }
                if (index == 3) {
                  context.read<BNBCubit>().checkBNB(index: 3);
                }
              },
              currentIndex: 0,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt_rounded), label: "Questions"),
                BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.delete_outline), label: "Delete"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.table_chart_outlined), label: "CMS"),
              ],
            ));
      },
    );
  }
}
