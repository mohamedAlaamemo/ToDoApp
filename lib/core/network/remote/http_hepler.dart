// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../../const.dart';
//
// Future<http.Response> getData({required String uRL}) async {
//   var url = Uri.parse('$baseURL$uRL?q={http}');
//
//   http.Response temp = await http.get(
//     url,
//     headers: <String, String>{
//       "Content-Type": "application/json;charset=UTF-8",
//       "Accept": "*/*",
//     },
//   );
//   if (temp.statusCode == 200) {
//     return temp;
//   }
//   return temp;
// }
//
// Future<http.Response> getData1() async {
//   var url = Uri.parse('$baseURL/api/Dates/Select/Weeks?q={http}');
//
//   http.Response temp = await http.get(
//     url,
//     headers: <String, String>{
//       "Content-Type": "application/json;charset=UTF-8",
//       "Accept": "*/*",
//     },
//   );
//   if (temp.statusCode == 200) {
//     return temp;
//   }
//   return temp;
// }
//
// Future<http.Response> postData(
//     {required String uRL, required  dynamic map}) async {
//   var url = Uri.parse('$baseURL$uRL?q={http}');
//
//   http.Response temp = await http.post(
//     url,
//     body: jsonEncode(map),
//     headers: <String, String>{
//       "Content-Type": "application/json;charset=UTF-8",
//       "Accept": "*/*",
//       "Accept-Encoding": "gzip, deflate, br",
//       "Connection": "keep-alive",
//     },
//   );
//
//   return temp;
// }
//
// Future<http.Response> postDataExam(
//     {required String uRL, required  dynamic map}) async {
//   var url = Uri.parse('$baseURL$uRL?q={http}');
//
//   http.Response temp = await http.post(
//     url,
//     body: jsonEncode(map),
//     headers: <String, String>{
//       "Content-Type": "application/json;charset=UTF-8",
//       "Accept": "*/*",
//       "Accept-Encoding": "gzip, deflate, br",
//       "Connection": "keep-alive",
//     },
//   );
//
//   return temp;
// }
//
// Future<http.Response> patchData(
//     {required String uRL,required String columnName,required dynamic value}) async {
//   var url = Uri.parse('$baseURL$uRL?q={http}');
//   var body1 = [
//     {"op": "replace", "path": "/$columnName", "value": value}
//   ];
//   http.Response temp = await http.patch(
//     url,
//     body: body1,
//     headers: <String, String>{
//       "Content-Type": "application/json;charset=UTF-8",
//       "Accept": "*/*",
//     },
//   );
//   return temp;
// }
//
// Future<http.Response> patchDataBool(
//     {required String uRL,required String columnName,required dynamic value}) async {
//   var url = Uri.parse('$baseURL$uRL?q={http}');
//   var body1 = jsonEncode([
//     {"op": "replace", "path": columnName, "value": value}
//   ]);
//   http.Response temp = await http.patch(
//     url,
//     body: body1,
//     headers: <String, String>{
//       "Content-Type": "application/json;charset=UTF-8",
//       "Accept": "*/*",
//       "Accept-Encoding": "gzip, deflate, br",
//       "Connection": "keep-alive",
//     },
//   );
//   return temp;
// }
//
// Future<http.Response> deleteData({required String uRL}) async {
//   var url = Uri.parse('$baseURL$uRL?q={http}');
//
//   http.Response temp = await http.delete(
//     url,
//     headers: <String, String>{
//       "Content-Type": "application/json;charset=UTF-8",
//       "Accept": "*/*",
//     },
//   );
//   return temp;
// }
//
// Future<String> network()async{
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     // I am connected to a mobile network.
//     return 'mobile';
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     // I am connected to a wifi network.
//     return 'wifi';
//
//   }
//   return 'no';
// }