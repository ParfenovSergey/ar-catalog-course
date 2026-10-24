import 'package:dart_foundations/models/ar_model.dart';
import 'package:test/test.dart';

ArModel createModel({
  int id = 1,
  String title = 'Робот',
  String description = 'Описание',
  String modelPath = 'assets/models/robot.glb',
  String previewPath = 'assets/previews/robot.png',
  double scale = 1.0,
}) => ArModel(
  id: id,
  title: title,
  description: description,
  modelPath: modelPath,
  previewPath: previewPath,
  scale: scale,
);

void main() {
  test('Границы id допустимы', () {
    expect(createModel(id: 1).id, 1);
    expect(createModel(id: 2147483647).id, 2147483647);
  });
  test('Текст и пути нормализуются по краям', () {
    final model = createModel(
      title: ' Робот ',
      description: ' Описание ',
      modelPath: ' assets/models/robot.glb ',
      previewPath: ' assets/previews/robot.png ',
    );
    expect(model.title, 'Робот');
    expect(model.description, 'Описание');
    expect(model.modelPath, 'assets/models/robot.glb');
    expect(model.previewPath, 'assets/previews/robot.png');
  });
  for (final id in [-1, 0, 2147483648]) {
    test('Отклоняется id $id', () {
      expect(() => createModel(id: id), throwsArgumentError);
    });
  }
  for (final value in ['', ' \t\n ']) {
    test('Отклоняются пустые текстовые поля ${value.codeUnits}', () {
      expect(() => createModel(title: value), throwsArgumentError);
      expect(() => createModel(description: value), throwsArgumentError);
    });
  }
  for (final scale in [
    0.0,
    -1.0,
    double.nan,
    double.infinity,
    double.negativeInfinity,
  ]) {
    test('Отклоняется scale $scale', () {
      expect(() => createModel(scale: scale), throwsArgumentError);
    });
  }
  test('Допустим положительный дробный масштаб', () {
    expect(createModel(scale: 0.01).scale, 0.01);
  });
  for (final path in [
    '',
    'assets/models/a.obj',
    '/assets/models/a.glb',
    'assets/models/../a.glb',
    'assets/models/./a.glb',
    'assets/models//a.glb',
    r'assets\models\a.glb',
    'other/models/a.glb',
    'assets/previews/a.glb',
    'assets/models/a.glb?x=1',
  ]) {
    test('Отклоняется путь модели "$path"', () {
      expect(() => createModel(modelPath: path), throwsArgumentError);
    });
  }
  test('Отклоняются неподходящие пути превью', () {
    for (final path in [
      '',
      'assets/previews/a.glb',
      'assets/models/a.png',
      'assets/previews/../a.png',
    ]) {
      expect(() => createModel(previewPath: path), throwsArgumentError);
    }
  });
  test('Допустимы вложенные пути и форматы превью', () {
    for (final extension in ['png', 'jpg', 'jpeg', 'webp']) {
      final model = createModel(
        modelPath: 'assets/models/furniture/chair-1.glb',
        previewPath: 'assets/previews/furniture/chair_1.$extension',
      );
      expect(model.previewPath, endsWith('.$extension'));
    }
  });
}
