import 'package:flutter/material.dart';

class TemperatureConverterPage extends StatefulWidget {
  @override
  _TemperatureConverterPageState createState() =>
      _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  String _selectedUnit = 'Celsius'; // Default unit is Celsius
  final TextEditingController _controller = TextEditingController();

  // Results for conversion
  double _celsiusResult = 0;
  double _fahrenheitResult = 0;
  double _kelvinResult = 0;

  // List for dropdown options
  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  void _convertTemperature() {
    setState(() {
      if (_controller.text.isEmpty) {
        _resetResults();
        return;
      }

      double input = double.tryParse(_controller.text) ?? 0;

      // Conversion based on selected unit
      double inCelsius;
      switch (_selectedUnit) {
        case 'Celsius':
          inCelsius = input; // Already in Celsius
          break;
        case 'Fahrenheit':
          inCelsius = (input - 32) * 5 / 9; // Fahrenheit to Celsius formula
          break;
        case 'Kelvin':
          inCelsius = input - 273.15; // Kelvin to Celsius formula
          break;
        default:
          inCelsius = 0;
      }

      // Convert from Celsius to all units
      _celsiusResult = inCelsius;
      _fahrenheitResult = (inCelsius * 9 / 5) + 32; // Celsius to Fahrenheit formula
      _kelvinResult = inCelsius + 273.15; // Celsius to Kelvin formula
    });
  }

  void _resetResults() {
    setState(() {
      _celsiusResult = 0;
      _fahrenheitResult = 0;
      _kelvinResult = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion'),
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
                              _convertTemperature();
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
                                  _convertTemperature();
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
                Expanded(child: _buildResultBox('Celsius', _celsiusResult)),
                SizedBox(width: 16),
                Expanded(child: _buildResultBox('Fahrenheit', _fahrenheitResult)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildResultBox('Kelvin', _kelvinResult)),
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
