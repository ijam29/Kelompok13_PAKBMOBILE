import 'package:flutter/material.dart';
import 'package:pacoba/bantuan.dart'; // Mengimpor halaman Bantuan
import 'package:pacoba/pengaturan.dart'; // Mengimpor halaman Pengaturan
import 'package:pacoba/side.dart'; // Mengimpor menu samping
import 'package:provider/provider.dart'; // Mengimpor provider
import 'package:pacoba/controller/controller.dart'; // Import PredictionProvider dengan path yang benar

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  List<Widget> get _pages => [
        HomeScreen(
          isDarkMode: _isDarkMode,
          onDarkModeChanged: (bool value) {
            setState(() {
              _isDarkMode = value;
            });
          },
        ),
        HelpPage(
          isDarkMode: _isDarkMode,
          onDarkModeChanged: (bool value) {
            setState(() {
              _isDarkMode = value;
            });
          },
        ), // Menggunakan halaman Bantuan dari bantuan.dart
        PengaturanPage(
          isDarkMode: _isDarkMode,
          onDarkModeChanged: (bool value) {
            setState(() {
              _isDarkMode = value;
            });
          },
        ),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isDarkMode ? 'Mode gelap diaktifkan' : 'Mode terang diaktifkan',
        ),
        action: SnackBarAction(
          label: 'Tutup',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: const Color.fromARGB(255, 30, 30, 50),
        scaffoldBackgroundColor:
            _isDarkMode ? Colors.black : Colors.white, // Mengubah background
        textTheme: TextTheme(
          bodyMedium: const TextStyle(
            color: Colors.black, // Teks selalu hitam
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: _isDarkMode ? const Color(0xFF1E1E32) : Colors.white,
          selectedItemColor: const Color(0xFF4caf50),
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TransInter'),
          backgroundColor:
              _isDarkMode ? const Color(0xFF1E1E32) : const Color(0xFF4caf50),
          actions: [
            IconButton(
              icon: Icon(
                _isDarkMode ? Icons.brightness_7 : Icons.brightness_6,
              ),
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        drawer: SideMenu(
          isDarkMode: _isDarkMode,
          username: widget.username,
          onDarkModeChanged: (value) => _toggleDarkMode(),
          onItemTapped: _onItemTapped,
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'Bantuan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Pengaturan',
            ),
          ],
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required bool isDarkMode, required Null Function(bool value) onDarkModeChanged});

  @override
  Widget build(BuildContext context) {
    return Consumer<PredictionProvider>(
      builder: (context, predictionProvider, child) {
        // Menentukan apakah mode gelap aktif
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Selamat datang di halaman utama!',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black, // Teks berubah warna sesuai mode
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: isDarkMode ? Colors.grey[800] : Colors.white, // Warna card untuk darkmode
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: predictionProvider.textController,
                          decoration: InputDecoration(
                            labelText: 'Masukkan teks',
                            hintText: 'Tulis sesuatu...',
                            labelStyle: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black, // Label warna berubah
                            ),
                            hintStyle: TextStyle(
                              color: isDarkMode ? Colors.white70 : Colors.black, // Hint text warna berubah
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: isDarkMode ? Colors.white70 : Colors.black, // Border warna berubah
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: isDarkMode ? Colors.white70 : Colors.black, // Border warna berubah
                                width: 2,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black, // Teks input berubah warna
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            // Memanggil fungsi prediksi saat tombol ditekan
                            await predictionProvider.predict();
                          },
                          child: const Text(
                            'Kirim',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Menampilkan hasil prediksi jika tersedia
                        if (predictionProvider.predictionMessage != null)
                          Text(
                            predictionProvider.predictionMessage!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black, // Hasil prediksi berubah warna
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}