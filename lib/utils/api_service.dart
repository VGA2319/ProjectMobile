import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Emulator Android → 10.0.2.2
  // Device fisik → ganti dengan IP komputer kamu (cek ipconfig)
  static const String baseUrl = 'http://localhost:3000/api';

  // ============================================
  // HELPER: Get token dari SharedPreferences
  // ============================================
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // ============================================
  // HELPER: Simpan data login
  // ============================================
  static Future<void> saveLoginData(String token, Map user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user', jsonEncode(user));
  }

  // ============================================
  // HELPER: Hapus data login (logout)
  // ============================================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }

  // ============================================
  // HELPER: Get data user yang tersimpan
  // ============================================
  static Future<Map<String, dynamic>?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString('user');
    if (userStr == null) return null;
    return jsonDecode(userStr);
  }

  // ============================================
  // HELPER: Header dengan token
  // ============================================
  static Future<Map<String, String>> _authHeader() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // ============================================
  // AUTH: REGISTER
  // ============================================
  static Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String password,
    String? alamat,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama': nama,
          'email': email,
          'password': password,
          'alamat': alamat,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // AUTH: LOGIN
  // ============================================
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      // Simpan token & user jika berhasil
      if (data['success'] == true) {
        await saveLoginData(data['token'], data['data']);
      }

      return data;
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // AUTH: GET PROFIL
  // ============================================
  static Future<Map<String, dynamic>> getProfil() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/profil'),
        headers: await _authHeader(),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // AUTH: UPDATE PROFIL (dengan foto)
  // ============================================
  static Future<Map<String, dynamic>> updateProfil({
    String? nama,
    String? alamat,
    File? foto,
  }) async {
    try {
      final token = await getToken();
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/auth/profil'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      if (nama != null) request.fields['nama'] = nama;
      if (alamat != null) request.fields['alamat'] = alamat;
      if (foto != null) {
        request.files.add(await http.MultipartFile.fromPath('foto_profil', foto.path));
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // AUTH: GANTI PASSWORD
  // ============================================
  static Future<Map<String, dynamic>> gantiPassword({
    required String passwordLama,
    required String passwordBaru,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/auth/ganti-password'),
        headers: await _authHeader(),
        body: jsonEncode({
          'password_lama': passwordLama,
          'password_baru': passwordBaru,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // WISATA: GET SEMUA
  // ============================================
  static Future<Map<String, dynamic>> getAllWisata({
    int? kategoriId,
    String? search,
  }) async {
    try {
      String url = '$baseUrl/wisata';
      final params = <String>[];
      if (kategoriId != null) params.add('kategori_id=$kategoriId');
      if (search != null && search.isNotEmpty) params.add('search=$search');
      if (params.isNotEmpty) url += '?${params.join('&')}';

      final response = await http.get(Uri.parse(url));
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // WISATA: GET SLIDER
  // ============================================
  static Future<Map<String, dynamic>> getSlider() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/wisata/slider'));
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // WISATA: GET DETAIL
  // ============================================
  static Future<Map<String, dynamic>> getDetailWisata(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/wisata/$id'));
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // WISATA: GET KATEGORI
  // ============================================
  static Future<Map<String, dynamic>> getKategori() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/wisata/kategori'));
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // FAVORIT: TOGGLE
  // ============================================
  static Future<Map<String, dynamic>> toggleFavorit(int wisataId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/favorit/toggle/$wisataId'),
        headers: await _authHeader(),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // FAVORIT: GET DAFTAR
  // ============================================
  static Future<Map<String, dynamic>> getFavorit() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/favorit'),
        headers: await _authHeader(),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // FAVORIT: CEK STATUS
  // ============================================
  static Future<bool> cekFavorit(int wisataId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/favorit/cek/$wisataId'),
        headers: await _authHeader(),
      );
      final data = jsonDecode(response.body);
      return data['is_favorit'] ?? false;
    } catch (e) {
      return false;
    }
  }

  // ============================================
  // RIWAYAT: GET
  // ============================================
  static Future<Map<String, dynamic>> getRiwayat() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/favorit/riwayat'),
        headers: await _authHeader(),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // RIWAYAT: TAMBAH
  // ============================================
  static Future<Map<String, dynamic>> tambahRiwayat({
    required int wisataId,
    required String tanggalKunjungan,
    String? catatan,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/favorit/riwayat'),
        headers: await _authHeader(),
        body: jsonEncode({
          'wisata_id': wisataId,
          'tanggal_kunjungan': tanggalKunjungan,
          'catatan': catatan,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }

  // ============================================
  // RIWAYAT: HAPUS
  // ============================================
  static Future<Map<String, dynamic>> hapusRiwayat(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/favorit/riwayat/$id'),
        headers: await _authHeader(),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server.'};
    }
  }
}