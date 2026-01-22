import 'package:flutter/material.dart';

import '../theme/theme.dart';

Widget EButton({required String text,
  required VoidCallback onTap,
  BuildContext? context,
  bool enable = true,
  double width = .8}){
  return SizedBox(
    width: context!=null ? MediaQuery.of(context).size.width * width : null,
    child: ElevatedButton(

      onPressed: enable ? onTap : null,
      child: Text(
        text,
        style: enable
            ? appTheme.textTheme.headlineMedium
            : appTheme.textTheme.headlineMedium
            ?.copyWith(color: Colors.black45),
      ),
    ),
  );
}


// class AppButton {
//   static Widget elevatedButton(
//       {required String text,
//       required VoidCallback onTap,
//       BuildContext? context,
//       bool enable = true,
//       double width = .8}) {
//     return SizedBox(
//       width: context!=null ? MediaQuery.of(context).size.width * width : null,
//       child: ElevatedButton(
//
//         onPressed: enable ? onTap : null,
//         child: Text(
//           text,
//           style: enable
//               ? appTheme.textTheme.headlineMedium
//               : appTheme.textTheme.headlineMedium
//                   ?.copyWith(color: Colors.black45),
//         ),
//       ),
//     );
//   }
// }
