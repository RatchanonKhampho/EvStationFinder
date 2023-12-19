import 'package:country_picker/country_picker.dart';
import 'package:ev_charger/main.dart';
import 'package:ev_charger/provider/sign_in_provider.dart';
import 'package:ev_charger/screens/register.dart';
import 'package:ev_charger/widgetd/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPhone extends StatefulWidget {
  const ForgetPhone({super.key});

  @override
  State<ForgetPhone> createState() => _ForgetPhoneState();
}

class _ForgetPhoneState extends State<ForgetPhone> {
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
      phoneCode: "66",
      countryCode: "TH",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Thailand",
      example: "Thailand",
      displayName: "Thailand",
      displayNameNoCountryCode: "TH",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  children: [
                    Text(
                      "Forgot Your Password",
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: textmain,
                        //letterSpacing: 1
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Please enter your phone and we will send you a link to return to your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textmain3,
                          fontSize: 14,
                          //letterSpacing: 2,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      cursorColor: buttoncolors,
                      controller: phoneController,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: textmain2),
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Enter your telephone number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textmain3,
                            fontSize: 14),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: buttoncolors),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: buttoncolors),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: buttoncolors),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  bottomSheetHeight: 650,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                },
                              );
                            },
                            child: Text(
                              "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: textmain2,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        suffixIcon: phoneController.text.length > 9
                            ? Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.all(20.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomButtonNext(
                        text: "CONTINUE", onPressed: sentPhoneNumber),
                    SizedBox(height: 20),
                    Text(
                      "Don’t have an account? ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textmain2),
                    ),
                    SizedBox(height: 20),
                    CustomButtonback(
                      text: "SigUp",
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => register()),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sentPhoneNumber() {
    final ap = Provider.of<SignInProvide>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
