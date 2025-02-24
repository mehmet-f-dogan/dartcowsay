import 'dart:io';
import 'dart:convert';

String buildBalloon(List<String> lines, int maxwidth) {
  List<String> borders = ['/', '\\', '\\', '/', '|', '<', '>'];
  int count = lines.length;
  List<String> ret = [];

  String top = ' ${'_' * (maxwidth + 2)}';
  String bottom = ' ${'-' * (maxwidth + 2)}';

  ret.add(top);

  if (count == 1) {
    String s = '${borders[5]} ${lines[0]} ${borders[6]}';
    ret.add(s);
  } else {
    String s = '${borders[0]} ${lines[0]} ${borders[1]}';
    ret.add(s);
    for (int i = 1; i < count - 1; i++) {
      s = '${borders[4]} ${lines[i]} ${borders[4]}';
      ret.add(s);
    }
    s = '${borders[2]} ${lines[count - 1]} ${borders[3]}';
    ret.add(s);
  }

  ret.add(bottom);
  return ret.join('\n');
}

List<String> tabsToSpaces(List<String> lines) {
  return lines.map((line) => line.replaceAll('\t', '    ')).toList();
}

int calculateMaxWidth(List<String> lines) {
  int maxWidth = 0;
  for (var line in lines) {
    int len = line.runes.length;
    if (len > maxWidth) {
      maxWidth = len;
    }
  }
  return maxWidth;
}

List<String> normalizeStringsLength(List<String> lines, int maxwidth) {
  return lines.map((line) {
    int len = line.runes.length;
    return line + ' ' * (maxwidth - len);
  }).toList();
}

void printFigure(String name) {
  const cow = '''
         \\  ^__^
          \\ (oo)\\_______
	    (__)\\       )\\/\\\\
	        ||----w |
	        ||     ||
  ''';

  const stegosaurus = '''
         \\                      .       .
          \\                    / ` + "`" + `.   .' "
           \\           .---.  <    > <    >  .---.
            \\          |    \\  \\ - ~ ~ - /  /    |
          _____           ..-~             ~-..-~
         |     |   \\~~~\\\\.'                    ` + "`" + `./~~~/
        ---------   \\__/                         \\__/
       .'  O    \\     /               /       \\  "
      (_____,    ` + "`" + `._.'               |         }  \\/~~~/
       ` + "`" + `----.          /       }     |        /    \\__/
             ` + "`" + `-.      |       /      |       /      ` + "`" + `. ,~~|
                 ~-.__|      /_ - ~ ^|      /- _      ` + "`" + `..-'
                      |     /        |     /     ~-.     ` + "`" + `-. _  _  _
                      |_____|        |_____|         ~ - . _ _ _ _ _>
  ''';

  switch (name) {
    case 'cow':
      print(cow);
      break;
    case 'stegosaurus':
      print(stegosaurus);
      break;
    default:
      print('Unknown figure');
  }
}

void main(List<String> arguments) {
  if (stdin.hasTerminal) {
    print('The command is intended to work with pipes.');
    print('Usage: fortune | gocowsay');
    return;
  }

  String figure = 'cow';

  for (var i = 0; i < arguments.length; i++) {
    if (arguments[i] == '-f' && i + 1 < arguments.length) {
      figure = arguments[i + 1];
      i++;
    }
  }

  List<String> lines = [];

  stdin.transform(utf8.decoder).transform(LineSplitter()).listen((line) {
    lines.add(line);
  }, onDone: () {
    lines = tabsToSpaces(lines);
    int maxwidth = calculateMaxWidth(lines);
    List<String> messages = normalizeStringsLength(lines, maxwidth);
    String balloon = buildBalloon(messages, maxwidth);
    print(balloon);
    printFigure(figure);
    print('');
  });
}
