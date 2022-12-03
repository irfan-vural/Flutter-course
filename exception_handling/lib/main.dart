/*main() {
  try {
    birFonk(31);
  } on ExceptionA {
    print('A tipi');
  } on Exceptionb {
    print('b tipi');
  } catch (err) {
    print(err);
  } finally {
    print('Her durumda çalışacak kod');
  }
}
*/

main() {
  try {
    arafonk(1000);
  } catch (e) {
    print('main fonk yakalı: $e');
  }
}

void birFonk(int num) {
  if (num < 100) {
    print(num);
  } else if (num < 1000) {
    throw ExceptionA();
  } else if (num < 10000) {
    throw Exceptionb();
  } else {
    throw Exception('diğer bir hata');
  }
}

void arafonk(int num) {
  try {
    birFonk(num);
  } catch (e) {
    print('ara fonk hatası : $e');
    rethrow;
  }
}

class ExceptionA implements Exception {}

class Exceptionb implements Exception {}
