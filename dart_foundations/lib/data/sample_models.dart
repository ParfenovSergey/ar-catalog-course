import '../models/ar_model.dart';

final List<ArModel> sampleModels = _createSampleModels();

List<ArModel> _createSampleModels() {
  final models = <ArModel>[
    ArModel(
      id: 1,
      title: 'Космический корабль',
      description: 'Учебная модель космического корабля.',
      modelPath: 'assets/models/spaceship.glb',
      previewPath: 'assets/previews/spaceship.png',
      scale: 0.5,
    ),
    ArModel(
      id: 2,
      title: 'Робот',
      description: 'Робот для изучения формы и пропорций.',
      modelPath: 'assets/models/robot.glb',
      previewPath: 'assets/previews/robot.png',
      scale: 1.0,
    ),
    ArModel(
      id: 3,
      title: 'Кресло',
      description: 'Предмет интерьера для будущего размещения в AR.',
      modelPath: 'assets/models/armchair.glb',
      previewPath: 'assets/previews/armchair.png',
      scale: 0.8,
    ),
  ];
  final ids = <int>{};
  for (final model in models) {
    if (!ids.add(model.id)) {
      throw StateError('Повторяющийся идентификатор: ${model.id}');
    }
  }
  return List<ArModel>.unmodifiable(models);
}