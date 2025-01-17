// ignore_for_file: nullable_type_in_catch_clause, non_constant_identifier_names

import 'dart:io';
import 'package:http/http.dart' as http;


Future<bool> CheckInternet() async {
  try {
    final result = await http.get(Uri.parse('https://www.google.com'));
    if(result.statusCode==200){
      return true;
    }
  else{
      return false;
  }
  }
   on SocketException catch (_) {
    return false;
  }
}
