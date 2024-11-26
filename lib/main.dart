import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  final List<List<String>> buttons = [
    ['C', '≪', '( )', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '+'],
    ['1', '2', '3', '-'],
    ['0', '.', 'EE', '='],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: [
            // Ekran qismi
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '2400',
                  style: TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Tugmalar qismi
            Expanded(
              flex: 6,
              child: GridView.builder(
                padding: EdgeInsets.all(12.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Har qator ustunlar soni
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: buttons.expand((row) => row).length,
                itemBuilder: (context, index) {
                  final rowIndex = index ~/ 4;
                  final colIndex = index % 4;
                  final buttonLabel = buttons[rowIndex][colIndex];

                  if (buttonLabel == '( )') {
                    // Agar `( )` tugmasi bo'lsa, ikkiga bo'linadi
                    return VerticalSplitButton();
                  }

                  return CalculatorButton(
                    label: buttonLabel,
                    onTap: () {
                      print('Button pressed: $buttonLabel');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CalculatorButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isNumber = RegExp(r'^\d$|^\.$').hasMatch(label); // Agar raqam yoki nuqta bo'lsa
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
           color: isNumber ? Colors.grey[800] : Colors.black54, // Raqamlar va nuqta pushti, boshqa tugmalar black87
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold, // Bold qilish
              color: label == '='
                  ? Colors.white
                  : (isNumber ? Colors.pinkAccent : Colors.lightBlueAccent), // Raqamlar pushti, boshqa tugmalar oq
            ),
          ),
        ),
      ),
    );
  }
}

class VerticalSplitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              print('Button pressed: (');
            },
            child: Container(
              margin: EdgeInsets.only(right: 4), // O'ng tomonda bo'shliq
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius:
                    BorderRadius.circular(14), // Barcha tomonlardan radius
              ),
              child: Center(
                child: Text(
                  '(',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              print('Button pressed: )');
            },
            child: Container(
              margin: EdgeInsets.only(left: 4), // Chap tomonda bo'shliq
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius:
                    BorderRadius.circular(14), // Barcha tomonlardan radius
              ),
              child: Center(
                child: Text(
                  ')',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
