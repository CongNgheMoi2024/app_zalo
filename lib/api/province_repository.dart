// import 'package:dio/dio.dart';

// class ProvinceRepository {
//   final Dio _dio = Dio();
//   Future<List<Province>> getProvinces() async {
//     final response = await _dio.get(
//         'https://vietnam-administrative-division-json-server-swart.vercel.app/province');
//     if (response.statusCode == 200) {
//       final List<dynamic> provinceDataList = response.data;
//       final List<Province> provinces = provinceDataList
//           .map((provinceData) => Province.fromJson(provinceData))
//           .toList();

//       return provinces;
//     } else {
//       throw Exception('Failed to load provinces ${response.statusCode}');
//     }
//   }

//   Future<List<District>> getDistricts(String idProvince) async {
//     final response = await _dio.get(
//       'https://vietnam-administrative-division-json-server-swart.vercel.app/district/?idProvince=$idProvince',
//     );
//     if (response.statusCode == 200) {
//       final List<dynamic> districtDataList = response.data;
//       final List<District> districts = districtDataList
//           .map((districtData) => District.fromJson(districtData))
//           .toList();

//       return districts;
//     } else {
//       throw Exception('Failed to load districts ${response.statusCode}');
//     }
//   }
// }
