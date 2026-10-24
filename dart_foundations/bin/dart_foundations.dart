import 'dart:io';

import 'package:dart_foundations/data/sample_models.dart';

void main() {
  stdout.writeln('AR Catalog — консольная основа');

  for (final model in sampleModels) {
    stdout.writeln('Модель ${model.id}: ${model.title}');
    stdout.writeln('Описание: ${model.description}');
    stdout.writeln('Путь к модели: ${model.modelPath}');
    stdout.writeln('Путь к превью: ${model.previewPath}');
    stdout.writeln('Масштаб: ${model.scale}');
  }
}