import 'package:dart_foundations/data/sample_models.dart';
import 'package:dart_foundations/models/ar_model.dart';
import 'package:dart_foundations/services/model_lookup.dart';
import 'package:test/test.dart';

void main() {
  test('В каталоге три объекта с уникальными id 1, 2, 3', () {
    expect(sampleModels.length, 3);
    expect(sampleModels.map((model) => model.id).toSet(), {1, 2, 3});
    expect(sampleModels.map((model) => model.title).toSet().length, 3);
    expect(sampleModels.map((model) => model.modelPath).toSet().length, 3);
  });
  test('Поиск первого, среднего и последнего элементов', () {
    for (final model in sampleModels) {
      expect(findModelById(sampleModels, model.id), same(model));
    }
  });
  test('Неизвестный id не приводит к исключению', () {
    expect(findModelById(sampleModels, 17), isNull);
  });
  test('Поиск в пустом каталоге', () {
    expect(findModelById(<ArModel>[], 1), isNull);
  });
}
