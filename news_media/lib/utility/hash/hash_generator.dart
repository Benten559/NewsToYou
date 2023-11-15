import 'dart:convert';
import 'package:crypto/crypto.dart';

String generateMD5Hash(Map<String, dynamic> jsonData) {
  final jsonStr = jsonEncode(jsonData);
  final bytes = utf8.encode(jsonStr);
  final md5Hash = md5.convert(bytes);
  return md5Hash.toString();
}
