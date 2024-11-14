import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar Section with user info horizontally aligned
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueAccent, width: 4),
                    image: DecorationImage(
                      image: AssetImage('assets/profile.jpeg'), // Gambar avatar
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Zaki Mahran', // Nama Pengguna
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Flutter Developer', // Deskripsi Pekerjaan
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            // Profile Options Section (Vertically aligned)
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: 'muhammad.zaki15@mhs.itenas.ac.id',
                  ),
                  _buildProfileOption(
                    icon: Icons.phone,
                    title: 'Phone',
                    subtitle: '+62-813-2413-3867',
                  ),
                  _buildProfileOption(
                    icon: Icons.location_on,
                    title: 'Location',
                    subtitle: 'Bandung',
                  ),
                  _buildProfileOption(
                    icon: Icons.date_range,
                    title: 'Birthdate',
                    subtitle: 'Oct 15, 2003',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat opsi profil tanpa onTap
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16), // Menambahkan margin bawah
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.blueAccent,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
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
