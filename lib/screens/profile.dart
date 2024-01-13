import 'package:ev_charger/main.dart';
import 'package:ev_charger/provider/sign_in_provider.dart';
import 'package:ev_charger/screens/forget_email_reset.dart';
import 'package:ev_charger/utils/next_Screen.dart';
import 'package:ev_charger/widgetd/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Future getData() async {
    final sp = context.read<SignInProvide>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvide>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Profile",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textmain3,
        ),
        ),

      ),

      body: SafeArea(
        child:Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage("images/profile_img.jpg"),
                        ),
                    )
                  ),
                  Positioned(
                    right: 0,
                      bottom: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(100),
                          color: buttoncolors

                        ),
                        child: Icon(Icons.camera_alt_outlined, color: Colors.white,),

                      ),
                  ),
                ],
              ),
            Container(
              width: MediaQuery.of(context).size.width,
            ),
              SizedBox(height: 50,),
              
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                   Container(
                     padding: EdgeInsets.all(5),
                     height: 70,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Color(0xFFF7F0F0)

                     ),
                     child: ListTile(
                       leading: Icon(Icons.person_outlined,color: buttoncolors,),
                       title:  Text('Username'),
                       trailing: Text('Ratchanon', style: TextStyle(color: buttoncolors),),
                     ),
                   ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF7F0F0)

                      ),
                      child: ListTile(
                        leading: Icon(Icons.email_outlined,color: buttoncolors,),
                        title:  Text('Email'),
                        trailing: Text('Ratchanon190944@gmail.com ', style: TextStyle(color: buttoncolors),),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF7F0F0)

                      ),
                      child: ListTile(
                        leading: Icon(Icons.call_outlined,color: buttoncolors,),
                        title:  Text('Telephone'),
                        trailing: Text('0973504796', style: TextStyle(color: buttoncolors),),
                      ),
                    ),

                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF7F0F0)

                      ),
                      child: ListTile(
                        leading: Icon(Icons.lock_outline,color: buttoncolors,),
                        title:  Text('Reset Password'),
                        trailing: IconButton(
                          onPressed: (){ nextScreen(context, ForgotResetEmail());},
                          icon: Icon(Icons.chevron_right_outlined),
                        )
                      ),
                    ),


                    SizedBox(height: 30),
                    CustomButton(text: "LogOut", onPressed: (){

                    })
                  ],
                ),
              )


            ],
          ),
        )
      ),
    );
  }

  Widget textfilewidget({
    required IconData leading,
    required String title,
    required String trailing,
  }) =>
      ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Colors.lightBlue),
            borderRadius: BorderRadius.circular(20)),
        leading: Icon(leading),
        title: Text(title),
        trailing: Text(trailing),
      );




}
