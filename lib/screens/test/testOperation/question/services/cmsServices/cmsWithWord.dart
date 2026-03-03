import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_managment/screens/test/testOperation/question/services/cmsServices/wordModel.dart';

String generateHtmlContent({required WordModel data,}) {

  StringBuffer htmlContent = StringBuffer();
  htmlContent.write("<head></head>");
  htmlContent.write("<body>");
  htmlContent.write("<div style='width: 100%;'>");
  // htmlContent.write("<div style='width: 100%;'>");

  for (var row in data.questions) {
    // Check if the table header exists
    htmlContent.write(
        "<table border='1' style='border-collapse: collapse; width: 100%; font-weight: normal; text-align: left'>");

    // style="font-weight: normal;"
    // Question row
    htmlContent.write("<tr>");
    htmlContent.write("<td >Question</td>");
    htmlContent.write(
        '<th style="font-weight: bold;" colspan="2"> ${row.question}</th>');
    htmlContent.write("</tr>");

    // Type row
    htmlContent.write("<tr>");
    htmlContent.write("<td>Type</td>");
    htmlContent.write(
        '<th colspan="2" style="font-weight: normal;">multiple_choice</th>');
    htmlContent.write("</tr>");

    // Option A row
    htmlContent.write("<tr style='font-weight: normal;'>");
    htmlContent.write("<td>Option</td>");
    htmlContent
        .write('<th style="font-weight: normal;" >${row.optionA}</th>');
    htmlContent.write(
        '<th style="font-weight: normal;" >${row.optionB == "a"
            ? "Correct"
            : row.ans == "A" ? "Correct" : "Incorrect"}</th>');
    htmlContent.write("</tr>");

    // Option B row
    htmlContent.write("<tr style='font-weight: normal;'>");
    htmlContent.write("<td>Option</td>");
    htmlContent
        .write('<th style="font-weight: normal;">${row.optionB}</th>');
    htmlContent.write(
        '<th style="font-weight: normal;" >${row.ans== "b"
            ? "Correct"
            : row.ans == "B" ? "Correct" : "Incorrect"}</th>');
    htmlContent.write("</tr>");

    // Option C row
    htmlContent.write("<tr style='font-weight: normal;'>");
    htmlContent.write("<td>Option</td>");
    htmlContent
        .write('<th style="font-weight: normal;" >${row.optionC}</th>');
    htmlContent.write(
        '<th style="font-weight: normal;" >${row.ans == "c"
            ? "Correct"
            : row.ans == "C" ? "Correct" : "Incorrect"}</th>');
    htmlContent.write("</tr>");

    // Option D row
    htmlContent.write("<tr style='font-weight: normal;'>");
    htmlContent.write("<td>Option</td>");
    htmlContent
        .write('<th style="font-weight: normal;" >${row.optionD}</th>');
    htmlContent.write(
        '<th style="font-weight: normal;" >${row.ans == "d"
            ? "Correct"
            : row.ans == "D" ? "Correct" : "Incorrect"}</th>');
    htmlContent.write("</tr>");

    // Solution row
    htmlContent.write("<tr style='font-weight: normal;'>");
    htmlContent.write("<td>Solution</td>");
    htmlContent.write(
        '<th colspan="2" style="font-weight: normal;" >${row.disc}</th>');
    htmlContent.write("</tr>");

    // Marks row
    htmlContent.write("<tr style='font-weight: normal;'>");
    htmlContent.write("<td>Marks</td>");
    htmlContent.write('<th style="font-weight: normal;" >${data.test.marks}</th>');
    htmlContent.write('<th style="font-weight: normal;" >${data.test.negativeMarks}</th>');
    htmlContent.write("</tr>");

    // Close table tag
    htmlContent.write("</table>");

    // Add line break for separating each table
    htmlContent.write("</br>");
    htmlContent.write("</br>");
  }

  htmlContent.write("</div>");
  htmlContent.write("</body>");

// y HTML content Return krta h String type
  return htmlContent.toString();
}


Future<void> saveAndShareHtmlFile({required String htmlContent, required String testName,required String unitName}) async {
  try {
    // Check if the content is empty
    if (htmlContent.isEmpty) {
      print('Error: HTML content is empty');
      return;
    }

    final directory = await getDownloadsDirectory();
    final filePath = '${directory?.path}/$unitName - $testName - CMS.dox';
    final file = File(filePath);

    // Save the HTML content to the file synchronously
    file.writeAsStringSync(htmlContent);

    // Check if the file exists and print its content
    if (await file.exists()) {
      print('File saved at: $filePath');
      print(
          'File content: ${await file
              .readAsString()}'); // Debugging: log the content

      // Share the file
      Share.shareXFiles(
        [XFile(filePath)], // Convert the file path to XFile
        text: '$testName - CMS',
      );
    } else {
      print('Error: File was not created.');
    }
  } catch (e) {
    print('Error saving or sharing the HTML file: $e');
  }
}