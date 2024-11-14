import 'package:flutter/material.dart';

class SpeedConverterPage extends StatefulWidget {
  @override
  _SpeedConverterPageState createState() => _SpeedConverterPageState();
}

class _SpeedConverterPageState extends State<SpeedConverterPage> {
  String _selectedUnit = 'm/s'; // Default unit is meters per second
  final TextEditingController _controller = TextEditingController();

  // Results for conversion
  double _msResult = 0;
  double _kmhResult = 0;
  double _mphResult = 0;
  double _fpsResult = 0;

  // List for dropdown options
  final List<String> _units = ['m/s', 'km/h', 'mph', 'ft/s'];

  void _convertSpeed() {
    setState(() {
      if (_controller.text.isEmpty) {
        _resetResults();
        return;
      }

      double input = double.tryParse(_controller.text) ?? 0;

      // Convert to meters per second (m/s) as the base unit
      double inMps;
      switch (_selectedUnit) {
        case 'm/s':
          inMps = input; // Already in meters per second
          break;
        case 'km/h':
          inMps = input / 3.6; // 1 km/h = 1/3.6 m/s
          break;
        case 'mph':
          inMps = input * 0.44704; // 1 mph = 0.44704 m/s
          break;
        case 'ft/s':
          inMps = input * 0.3048; // 1 ft/s = 0.3048 m/s
          break;
        default:
          inMps = 0;
      }

      // Convert from meters per second to all units
      _msResult = inMps;
      _kmhResult = inMps * 3.6; // 1 m/s = 3.6 km/h
      _mphResult = inMps / 0.44704; // 1 m/s = 2.23694 mph
      _fpsResult = inMps / 0.3048; // 1 m/s = 3.28084 ft/s
    });
  }

  void _resetResults() {
    setState(() {
      _msResult = 0;
      _kmhResult = 0;
      _mphResult = 0;
      _fpsResult = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speed Conversion'),
        centerTitle: true,
        backgroundColor: Colors.blue, // Set background to blue
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Section
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Masukkan Nilai',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Change color to black
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Masukkan angka',
                            ),
                            style: TextStyle(color: Colors.black), // Change text color to black
                            onChanged: (value) {
                              _convertSpeed();
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedUnit,
                              isExpanded: true,
                              underline: SizedBox(),
                              dropdownColor: Colors.blue.shade900, // Set dropdown background to blue
                              items: _units.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black), // Change text color to black
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedUnit = newValue!;
                                  _convertSpeed();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Results Section
            Text(
              'Hasil Konversi:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900, // Contrast color for text
              ),
            ),
            SizedBox(height: 16),
            // Result Boxes aligned in two columns (left and right)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildResultBox('m/s', _msResult)),
                SizedBox(width: 16),
                Expanded(child: _buildResultBox('km/h', _kmhResult)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildResultBox('mph', _mphResult)),
                SizedBox(width: 16),
                Expanded(child: _buildResultBox('ft/s', _fpsResult)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBox(String unit, double value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              unit,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value.toStringAsFixed(4),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade900, // Contrast color for text
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
