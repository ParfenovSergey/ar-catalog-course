import 'dart:io';

import 'package:dart_foundations/data/sample_models.dart';
import 'package:dart_foundations/services/qr_parser.dart';

void main() {
  stdout.writeln('AR Catalog — консольная основа');
  stdout.writeln('Введите идентификатор из QR. Для выхода введите q.');

  while (true) {
    stdout.write('QR > ');
    final input = stdin.readLineSync();
    if (input == null) {
      stdout.writeln('\nКонец ввода.');
      break;
    }
    if (input.trim() == 'q') {
      stdout.writeln('До свидания!');
      break;
    }
    final id = parseQrId(input);
    if (id == null) {
      stdout.writeln('Некорректный идентификатор');
      continue;
    }
    final model = sampleModels[id - 1];

    stdout.writeln('Найден объект: ${model.title}');
    stdout.writeln(model.description);
    stdout.writeln('Модель: ${model.modelPath}');
    stdout.writeln('Превью: ${model.previewPath}');
    stdout.writeln('Масштаб: ${model.scale}');
  }
}
