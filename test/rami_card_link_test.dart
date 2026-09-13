import 'package:flutter_test/flutter_test.dart';
import 'package:rami_mvp/models/rami_card.dart';

void main() {
  for (final entry in {'E001': RamiCard.elephant, 'D001': RamiCard.dog, 'C001': RamiCard.car}.entries) {
    for (final value in ['rami://t/${entry.key}', 'https://rami.app/t/${entry.key}', entry.value.id]) {
      test('supported URI/Text ID resolves: $value', () {
        expect(RamiCard.fromNdefValue(value), same(entry.value));
      });
    }
  }
  for (final value in ['', 'rami://t/UNKNOWN', 'https://other.example/t/E001', 'http://rami.app/t/E001', 'RAMI:UNKNOWN:001']) {
    test('unsupported record is ignored: $value', () {
      expect(RamiCard.fromNdefValue(value), isNull);
    });
  }
}
