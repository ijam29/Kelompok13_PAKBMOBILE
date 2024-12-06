import 'package:flutter/material.dart';
import 'home.dart'; // Import file home.dart

class PengaturanPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const PengaturanPage({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  _PengaturanPageState createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  bool _isNotificationsEnabled = true;
  String _selectedLanguage = 'Bahasa Indonesia';

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        leading: null, // Menghilangkan tombol panah (back button)
        backgroundColor:
            isDarkMode ? const Color(0xFF1E1E32) : const Color(0xFF4CAF50),
        centerTitle: true, // Menempatkan judul di tengah
      ),
      body: Container(
        color: isDarkMode
            ? Colors.black
            : Colors.white, // Ubah latar belakang sesuai dark mode
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              _buildWidgetTitle('Pengaturan Umum', isDarkMode),
              _buildLanguageSetting(isDarkMode),
              _buildNotificationSwitch(isDarkMode),
              _buildDarkModeSwitch(isDarkMode),
              _buildWidgetTitle('Keamanan', isDarkMode),
              _buildChangePassword(isDarkMode),
              _buildWidgetTitle('Lainnya', isDarkMode),
              _buildAboutApp(isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetTitle(String title, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : const Color(0xFF4CAF50),
        ),
      ),
    );
  }

  Widget _buildLanguageSetting(bool isDarkMode) {
    return Card(
      color: isDarkMode
          ? Colors.grey[800]
          : const Color(0xFFF5F5F5), // Latar belakang card gelap saat dark mode
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: ListTile(
        title: Text(
          'Bahasa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode
                ? Colors.white
                : Colors.black, // Teks menjadi putih di dark mode
          ),
        ),
        subtitle: Text(
          _selectedLanguage,
          style: TextStyle(
            color: isDarkMode
                ? Colors.white70
                : Colors.grey, // Warna teks berbeda di dark mode
          ),
        ),
        trailing: const Icon(Icons.language, color: Color(0xFF4CAF50)),
        onTap: _showLanguageDialog,
      ),
    );
  }

  Widget _buildNotificationSwitch(bool isDarkMode) {
    return Card(
      color: isDarkMode
          ? Colors.grey[800]
          : const Color(0xFFF5F5F5), // Latar belakang card gelap saat dark mode
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: SwitchListTile(
        title: Text(
          'Aktifkan Pemberitahuan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode
                ? Colors.white
                : Colors.black, // Teks menjadi putih di dark mode
          ),
        ),
        value: _isNotificationsEnabled,
        onChanged: (bool value) {
          setState(() {
            _isNotificationsEnabled = value;
          });
        },
        activeColor: const Color(0xFF4CAF50),
        subtitle: Text(
          'Aktifkan pemberitahuan untuk aplikasi.',
          style: TextStyle(
              color: isDarkMode
                  ? Colors.white70
                  : Colors.grey), // Warna teks di dark mode
        ),
      ),
    );
  }

  Widget _buildDarkModeSwitch(bool isDarkMode) {
    return Card(
      color: isDarkMode
          ? Colors.grey[800]
          : const Color(0xFFF5F5F5), // Latar belakang card gelap saat dark mode
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: SwitchListTile(
        title: Text(
          'Aktifkan Mode Gelap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode
                ? Colors.white
                : Colors.black, // Teks menjadi putih di dark mode
          ),
        ),
        value: widget.isDarkMode,
        onChanged: widget.onDarkModeChanged,
        activeColor: const Color(0xFF4CAF50),
        subtitle: Text(
          'Pilih tema gelap untuk aplikasi.',
          style: TextStyle(
              color: isDarkMode
                  ? Colors.white70
                  : Colors.grey), // Warna teks di dark mode
        ),
      ),
    );
  }

  Widget _buildChangePassword(bool isDarkMode) {
    return Card(
      color: isDarkMode
          ? Colors.grey[800]
          : const Color(0xFFF5F5F5), // Latar belakang card gelap saat dark mode
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: ListTile(
        title: Text(
          'Ubah Kata Sandi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode
                ? Colors.white
                : Colors.black, // Teks menjadi putih di dark mode
          ),
        ),
        trailing: const Icon(Icons.lock, color: Color(0xFF4CAF50)),
        onTap: () {
          // Tambahkan aksi untuk ubah kata sandi
        },
      ),
    );
  }

  Widget _buildAboutApp(bool isDarkMode) {
    return Card(
      color: isDarkMode
          ? Colors.grey[800]
          : const Color(0xFFF5F5F5), // Latar belakang card gelap saat dark mode
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: ListTile(
        title: Text(
          'Tentang Aplikasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode
                ? Colors.white
                : Colors.black, // Teks menjadi putih di dark mode
          ),
        ),
        trailing: const Icon(Icons.info, color: Color(0xFF4CAF50)),
        onTap: () {
          // Tambahkan aksi untuk tentang aplikasi
        },
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pilih Bahasa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Bahasa Indonesia'),
                value: 'Bahasa Indonesia',
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
