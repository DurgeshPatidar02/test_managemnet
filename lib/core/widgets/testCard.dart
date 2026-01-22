import 'package:flutter/material.dart';
import 'package:test_managment/core/widgets/space.dart';
import '../theme/theme.dart';

class TestCard extends StatelessWidget {
  final String testName;
  final String testDescription;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TestCard(
      {required this.testName,
      required this.testDescription,
      required this.onTap,
      this.onDelete,
      this.onEdit,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Space.height(height: 20),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * .95,
              decoration: BoxDecoration(
                color: ACCENT_COLOR,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsetsGeometry.only(
                    top: 2, bottom: 2, left: 10, right: 4),
                child: Row(
                  children: [
                    const Center(
                      child: ImageIcon(
                        AssetImage('assets/test_icon/test.png'),
                        size: 60,
                      ),
                    ),
                    Space.width(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            testName,
                            style: appTheme.textTheme.headlineMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            testDescription,
                            style: appTheme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .11,
                      child: GestureDetector(
                        onTap: onEdit,
                        child: const ImageIcon(
                          AssetImage('assets/test_icon/edit.png'),
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .11,
                      child: GestureDetector(
                        onTap: onDelete,
                        child: const ImageIcon(
                          AssetImage('assets/test_icon/delete.png'),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
