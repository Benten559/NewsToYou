class Singleton {
  static final Singleton _singleton = Singleton._internal();
  late String userName;

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}