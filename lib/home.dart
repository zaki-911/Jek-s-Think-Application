import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zaki_mobile/bmi.dart'; 
import 'package:zaki_mobile/calculator.dart';
import 'package:zaki_mobile/currency.dart';
import 'package:zaki_mobile/discount.dart'; 
import 'package:zaki_mobile/mass.dart';
import 'package:zaki_mobile/profile.dart'; 
import 'package:zaki_mobile/setting.dart';
import 'package:zaki_mobile/speed.dart';
import 'package:zaki_mobile/temperature.dart';
import 'package:zaki_mobile/time.dart'; 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Awal berada di halaman Home

  // Fungsi untuk menangani navigasi ke halaman sesuai index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi ke halaman yang sesuai berdasarkan index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()), // Navigasi ke ProfilePage
        );
        break;
      case 1:
        // Tetap di halaman Home (Tidak perlu aksi apapun)
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()), // Navigasi ke SettingsPage
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Home'),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false, // Menghapus ikon back di kiri atas
      ),
      body: SingleChildScrollView( // Membuat seluruh body bisa digulir
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Welcome Text with Animation
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 1),
              child: Text(
                'Welcome Back, Zaki',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36, // Ukuran font lebih besar
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.blueAccent,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 1),
              child: Text(
                'Explore your dashboard',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7), // Warna lebih soft
                  fontSize: 18, // Ukuran font lebih kecil
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.blueAccent,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Box for Date and Time with beach-like gradient color
            Container(
              width: double.infinity, // Membuat container mengisi seluruh lebar layar
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.green], // Warna biru muda dan hijau seperti pantai
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: StreamBuilder<DateTime>( // Realtime stream untuk waktu
                stream: Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  DateTime currentTime = snapshot.data!;
                  String formattedDay = DateFormat('EEEE').format(currentTime); // Format Hari
                  String formattedTime = DateFormat('HH:mm').format(currentTime); // Format Jam
                  String formattedDate = DateFormat('dd MMMM yyyy').format(currentTime); // Format Tanggal
                  
                  return Column(
                    children: [
                      Text(
                        formattedDay, // Menampilkan Hari
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36, // Ukuran font besar untuk Hari
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        formattedTime, // Menampilkan Jam
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24, // Ukuran font sedang untuk Jam
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        formattedDate, // Menampilkan Tanggal
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16, // Ukuran font kecil untuk Tanggal
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Grid Menu
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true, // Agar GridView tidak mengambil ruang lebih
              physics: NeverScrollableScrollPhysics(), // Menonaktifkan scroll GridView agar hanya body yang scrollable
              children: [
                _buildMenuItem(
                  icon: Icons.monetization_on,
                  title: 'Currency',
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CurrencyConverterPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.accessibility,
                  title: 'BMI',
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BMICalculatorPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.thermostat,
                  title: 'Temperature',
                  onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TemperatureConverterPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.discount,
                  title: 'Discount',
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiscountPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.fitness_center,
                  title: 'Mass',
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeightConverterPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.speed,
                  title: 'Speed',
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpeedConverterPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.timer,
                  title: 'Time',
                  onTap: () {
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimeConverterPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.calculate,
                  title: 'Calculator',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CalculatorPage()), // Navigasi ke halaman kalkulator
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.blueAccent, // Warna biru
          selectedItemColor: Colors.white, // Warna ikon yang terpilih
          unselectedItemColor: Colors.grey[300], // Warna ikon yang tidak terpilih
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 10, // Memberikan efek bayangan
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat item menu dengan logo berwarna gradasi biru dan hijau
  Widget _buildMenuItem(
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850], // Background menu tetap gelap
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo dengan gradasi biru dan hijau yang lebih sedikit
            Container(
              padding: EdgeInsets.all(16), // Memberikan ruang di sekitar ikon
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightGreenAccent], // Gradasi biru dan hijau yang lebih lembut
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(50), // Membuat logo menjadi bulat
              ),
              child: Icon(
                icon,
                size: 60, // Ukuran ikon lebih besar
                color: Colors.white, // Warna ikon putih
              ),
            ),
            SizedBox(height: 8),
            Text(
              title, // Menampilkan judul
              style: TextStyle(
                color: Colors.white,
                fontSize: 16, // Ukuran font yang lebih besar
                fontWeight: FontWeight.bold, // Menebalkan teks
              ),
            ),
          ],
        ),
      ),
    );
  }
}
