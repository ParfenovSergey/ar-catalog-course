import '../models/ar_model.dart';

/// Разбирает только положительный десятичный ASCII-идентификатор.
/// Команды консольного интерфейса здесь не обрабатываются.
int? parseQrId(String? value) {
  if (value == null) return null;
  final text = value.trim();
  if (!RegExp(r'^[0-9]+$').hasMatch(text)) return null;

  // Удаляем ведущие нули до преобразования, чтобы они не вызывали
  // переполнение у корректного идентификатора с длинным префиксом нулей.
  final digits = text.replaceFirst(RegExp(r'^0+'), '');
  if (digits.isEmpty || digits.length > 10) return null;
  final id = int.tryParse(digits);
  if (id == null || id < ArModel.minId || id > ArModel.maxId) return null;
  return id;
}
