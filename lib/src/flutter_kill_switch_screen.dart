import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'confirmation_dialog.dart';
import 'kill_switch_service.dart';

class FlutterKillSwitch extends StatefulWidget {
  const FlutterKillSwitch({Key? key}) : super(key: key);

  @override
  State<FlutterKillSwitch> createState() => _FlutterKillSwitchState();
}

class _FlutterKillSwitchState extends State<FlutterKillSwitch> {
  bool _isKillSwitchEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadKillSwitchState();
  }

  Future<void> _loadKillSwitchState() async {
    try {
      final state = await KillSwitchService.getKillSwitchState();
      setState(() {
        _isKillSwitchEnabled = state;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSwitchChanged(bool value) {
    if (value) {
      // Show confirmation dialog when enabling
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ConfirmationDialog(
          onConfirmed: () async {
            await KillSwitchService.updateKillSwitchState(true);
            setState(() {
              _isKillSwitchEnabled = true;
            });
          },
        ),
      );
    } else {
      // Directly disable without confirmation
      _updateKillSwitch(false);
    }
  }

  Future<void> _updateKillSwitch(bool value) async {
    await KillSwitchService.updateKillSwitchState(value);
    setState(() {
      _isKillSwitchEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Kill Switch Title
                  const Text(
                    'KILL SWITCH',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 80),

                  // Cupertino Switch (larger)
                  Transform.scale(
                    scale: 2.5,
                    child:                     CupertinoSwitch(
                      value: _isKillSwitchEnabled,
                      onChanged: _onSwitchChanged,
                      activeTrackColor: Colors.green,
                      trackColor: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 80),

                  // Warning Text
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: const Text(
                      'Warning: Disabling the kill switch may expose your data to the network.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Status Text
                  Text(
                    _isKillSwitchEnabled ? 'ENABLED' : 'DISABLED',
                    style: TextStyle(
                      color: _isKillSwitchEnabled ? Colors.green : Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}