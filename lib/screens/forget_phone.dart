import 'package:country_picker/country_picker.dart';
import 'package:ev_charger/main.dart';
import 'package:ev_charger/provider/auth_provider.dart';
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
      appBar: AppBar(
        backgroundColor: backgroundwhite,
        elevation: 0,
        leading: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              ),
              icon: Icon(Icons.arrow_back_ios_new),
              color: backgroundblue,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: backgroundwhite,
                    child: Image.asset("images/mobile.png"),
                  ),
                  Container(
                    child: const Column(
                      children: [
                        Text(
                          'Forget Password',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3.2,
                              color: Text1),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Please enter your phone and we will send you a link to return to your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: text3,
                              fontSize: 16,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.purple,
                      controller: phoneController,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: Text1),
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: backgroundblue,
                            fontWeight: FontWeight.w500),
                        hintText: "Enter phone Number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: text3,
                            letterSpacing: 2,
                            fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                },
                              );
                            },
                            child: Text(
                              "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Text1,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        suffixIcon: phoneController.text.length > 9
                            ? Container(
                                height: 30,
                                width: 30,
                                margin: const EdgeInsets.all(20.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                  Container(),
                  Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => sentPhoneNumber(),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15.0),
                              fixedSize: const Size(300, 50),
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 3),
                              primary: backgroundblue,
                              elevation: 10,
                              shadowColor: backgroundblue,
                              shape: const StadiumBorder()),
                          child: const Text(
                            "CONTINUE",
                            style:
                                TextStyle(fontSize: 20, color: backgroundwhite),
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  void sentPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
