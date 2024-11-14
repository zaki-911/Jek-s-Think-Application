import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

class CurrencyConverterPage extends StatefulWidget {
  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  String _selectedFromCurrency = 'IDR'; // Default from currency is Indonesian Rupiah
  String _selectedToCurrency = 'USD'; // Default to currency is US Dollar
  final TextEditingController _controller = TextEditingController();

  // Currency conversion rates (dummy values)
  final Map<String, double> _conversionRates = {
    'IDR': 1.0, // Indonesian Rupiah
    'USD': 0.000065, // 1 IDR = 0.000065 USD
    'GBP': 0.000052, // 1 IDR = 0.000052 GBP
    'EUR': 0.000060, // 1 IDR = 0.000060 EUR
    'ESP': 0.000059, // 1 IDR = 0.000059 ESP
    'SAR': 0.00024, // 1 IDR = 0.00024 SAR
    'MYR': 0.00029, // 1 IDR = 0.00029 MYR
  };

  double _convertedValue = 0;

  // List of currencies for dropdown
  final List<String> _currencies = [
    'IDR', 'USD', 'GBP', 'EUR', 'ESP', 'SAR', 'MYR'
  ];

  // Function to format the input as a number with a thousands separator
  String _formatNumber(String input) {
    if (input.isEmpty) return '';
    final formatter = NumberFormat("#,###", "en_US");
    try {
      final number = double.parse(input.replaceAll(',', ''));
      return formatter.format(number);
    } catch (e) {
      return input;
    }
  }

  // Function to format the converted result without decimals
  String _formatResult(double value) {
    final formatter = NumberFormat("#,###", "en_US"); // No decimals
    return formatter.format(value.round()); // Round to the nearest integer
  }

  void _convertCurrency() {
    setState(() {
      if (_controller.text.isEmpty) {
        _resetConvertedValue();
        return;
      }

      double input = double.tryParse(_controller.text.replaceAll(',', '')) ?? 0;

      // Conversion logic
      double fromRate = _conversionRates[_selectedFromCurrency] ?? 1.0;
      double toRate = _conversionRates[_selectedToCurrency] ?? 1.0;

      // Conversion formula: (Input value / From currency rate) * To currency rate
      _convertedValue = (input / fromRate) * toRate;
    });
  }

  void _resetConvertedValue() {
    setState(() {
      _convertedValue = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Conversion'),
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
                              setState(() {
                                _controller.text = _formatNumber(value);
                                _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
                              });
                              _convertCurrency();
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
                              value: _selectedFromCurrency,
                              isExpanded: true,
                              underline: SizedBox(),
                              dropdownColor: Colors.blue.shade900, // Set dropdown background to blue
                              items: _currencies.map<DropdownMenuItem<String>>((String value) {
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
                                  _selectedFromCurrency = newValue!;
                                  _convertCurrency();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Ke Mata Uang',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Change color to black
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedToCurrency,
                        isExpanded: true,
                        underline: SizedBox(),
                        dropdownColor: Colors.blue.shade900, // Set dropdown background to blue
                        items: _currencies.map<DropdownMenuItem<String>>((String value) {
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
                            _selectedToCurrency = newValue!;
                            _convertCurrency();
                          });
                        },
                      ),
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
            // Result Box
            Card(
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
                      'Converted Amount',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _formatResult(_convertedValue),
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
