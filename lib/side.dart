import 'package:flutter/material.dart';
import 'package:pacoba/bantuan.dart';
import 'package:pacoba/login.dart';
import 'pengaturan.dart'; // Pastikan file pengaturan.dart diimpor

// Main Drawer Widget
class SideMenu extends StatelessWidget {
  final bool isDarkMode;
  final String username;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<int> onItemTapped;

  const SideMenu({
    super.key,
    required this.isDarkMode,
    required this.username,
    required this.onDarkModeChanged,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeaderWidget(isDarkMode: isDarkMode, username: username),
          MenuItem(
            icon: Icons.home,
            title: 'Beranda',
            onTap: () => onItemTapped(0),
          ),
          MenuItem(
            icon: Icons.language,
            title: 'Bahasa',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur perubahan bahasa akan datang!'),
                ),
              );
            },
          ),
          MenuItem(
            icon: Icons.help,
            title: 'Bantuan',
            onTap: () => onItemTapped(1),
          ),
          MenuItem(
            icon: Icons.settings,
            title: 'Pengaturan',
            onTap: () => onItemTapped(2),
          ),
          DarkModeToggle(
            isDarkMode: isDarkMode,
            onDarkModeChanged: onDarkModeChanged,
          ),
          // Tambahkan MenuItem untuk "Tambah Foto"
          MenuItem(
            icon: Icons.create, // Ikon untuk tombol tambah foto
            title: 'Tambah Foto',
            onTap: () {
              // Logika untuk menambah foto bisa ditambahkan di sini
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur tambah foto akan datang!'),
                ),
              );
            },
          ),
          const Divider(),
          LogoutMenuItem(onTap: () => _showLogoutConfirmationDialog(context)),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Tidak',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                'Ya',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Drawer Header Widget
class DrawerHeaderWidget extends StatelessWidget {
  final bool isDarkMode;
  final String username;

  const DrawerHeaderWidget({super.key, 
    required this.isDarkMode,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Colors.black54, Colors.black87]
              : [Colors.teal.shade200, Colors.teal.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/images/profile.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 10),
            Text(
              username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Menu Item Widget
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItem({super.key, 
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4CAF50)), // Green color
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF4CAF50), // Green color
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      tileColor: Colors.transparent, // Default color when not selected
      selectedTileColor: const Color(0xFF4CAF50)
          .withOpacity(0.3), // Highlight color when selected
      onTap: () {
        onTap();
        Navigator.pop(context); // Close the drawer after item is tapped
      },
      splashColor: const Color(0xFF4CAF50)
          .withOpacity(0.3), // Ripple effect when pressed
    );
  }
}

// Dark Mode Toggle Widget
class DarkModeToggle extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const DarkModeToggle({super.key, 
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: const Color(0xFF4CAF50), // Green color
      ),
      title: Text(
        'Dark Mode',
        style: const TextStyle(color: Color(0xFF4CAF50), fontSize: 18),
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (bool value) {
          onDarkModeChanged(value);
        },
      ),
      onTap: () {},
    );
  }
}

// Logout Menu Item Widget
class LogoutMenuItem extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutMenuItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        color: Color(0xFF4CAF50),
      ),
      title: const Text(
        'Keluar',
        style: TextStyle(color: Color(0xFF4CAF50), fontSize: 18),
      ),
      onTap: onTap,
    );
  }
}
