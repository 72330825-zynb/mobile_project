import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mainPage.dart';


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        //Image lm8bshe    
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('images/homeblurr.jpg', fit: BoxFit.cover,),
            ),


          
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Text('Create your own itinerary',
                textAlign: TextAlign.center,
                style: 
                 TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                ),
                ),
                ),
                ),




          // card m3 l inputs yle ela
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45, //responsive, 3ala lmobile 45% mn lscreen
              margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 20),
              child: Card(
                color: Color(0xFFE1DBDD),
                elevation: 20,//shadow ll scren
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),),
                child: Padding(
                  padding: const EdgeInsets.all(20.0), //padding ll input
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                
                    Text(
                   'Login',
                   style: GoogleFonts.dmSerifText(
                   fontSize: 32,
                   color: Color(0xFF373854),
                   letterSpacing: 1.2,
                    ),),

                                                           SizedBox(height: 25),
                     
                     //bdayet ft input
                      Container(
                        width: 250,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Color(0xFF373854),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 10),
                            Expanded(//e5od kel l width lbe2e kl lmsa7a lfadye
                              child: TextField(
                                decoration: InputDecoration(hintText: 'Name',
                                                            hintStyle:
                                                               TextStyle(color: Colors.white70),
                                                               border: InputBorder.none, ),
                                style: TextStyle(color: Colors.white),
                              ),
                              ),
                              ],
                              ),
                              ),

                      SizedBox(height: 15),

                      // tane input
                      Container(
                        width: 250,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Color(0xFF373854),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.lock, color: Colors.white),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                obscureText: true,//hide l password
                                decoration: InputDecoration(hintText: 'Password',
                                                            hintStyle:
                                                               TextStyle(color: Colors.white70),
                                                               border: InputBorder.none, ),
                                style: TextStyle(color: Colors.white),
                              ),
                              ),
                              ],
                              ),
                              ),

                                                           SizedBox(height: 25),

                      //submit input 
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                          onPressed: () {
                               Navigator.of(context).push(
                               MaterialPageRoute(
                               builder: (context) => MainPage(),
                          ),
                        );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text('Sign in',
                            style: TextStyle(
                              color: Color(0xFF373854),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                            ),
                            ),
                            ],
                            ),
                            ),
                            ),
                            ),
                            ),
                            ],
                            ),
                            );
                            }
                            }







