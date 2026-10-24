/// Неизменяемые метаданные объекта каталога.
class ArModel {
  static const int minId = 1;
  static const int maxId = 2147483647;

  final int id;
  final String title;
  final String description;
  final String modelPath;
  final String previewPath;
  final double scale;

  ArModel({
    required this.id,
    required String title,
    required String description,
    required String modelPath,
    required String previewPath,
    required this.scale,
  }) : title = _normalizeText(title, 'title'),
       description = _normalizeText(description, 'description'),
       modelPath = _validatePath(modelPath, 'models', {'glb'}, 'modelPath'),
       previewPath = _validatePath(previewPath, 'previews', {
         'png',
         'jpg',
         'jpeg',
         'webp',
       }, 'previewPath') {
    if (id < minId || id > maxId) {
      throw ArgumentError.value(id, 'id', 'Допустим диапазон $minId..$maxId');
    }
    if (!scale.isFinite || scale <= 0) {
      throw ArgumentError.value(scale, 'scale', 'Нужно конечное число > 0');
    }
  }

  static String _normalizeText(String value, String name) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError.value(value, name, 'Строка не должна быть пустой');
    }
    return normalized;
  }

  /// Пути регистрозависимы, используют / и сегменты из ASCII-букв,
  /// цифр, точек, дефисов и подчёркиваний. Сегменты . и .. запрещены.
  /// Краевые пробелы удаляются. Наличие файла не проверяется.
  static String _validatePath(
    String value,
    String directory,
    Set<String> extensions,
    String name,
  ) {
    final path = _normalizeText(value, name);
    final parts = path.split('/');
    final valid =
        parts.length >= 3 &&
        parts[0] == 'assets' &&
        parts[1] == directory &&
        parts.every(
          (part) =>
              part != '.' &&
              part != '..' &&
              RegExp(r'^[a-zA-Z0-9_.-]+$').hasMatch(part),
        ) &&
        extensions.any((extension) => parts.last.endsWith('.$extension'));
    if (!valid) {
      throw ArgumentError.value(
        value,
        name,
        'Ожидается путь assets/$directory с допустимым расширением',
      );
    }
    return path;
  }
}
