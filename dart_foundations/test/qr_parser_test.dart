import 'package:dart_foundations/services/qr_parser.dart';
import 'package:test/test.dart';

void main() {
  final valid = <String, int>{
    '1': 1,
    '2': 2,
    '2147483647': 2147483647,
    ' 002 ': 2,
    '\t003\n': 3,
    '${'0' * 100}2': 2,
  };
  for (final entry in valid.entries) {
    test('Принимается ${entry.key.trim()}', () {
      expect(parseQrId(entry.key), entry.value);
    });
  }
  final invalid = <String?>[
    null,
    '',
    '   ',
    'abc',
    '-1',
    '0',
    '000',
    '1.5',
    '+1',
    '0x10',
    '1x',
    '1 2',
    '1\n2',
    '1\t2',
    '1e2',
    'https://example.org/1',
    '١',
    '１',
    '2147483648',
    '9' * 100,
    'q',
  ];
  for (var i = 0; i < invalid.length; i++) {
    test('Некорректный ввод, сценарий $i', () {
      expect(parseQrId(invalid[i]), isNull);
    });
  }
}
