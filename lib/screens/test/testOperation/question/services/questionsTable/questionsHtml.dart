import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_managment/screens/test/testOperation/question/services/cmsServices/wordModel.dart';

String generateQuestionsHtmlContent({
  required WordModel data,
}) {
  StringBuffer htmlContent = StringBuffer();
  htmlContent.write("<head></head>");
  htmlContent.write("<body>");
  htmlContent.write("<div style='width: 100%;'>");
  // htmlContent.write("<div style='width: 100%;'>");

  for (var row in data.questions) {
    htmlContent.write("""
<table border='1' style='border-collapse: collapse; width: 100%; table-layout: fixed;'>
  <colgroup>
    <col style='width: 20%;'>
    <col style='width: 80%;'>
  </colgroup>
""");
// Question row
    htmlContent.write("<tr>");
    htmlContent.write("<td style='width:20%;'>${row.no}</td>");
    htmlContent.write(
        "<td style='width:80%; font-weight:bold;'>${row.question}</td>");
    htmlContent.write("</tr>");

// Option A
    htmlContent.write("<tr>");
    htmlContent.write("<td style='width:20%;'>a.</td>");
    htmlContent.write("<td style='width:80%;'>${row.optionA}</td>");
    htmlContent.write("</tr>");

// Option B
    htmlContent.write("<tr>");
    htmlContent.write("<td style='width:20%;'>b.</td>");
    htmlContent.write("<td style='width:80%;'>${row.optionB}</td>");
    htmlContent.write("</tr>");

// Option C
    htmlContent.write("<tr>");
    htmlContent.write("<td style='width:20%;'>c.</td>");
    htmlContent.write("<td style='width:80%;'>${row.optionC}</td>");
    htmlContent.write("</tr>");

// Option D
    htmlContent.write("<tr>");
    htmlContent.write("<td style='width:20%;'>d.</td>");
    htmlContent.write("<td style='width:80%;'>${row.optionD}</td>");
    htmlContent.write("</tr>");

// Solution
    htmlContent.write("<tr>");
    htmlContent.write("<td></td>");
    htmlContent.write("<td>${row.disc}</td>");
    htmlContent.write("</tr>");

    htmlContent.write("</table>");

  }

  htmlContent.write("</div>");
  htmlContent.write("</body>");

// y HTML content Return krta h String type
  return htmlContent.toString();
}

Future<void> saveAndShareQuestionsHtmlFile(
    {required String htmlContent, required String testName}) async {
  try {
    // Check if the content is empty
    if (htmlContent.isEmpty) {
      print('Error: HTML content is empty');
      return;
    }

    final directory = await getDownloadsDirectory();
    final filePath = '${directory?.path}/$testName - CMS.dox';
    final file = File(filePath);

    // Save the HTML content to the file synchronously
    file.writeAsStringSync(htmlContent);

    // Check if the file exists and print its content
    if (await file.exists()) {
      print('File saved at: $filePath');
      print(
          'File content: ${await file.readAsString()}'); // Debugging: log the content

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
