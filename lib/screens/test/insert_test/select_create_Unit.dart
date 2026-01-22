import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_managment/router/app_routes.dart';
import 'package:test_managment/screens/test/cubit/fetch_unit/FetchTab1Cubit.dart';
import 'package:test_managment/screens/test/cubit/fetch_unit/FetchTab1State.dart';
import 'package:test_managment/screens/test/cubit/fetch_unit/FetchTab2Cubit.dart';
import 'package:test_managment/screens/test/cubit/fetch_unit/FetchTab2State.dart';
import '../../../core/widgets/UnitCard.dart';
import '../../../core/widgets/space.dart';

class SelectCreateUnit extends StatefulWidget {
  const SelectCreateUnit({super.key});

  @override
  State<SelectCreateUnit> createState() => _SelectCreateUnitState();
}

class _SelectCreateUnitState extends State<SelectCreateUnit>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitNameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<FetchTab1Cubit>().loadUnits();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _unitNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit Management"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Unit List"),
            Tab(text: "Create Unit"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ---------------- Tab 1: Unit List ----------------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<FetchTab1Cubit, FetchTab1State>(
                builder: (context, state) {
              if (state is FetchTab1Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FetchTab1Success) {
                return ListView.builder(
                    itemCount: state.units.length,
                    itemBuilder: (context, index) {
                      final unit = state.units[index];
                      return UnitCard(
                        heading: unit.unitName,
                        onTap: () {
                          context.pushNamed(AppRoutes.insertTest,
                              extra: unit);
                        },
                        onDelete: () {
                          context
                              .read<FetchTab1Cubit>()
                              .deleteUnit(unit.id);
                        },
                      );
                    });
              }
              if (state is FetchTab1NoFound) {
                return const Center(
                  child: Text("No Units Found"),
                );
              }
              return const Center(
                child: Text("Somthing Went Wrong"),
              );
            }, listener: (context, state) {
              if (state is FetchTab1Error) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Error In Fetching'),
                  backgroundColor: Colors.red,
                ));
              }
              if (state is FetchTab1Delete) {
                context.read<FetchTab1Cubit>().loadUnits();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Unit Delete Successfully'),
                  backgroundColor: Colors.green,
                ));
              }
              if (state is FetchTab1NoEdit) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Unit Name Edited Successfully'),
                  backgroundColor: Colors.green,
                ));
              }
            }),
          ),

          // ---------------- Tab 2: Create Unit ----------------
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<FetchTab2Cubit, FetchTab2State>(
                  builder: (context, state) {
                if (state is FetchTab2Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Space.height(height: 50),
                      TextFormField(
                        key: UniqueKey(),
                        controller: _unitNameCtrl,
                        decoration: const InputDecoration(
                          labelText: "Unit Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.isEmpty
                            ? 'Unit name required'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<FetchTab2Cubit>().createUnit(
                                unitName: _unitNameCtrl.text.trim());
                          }
                        },
                        child: const Text("Create Unit"),
                      ),
                    ],
                  ),
                );
              }, listener: (context, state) {
                if (state is FetchTab2Created) {
                  context.read<FetchTab1Cubit>().loadUnits();
                  _tabController.animateTo(0);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Unit Created Successfully'),
                    backgroundColor: Colors.green,
                  ));
                }
                if (state is FetchTab2Exist) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "This Unit is already Exist",
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.yellow,
                  ));
                }
                if (state is FetchTab2Error) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Error Occurred'),
                    backgroundColor: Colors.red,
                  ));
                }
              })),
        ],
      ),
    );
  }
}
