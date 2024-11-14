import 'package:flutter/material.dart';
import 'package:zaki_mobile/login.dart'; // Pastikan LoginPage diimpor

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _enableNotifications = true;  // Untuk menyimpan status Switch
  bool _darkTheme = false;  // Untuk menyimpan status tema gelap
  bool _changePassword = false;  // Untuk status ganti password
  bool _soundEffects = true;  // Status untuk Sound Effects
  bool _speaking = false;  // Status untuk Speaking
  bool _listening = true;  // Status untuk Listening
  bool _incognito = false;  // Status untuk Incognito Mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF22252D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                'Enable Notifications',
                style: TextStyle(color: Colors.white),
              ),
              value: _enableNotifications,
              onChanged: (value) {
                setState(() {
                  _enableNotifications = value; // Update state saat switch berubah
                });
              },
              activeColor: Colors.blue, // Warna aktif switch
              inactiveThumbColor: Colors.grey, // Warna switch tidak aktif
              inactiveTrackColor: Colors.grey[600], // Warna track tidak aktif
            ),
            SwitchListTile(
              title: Text(
                'Change Theme',
                style: TextStyle(color: Colors.white),
              ),
              value: _darkTheme,
              onChanged: (value) {
                setState(() {
                  _darkTheme = value; // Update state tema
                });
                // Anda bisa menambahkan logika untuk mengganti tema di sini
              },
              activeColor: Colors.blue, // Warna aktif switch
              inactiveThumbColor: Colors.grey, // Warna switch tidak aktif
              inactiveTrackColor: Colors.grey[600], // Warna track tidak aktif
            ),
            SwitchListTile(
              title: Text(
                'Sound Effects',
                style: TextStyle(color: Colors.white),
              ),
              value: _soundEffects,
              onChanged: (value) {
                setState(() {
                  _soundEffects = value; // Update status sound effects
                });
              },
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[600],
            ),
            SwitchListTile(
              title: Text(
                'Speaking',
                style: TextStyle(color: Colors.white),
              ),
              value: _speaking,
              onChanged: (value) {
                setState(() {
                  _speaking = value; // Update status speaking
                });
              },
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[600],
            ),
            SwitchListTile(
              title: Text(
                'Listening',
                style: TextStyle(color: Colors.white),
              ),
              value: _listening,
              onChanged: (value) {
                setState(() {
                  _listening = value; // Update status listening
                });
              },
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[600],
            ),
            SwitchListTile(
              title: Text(
                'Incognito Mode',
                style: TextStyle(color: Colors.white),
              ),
              value: _incognito,
              onChanged: (value) {
                setState(() {
                  _incognito = value; // Update status incognito mode
                });
              },
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[600],
            ),
            SizedBox(height: 40),
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                'Change Password',
                style: TextStyle(color: Colors.white),
              ),
              value: _changePassword,
              onChanged: (value) {
                setState(() {
                  _changePassword = value; // Update status ganti password
                });
                // Aksi untuk ganti password bisa ditambahkan di sini
              },
              activeColor: Colors.blue, // Warna aktif switch
              inactiveThumbColor: Colors.grey, // Warna switch tidak aktif
              inactiveTrackColor: Colors.grey[600], // Warna track tidak aktif
            ),
            SizedBox(height: 20),
            // Logout dengan ikon
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red, // Warna ikon logout merah
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Aksi untuk logout, misalnya kembali ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Ganti dengan halaman LoginPage
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
