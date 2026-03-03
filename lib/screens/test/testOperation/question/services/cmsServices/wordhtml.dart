import 'package:test_managment/screens/test/testOperation/question/services/cmsServices/wordModel.dart';

// void loadHtmlContent({required WordModel wordmodel,required  webViewController}) {
//   String htmlContent = '''
//       <!DOCTYPE html>
//       <html>
//
//       <body>
//         <h2>Dynamic Table</h2>
//         <div>
//     ''';
//
//   // Dynamically append rows to the table
//   for (var row in wordmodel.questions) {
//     '''
//         <table border='1' style='border-collapse: collapse; width: 100%;'>
//
//       <tr>
//       <td>Question</td>
//       <th colspan="2">${row.question}</th>
//       </tr>
//
//       <tr>
//       <td>Type</td>
//       <th colspan="2">multiple_choice</th>
//       </tr>
//
//       <tr>
//       <td>Option</td>
//        <th>${row.optionA}</th>
//        <th>${row.ans == "a" ? "Correct " : "Incorrect"}</th>
//        </tr>
//
//       <tr>
//       <td>Option</td>
//       <th>${row.optionB}</th>
//       <th>${row.ans == "b" ? "Correct " : "Incorrect"}</th>
//       </tr>
//
//       <tr>
//       <td>Option</td>
//       <th>${row.optionC}</th>
//       <th>${row.ans == "c" ? "Correct " : "Incorrect"}</th>
//       </tr>
//
//       <tr>
//       <td>Option</td>
//       <th>${row.optionD}</th>
//       <th>${row.ans == "d" ? "Correct " : "Incorrect"}</th>
//       </tr>
//
//      <tr>
//       <td>Solution</td>
//       <th colspan="2">${row.disc}</th>
//       </tr>
//
//       <tr>
//       <td>Marks</td>
//       <th>${wordmodel.test.marks}</th>
//       <th>${wordmodel.test.negativeMarks}</th>
//
//      </tr>
//
//       </table>
//       </br>
//       ''';
//   }
//
//   '''
//         </div>
//       </body>
//       </html>
//     ''';
//
//   // Load the generated HTML content into the WebView
//   webViewController.loadHtmlString(htmlContent);
// }