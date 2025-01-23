import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptUtil {
  /// MD5加密
  static String encodeMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return digest.toString();
  }

  /// SHA1加密
  static String encodeSha1(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = sha1.convert(content);
    return digest.toString();
  }

  /// SHA256加密
  static String encodeSha256(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = sha256.convert(content);
    return digest.toString();
  }

  /// Base64编码
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// Base64解码
  static String decodeBase64(String data) {
    return utf8.decode(base64Decode(data));
  }

  /// AES加密
  static String encodeAes(String data, String key) {
    try {
      final _key = encrypt.Key.fromUtf8(key);
      final _iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(_key));
      final encrypted = encrypter.encrypt(data, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      return data;
    }
  }

  /// AES解密
  static String decodeAes(String encrypted, String key) {
    try {
      final _key = encrypt.Key.fromUtf8(key);
      final _iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(_key));
      final decrypted = encrypter.decrypt64(encrypted, iv: _iv);
      return decrypted;
    } catch (e) {
      return encrypted;
    }
  }
} 