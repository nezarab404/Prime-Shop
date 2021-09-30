// ignore_for_file: avoid_print

void fullPrint(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

String? token = '';
