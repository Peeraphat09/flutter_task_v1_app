import 'package:flutter/material.dart';
import 'package:flutter_task_v1_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//----------------------
void main() async {
  // ตั้งค่าการใช้งาน supabase
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  assert(
    supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty,
    'Missing SUPABASE_URL / SUPABASE_ANON_KEY. Provide via --dart-define.',
  );

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  //---------------------

  runApp(
    FlutterTaskV1App(),
  );
}

//---------------------

class FlutterTaskV1App extends StatefulWidget {
  const FlutterTaskV1App({super.key});

  @override
  State<FlutterTaskV1App> createState() => _FlutterTaskV1AppState();
}

class _FlutterTaskV1AppState extends State<FlutterTaskV1App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme:  GoogleFonts.promptTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}