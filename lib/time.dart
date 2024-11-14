import 'package:flutter/material.dart';

class TimeConverterPage extends StatefulWidget {
  @override
  _TimeConverterPageState createState() => _TimeConverterPageState();
}

class _TimeConverterPageState extends State<TimeConverterPage> {
  String _selectedUnit = 'Seconds'; // Default unit is seconds
  final TextEditingController _controller = TextEditingController();

  // Results for conversion
  double _secondsResult = 0;
  double _minutesResult = 0;
  double _hoursResult = 0;
  double _daysResult = 0;

  // List for dropdown options
  final List<String> _units = ['Seconds', 'Minutes', 'Hours', 'Days'];

  void _convertTime() {
    setState(() {
      if (_controller.text.isEmpty) {
        _resetResults();
        return;
      }

      double input = double.tryParse(_controller.text) ?? 0;

      // Convert to seconds as the base unit
      double inSeconds;
      switch (_selectedUnit) {
        case 'Seconds':
          inSeconds = input; // Already in seconds
          break;
        case 'Minutes':
          inSeconds = input * 60; // 1 minute = 60 seconds
          break;
        case 'Hours':
          inSeconds = input * 3600; // 1 hour = 3600 seconds
          break;
        case 'Days':
          inSeconds = input * 86400; // 1 day = 86400 seconds
          break;
        default:
          inSeconds = 0;
      }

      // Convert from seconds to all units
      _secondsResult = inSeconds;
      _minutesResult = inSeconds / 60; // 1 second = 1/60 minute
      _hoursResult = inSeconds / 3600; // 1 second = 1/3600 hour
      _daysResult = inSeconds / 86400; // 1 second = 1/86400 day
    });
  }

  void _resetResults() {
    setState(() {
      _secondsResult = 0;
      _minutesResult = 0;
      _hoursResult = 0;
      _daysResult = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Conversion'),
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
                              _convertTime();
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
                                  _convertTime();
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
                Expanded(child: _buildResultBox('Seconds', _secondsResult)),
                SizedBox(width: 16),
                Expanded(child: _buildResultBox('Minutes', _minutesResult)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildResultBox('Hours', _hoursResult)),
                SizedBox(width: 16),
                Expanded(child: _buildResultBox('Days', _daysResult)),
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
