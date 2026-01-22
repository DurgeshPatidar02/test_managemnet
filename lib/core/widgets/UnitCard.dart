import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_managment/core/theme/theme.dart';
import 'package:test_managment/core/widgets/space.dart';

class UnitCard extends StatelessWidget {
  final String heading;
  final String? subHeading;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const UnitCard(
      {required this.heading,
      required this.onTap,
      this.subHeading,
      this.onDelete,
      this.onEdit,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: ACCENT_COLOR,
            border: Border.all(),
            borderRadius: BorderRadiusGeometry.circular(5.0)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.storage,
                          size: 40,
                        ),
                        Space.width(width: 10),
                        Text(
                          heading,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: appTheme.textTheme.headlineMedium,
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: onEdit,
                          icon: Icon(Icons.edit, color: Colors.black87,),
                        ),
                        IconButton(
                          onPressed: onDelete,
                          icon: Icon(Icons.delete, color: Colors.black87),
                        ),

                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
