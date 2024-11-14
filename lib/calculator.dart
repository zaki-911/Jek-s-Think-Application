import 'dart:math'; // Tambahkan ini di bagian atas file

import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  double _result = 0;
  bool _isNewNumber = true;
  String _operation = '';
  String _previousDisplay = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF22252D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF22252D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Navigate back to home.dart
          },
        ),
        title: Text(
          'Standard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.aspect_ratio_outlined),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.history),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Display
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _previousDisplay,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    _display,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Calculator Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('%'),
                    _buildButton('CE'),
                    _buildButton('C'),
                    _buildButton('⌫'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('⅟x'),
                    _buildButton('x²'),
                    _buildButton('²√x'),
                    _buildButton('÷'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('×'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('+'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('+/-'),
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildEqualsButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(20),
            backgroundColor: _getButtonColor(text),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () => _handleButton(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEqualsButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () => _handleEquals(),
          child: Text(
            '=',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String text) {
    if ('0123456789.'.contains(text)) {
      return Color(0xFF2A2D37);
    } else {
      return Color(0xFF2A2D37).withOpacity(0.9);
    }
  }

  void _handleButton(String text) {
    setState(() {
      if ('0123456789.'.contains(text)) {
        if (_isNewNumber) {
          _display = text;
          _isNewNumber = false;
        } else {
          _display += text;
        }
      } else if ('+-×÷'.contains(text)) {
        _operation = text;
        _previousDisplay = _display + ' $_operation ';
        _result = double.parse(_display);
        _isNewNumber = true;
      } else if (text == 'C' || text == 'CE') {
        _display = '0';
        _result = 0;
        _operation = '';
        _previousDisplay = '';
        _isNewNumber = true;
      } else if (text == '⌫') {
        if (_display.length > 1) {
          _display = _display.substring(0, _display.length - 1);
        } else {
          _display = '0';
          _isNewNumber = true;
        }
      } else if (text == '%') {
        _result = double.parse(_display);
        _display = (_result / 100).toString();
        _isNewNumber = true;
      } else if (text == '⅟x') {
        _result = double.parse(_display);
        _display = (1 / _result).toString();
        _isNewNumber = true;
      } else if (text == 'x²') {
        _result = double.parse(_display);
        _display = (_result * _result).toString();
        _isNewNumber = true;
      } else if (text == '²√x') {
        _result = double.parse(_display);
        _display = (sqrt(_result)).toString();  // sqrt will now work
        _isNewNumber = true;
      }
    });
  }

  void _handleEquals() {
    setState(() {
      double secondNumber = double.parse(_display);
      switch (_operation) {
        case '+':
          _display = (_result + secondNumber).toStringAsFixed(0); // Avoid decimal if not needed
          break;
        case '-':
          _display = (_result - secondNumber).toStringAsFixed(0);
          break;
        case '×':
          _display = (_result * secondNumber).toStringAsFixed(0);
          break;
        case '÷':
          _display = (_result / secondNumber).toStringAsFixed(0);
          break;
      }
      _previousDisplay = '';
      _isNewNumber = true;
    });
  }
}
