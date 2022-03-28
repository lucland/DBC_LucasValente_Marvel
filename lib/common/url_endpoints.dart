import 'dart:convert';
import 'dart:core';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

class UrlEndpoints {
  // Url Base
  final String _urlApiBase = 'http://gateway.marvel.com/v1/public/';
  final String _urlApiPublicKey = '908d54522847b85ed8c4d42e703e69a6';
  final String _urlApiPrivateKey = '70adc47bc35e93c42e368e8fe8eef26f7b086d61';

  int timeStamp = DateTime.now().millisecondsSinceEpoch;

  String generateUrl(String subject, {String id = '', int offset = 0}) {
    final String hash = generateHash();
    final String url = id.isEmpty
        ? '$_urlApiBase$subject?apikey=$_urlApiPublicKey&hash=$hash&ts=$timeStamp&offset=$offset'
        : '$_urlApiBase$subject/$id?apikey=$_urlApiPublicKey&hash=$hash&ts=$timeStamp';
    if (kDebugMode) {
      print(url);
    }
    return url;
  }

  String generateHash() {
    final String hash = '$timeStamp$_urlApiPrivateKey$_urlApiPublicKey';
    final String hashMd5 = md5.convert(utf8.encode(hash)).toString();
    if (kDebugMode) {
      print(hashMd5);
    }
    return hashMd5;
  }

  @override
  void dispose() {}
}
