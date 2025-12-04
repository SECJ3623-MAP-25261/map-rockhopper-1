import 'dart:async';
import 'package:flutter/material.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  int _secondsRemaining = 60;
  late Timer _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _onOTPChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    if (_isAllFieldsFilled()) {
      _verifyOTP();
    }
  }

  bool _isAllFieldsFilled() {
    for (var controller in _otpControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void _verifyOTP() {
    String otp = _otpControllers.map((controller) => controller.text).join();
    
    if (otp.length == 6) {
      _showSnackBar('OTP verified successfully!');
      print('OTP verified: $otp for email: ${widget.email}');
    }
  }

  void _resendOTP() {
    setState(() {
      _secondsRemaining = 60;
      _canResend = false;
      for (var controller in _otpControllers) {
        controller.clear();
      }
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
    
    _startTimer();
    _showSnackBar('New OTP sent to your email');
    print('Resending OTP to: ${widget.email}');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A 6-digit verification code has been sent to ${widget.email}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                'enter the code',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: TextFormField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration:  InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) => _onOTPChanged(index, value),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isAllFieldsFilled() ? _verifyOTP : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'VERIFY',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Center(
                child: Column(
                  children: [
                    const Text(
                      "didn't get the code?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _canResend
                        ? TextButton(
                            onPressed: _resendOTP,
                            child: const Text(
                              'Resend',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : Text(
                            'Resend in ${_secondsRemaining}s',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}