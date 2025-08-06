import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  final VoidCallback onConfirmed;

  const ConfirmationDialog({Key? key, required this.onConfirmed}) : super(key: key);

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  final String _targetText = 'I KNOW WHAT I AM DOING';
  String _currentText = '';


  bool get _isComplete => _currentText == _targetText;

  void _addLetter(String letter) {
    if (_currentText.length < _targetText.length) {
      setState(() {
        _currentText += letter;
      });
    }
  }

  void _removeLetter() {
    if (_currentText.isNotEmpty) {
      setState(() {
        _currentText = _currentText.substring(0, _currentText.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Confirm Kill Switch Activation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Text field display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600]!),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[800],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _currentText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'monospace',
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Target text display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600]!),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[800],
              ),
              child: Text(
                _targetText,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  fontFamily: 'monospace',
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            
            // Text field display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600]!),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[800],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _currentText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'monospace',
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Custom keyboard
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // First row
                  _buildKeyboardRow(['A', 'B', 'C', 'D', 'E', 'F', 'G']),
                  const SizedBox(height: 8),
                  // Second row
                  _buildKeyboardRow(['H', 'I', 'J', 'K', 'L', 'M', 'N']),
                  const SizedBox(height: 8),
                  // Third row
                  _buildKeyboardRow(['O', 'P', 'Q', 'R', 'S', 'T', 'U']),
                  const SizedBox(height: 8),
                  // Fourth row
                  _buildKeyboardRow(['V', 'W', 'X', 'Y', 'Z']),
                  const SizedBox(height: 12),
                  // Backspace button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _currentText.isNotEmpty ? _removeLetter : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Backspace',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isComplete ? () {
                      Navigator.of(context).pop();
                      widget.onConfirmed();
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isComplete ? Colors.green : Colors.grey[700],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboardRow(List<String> letters) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: letters.map((letter) => _buildKeyButton(letter)).toList(),
    );
  }

  Widget _buildKeyButton(String letter) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _addLetter(letter),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}