// ignore: unused_import
import 'package:ev_charger/main.dart';
import 'package:ev_charger/provider/sign_in_provider.dart';
import 'package:ev_charger/screens/Forgot%20password.dart';
import 'package:ev_charger/screens/create_password.dart';
import 'package:ev_charger/utils/utils.dart';
import 'package:ev_charger/widgetd/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class Forget_otp extends StatefulWidget {
  final String verificationId;
  const Forget_otp({super.key, required this.verificationId});

  @override
  State<Forget_otp> createState() => _Forget_otpState();
}

class _Forget_otpState extends State<Forget_otp> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<SignInProvide>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: buttoncolors,
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      Container(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPhone()),
                            ),
                            icon: Icon(Icons.arrow_back_ios_new),
                            color: textmain3,
                          ),
                          title: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Reset Password",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: textmain3),
                              )),
                          trailing: Text(""),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Column(
                            children: [
                              Text(
                                "Verification",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Enter the OTP send to your phone number",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Pinput(
                                length: 6,
                                showCursor: true,
                                defaultPinTheme: PinTheme(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: buttoncolors),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onCompleted: (value) {
                                  setState(() {
                                    otpCode = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: CustomButton(
                                  text: "Verify",
                                  onPressed: () {
                                    if (otpCode != null) {
                                      verifyOtp(context, otpCode!);
                                    } else {
                                      showSnackBar(
                                          context, "Enter 6-Digit code");
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Didn't receive any code?",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Resend New Code",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                  color: buttoncolors,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<SignInProvide>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatePassword()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
