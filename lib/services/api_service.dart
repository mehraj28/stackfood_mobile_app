// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'token_service.dart';

// class ApiService {
//   static const String baseUrl = "https://stackfood-backend.onrender.com";

//   // 🔐 COMMON HEADERS WITH TOKEN
//   static Future<Map<String, String>> _headers() async {
//     final token = await TokenService.getToken();
//     return {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token",
//     };
//   }

//   // ===================== AUTH =====================

//   static Future<String?> adminLogin(String email, String password) async {
//     final response = await http.post(
//       Uri.parse("$baseUrl/auth/admin/login"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "email": email,
//         "password": password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["access_token"];
//     }
//     return null;
//   }

//   // ===================== FOODS =====================

//   // 🔹 BASIC (used earlier)
//   static Future<List<dynamic>> getFoods() async {
//     final response = await http.get(
//       Uri.parse("$baseUrl/admin/foods"),
//       headers: await _headers(),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     }
//     throw Exception("Failed to fetch foods");
//   }

//   // 🔥 PAGINATED + SEARCH
//   static Future<List<dynamic>> getFoodsPaged({
//     required int page,
//     required int limit,
//     String? search,
//   }) async {
//     final queryParams = {
//       "page": page.toString(),
//       "limit": limit.toString(),
//       if (search != null && search.isNotEmpty) "search": search,
//     };

//     final uri =
//         Uri.parse("$baseUrl/admin/foods").replace(queryParameters: queryParams);

//     final response = await http.get(
//       uri,
//       headers: await _headers(),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Failed to fetch paged foods");
//     }
//   }

//   // ➕ ADD FOOD
//   static Future<bool> addFood(Map<String, dynamic> food) async {
//     final response = await http.post(
//       Uri.parse("$baseUrl/admin/food"),
//       headers: await _headers(),
//       body: jsonEncode(food),
//     );
//     return response.statusCode == 200;
//   }

//   // ✏️ UPDATE FOOD
//   static Future<bool> updateFood(int id, Map<String, dynamic> food) async {
//     final response = await http.put(
//       Uri.parse("$baseUrl/admin/food/$id"),
//       headers: await _headers(),
//       body: jsonEncode(food),
//     );
//     return response.statusCode == 200;
//   }

//   // ❌ DELETE FOOD
//   static Future<bool> deleteFood(int id) async {
//     final response = await http.delete(
//       Uri.parse("$baseUrl/admin/food/$id"),
//       headers: await _headers(),
//     );
//     return response.statusCode == 200;
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000";

  // ================= HEADERS =================
  static Future<Map<String, String>> _headers({bool auth = true}) async {
    final token = await TokenService.getToken();
    return {
      "Content-Type": "application/json",
      if (auth && token != null) "Authorization": "Bearer $token",
    };
  }

  // ================= USER LOGIN =================
  static Future<String?> userLogin({
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: await _headers(auth: false),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["access_token"];
    }
    return null;
  }

  // ================= GET FOODS (USER) =================
  static Future<List<dynamic>> getFoods() async {
    final res = await http.get(
      Uri.parse("$baseUrl/foods"),
      headers: await _headers(auth: false),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    throw Exception("Failed to load foods");
  }

  // ================= PLACE ORDER =================
  static Future<bool> placeOrder({
    required List<Map<String, dynamic>> items,
    required double total,
  }) async {
    final res = await http.post(
      Uri.parse("$baseUrl/orders"),
      headers: await _headers(),
      body: jsonEncode({
        "items": items,
        "total": total,
      }),
    );

    return res.statusCode == 200 || res.statusCode == 201;
  }
}
