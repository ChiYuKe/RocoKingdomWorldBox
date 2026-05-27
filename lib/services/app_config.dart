import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppConfig {
  const AppConfig();

  Future<void> loadEnvironment() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      debugPrint('Env Load Error: $e');
    }
  }

  Future<void> initializeSupabase() async {
    final url = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (url == null || url.isEmpty || anonKey == null || anonKey.isEmpty) {
      debugPrint('Supabase 初始化跳过：缺少 SUPABASE_URL 或 SUPABASE_ANON_KEY');
      return;
    }

    await Supabase.initialize(url: url, anonKey: anonKey);
  }
}
