import 'package:flutter/material.dart';
import 'home.dart'; // Pastikan mengimpor halaman home.dart

class HelpPage extends StatelessWidget {
  final bool
      isDarkMode; // Menambahkan variabel isDarkMode untuk mendeteksi mode gelap

  const HelpPage(
      {super.key,
      required this.isDarkMode,
      required Null Function(bool value) onDarkModeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panduan Penggunaan'),
        backgroundColor:
            isDarkMode ? Colors.grey[900]! : const Color(0xFF4CAF50),
        elevation: 4,
        shadowColor: isDarkMode
            ? Colors.grey[700]!
            : const Color(0xFF4CAF50).withOpacity(0.6),
        leading: null, // Menghilangkan tombol panah (back button)
        centerTitle: true, // Menempatkan judul di tengah
      ),
      backgroundColor: isDarkMode
          ? Colors.black
          : Colors.white, // Background sesuai dark mode
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHelpCard(
              icon: Icons.language,
              title: 'Pilih Bahasa',
              description:
                  'Di halaman ini Anda dapat memilih bahasa yang ingin diidentifikasi atau deteksi.',
              isDarkMode: isDarkMode,
            ),
            _buildHelpCard(
              icon: Icons.arrow_downward,
              title: 'Pilih Dari Dropdown',
              description:
                  'Pilih bahasa dari dropdown yang tersedia. Pilihan bahasa meliputi Indonesia, English, Spanish, dan French.',
              isDarkMode: isDarkMode,
            ),
            _buildHelpCard(
              icon: Icons.check,
              title: 'Tekan "Pilih Bahasa"',
              description:
                  'Setelah memilih bahasa, tekan tombol "Pilih Bahasa" untuk mengonfirmasi pilihan bahasa Anda.',
              isDarkMode: isDarkMode,
            ),
            _buildHelpCard(
              icon: Icons.help_outline,
              title: 'Akses Halaman Bantuan',
              description:
                  'Anda dapat mengakses halaman Bantuan kapan saja untuk panduan lebih lanjut mengenai penggunaan aplikasi.',
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun card yang berisi setiap poin bantuan
  Widget _buildHelpCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isDarkMode,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.grey[800]
            : Colors.white, // Card color for dark mode
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.grey[600]!
                : const Color(0xFF4CAF50).withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 40,
            color: isDarkMode
                ? Colors.white
                : const Color(0xFF4CAF50), // Icon color changes for dark mode
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? Colors.white
                        : const Color(0xFF4CAF50), // Title color for dark mode
                    fontFamily: 'Arial',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode
                        ? Colors.white70
                        : Colors.black87, // Description color for dark mode
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
