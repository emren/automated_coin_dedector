enum BoolString { Fake, Real }

extension BoolStringNameExtension on BoolString {
  String get name {
    switch (this) {
      case BoolString.Fake:
        return 'Fake';
      case BoolString.Real:
        return 'Real';
    }
  }
}
