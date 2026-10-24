import '../models/ar_model.dart';

/// Возвращает первую подходящую запись или null при её отсутствии.
ArModel? findModelById(Iterable<ArModel> models, int id) {
  for (final model in models) {
    if (model.id == id) return model;
  }
  return null;
}
