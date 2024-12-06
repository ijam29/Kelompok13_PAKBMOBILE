import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'firebase_options.dart'; // Import FirebaseOptions yang dihasilkan oleh FlutterFire CLI
import 'package:pacoba/login.dart'; // Import LoginPage yang akan digunakan sebagai halaman pertama
import 'package:provider/provider.dart'; // Import Provider untuk manajemen status
import 'package:pacoba/controller/controller.dart'; // Import PredictionProvider dengan path yang benar
import 'home.dart'; // Import HomePage

void main() async {
  // Inisialisasi WidgetsFlutterBinding untuk memastikan Flutter siap
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase secara asinkron dengan opsi platform yang tepat
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Pastikan FirebaseOptions digunakan di sini
  );

  // Jalankan aplikasi
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          PredictionProvider(), // Menambahkan PredictionProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TransInter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light, // Atur tema terang secara default
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4CAF50), // Warna appbar
        ),
      ),
      // Gunakan halaman login sebagai halaman pertama
      home: const LoginPage(), // Ganti dengan halaman login jika perlu
      routes: {
        // Definisikan rute untuk navigasi halaman setelah login
        '/home': (context) =>
            const HomePage(username: 'user'), // Halaman utama setelah login
      },
    );
  }
}
