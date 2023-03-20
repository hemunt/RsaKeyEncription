import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rsa_message_encription/Screens/EncryptMessage.dart';
import 'package:rsa_message_encription/Screens/GenerateKeyScreen.dart';

import '../AppConstent/Colors.dart';
import '../Components/MyIconButton.dart';
import '../Controller/EncryptionScreenController.dart';
import '../Controller/GenerareKeyScreenController.dart';
import '../KeyGenerator/RsaKeyHelper.dart';
import '../TextField/AppTextField.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Size? screenSize;
  double? width;
  double? height;
  int _selectedIndex = 0;
  bool isLoading = false;
  String? privateKey = "";
  String encryptedData = "";
  String realText = "Your Message Here...";
  final PageController _pageController = PageController();
  EncryptionScreenController controller = Get.put(EncryptionScreenController());
  GenerateKeyScreenController controller2 =
      Get.put(GenerateKeyScreenController());

  @override
  void initState() {
    screenSize = WidgetsBinding.instance.window.physicalSize;
    width = screenSize?.width;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _selectedIndex == 0 ? FloatingActionButton.extended(label: const Text('Decrypt'),
              icon: const Icon( Icons.remove_red_eye,color: Colors.white,),
              onPressed: () {
                RsaKeyHelper helper = RsaKeyHelper();
                setState(
                  () {
                    realText = helper.decrypt(encryptedData.trim(),
                        helper.parsePrivateKeyFromPem(privateKey));
                  },
                );
              },
              backgroundColor: secondaryColor,
            )
      //     : _selectedIndex == 1 ? FloatingActionButton.extended(label: const Text('Encrypt'),
      //   icon: const Icon( Icons.no_encryption,color: Colors.white,),
      //   onPressed: () {
      //     RsaKeyHelper helper = RsaKeyHelper();
      //     setState(
      //           () {
      //
      //       },
      //     );
      //   },
      //   backgroundColor: secondaryColor,
      // ): _selectedIndex == 2 ? FloatingActionButton.extended(label: const Text('Generate'),
      //   icon: const Icon( Icons.key,color: Colors.white,),
      //   onPressed: () {
      //     RsaKeyHelper helper = RsaKeyHelper();
      //     setState(
      //           () {
      //
      //       },
      //     );
      //   },
      //   backgroundColor: secondaryColor,
      // )
          : SizedBox(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 30.0,right: 30.0),
        margin: EdgeInsets.only(bottom: 6.0),
        height: 60,
        child: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.black,
          onTap: (val) {
            setState(() {
              _selectedIndex = val;
              _pageController.animateToPage(_selectedIndex, duration:const Duration(milliseconds: 200), curve: Curves.linear);
            });
          },
          items:  [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            SalomonBottomBarItem(
              icon:const Icon(Icons.lock),
              title:const Text('Encrypt'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.key),
              title: const Text('Keys'),
            ),
          ],
        ),
      ),
      body: PageView(
        scrollBehavior: MyBehavior(),
        controller: _pageController,
        onPageChanged: (index){
            setState(() {
              _selectedIndex = index;
            });
        },
        children:  [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: primaryColor,
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                                icon: const Icon(Icons.home,color: Colors.white,),
                                onPressed: (){
                                  setState(() {
                                    _selectedIndex = 0;
                                    _pageController.animateToPage(_selectedIndex, duration:const Duration(milliseconds: 200), curve: Curves.linear);
                                  });
                                }
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            MyIconButton(
                              onPresses: (){
                                setState(() {
                                  _selectedIndex = 2;
                                  _pageController.animateToPage(_selectedIndex, duration:const Duration(milliseconds: 200), curve: Curves.linear);
                                });
                              },
                              iconData: Icons.key,
                              iconColor: Colors.white,
                              size: 24,
                            ),
                            MyIconButton(
                              onPresses: (){
                                setState(() {
                                  privateKey = "";
                                  encryptedData = "";
                                });
                              },
                              iconData: Icons.refresh,
                              iconColor: Colors.white,
                              size: 24,
                            ),
                            MyIconButton(
                              onPresses: ()async{
                                await Clipboard.setData(ClipboardData(text: realText));
                                final snackBar = SnackBar(

                                  behavior: SnackBarBehavior.floating,
                                  content: Row(
                                    children: const [
                                      Text(
                                        "Message ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700, fontSize: 16),
                                      ),
                                      Text("added to clipboard"),
                                    ],
                                  ),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              },
                              iconData: Icons.copy,
                              iconColor: Colors.white,
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  color: primaryColor,
                  child: Center(
                    child: Text(
                      realText,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(.6)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      AppTextField(
                        keyTypeText: "Past Your Encrypted Message",
                        isCopy: false,
                        fieldData: (val) {
                          encryptedData = val;
                        },
                        value: encryptedData,
                      ),
                      AppTextField(
                        keyTypeText: "Private Key Here For Decryption",
                        value: privateKey,
                        maxLines: 2,
                        fieldData: (val) {
                          privateKey = val;
                        },
                        isCopy: false,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const EncryptMessage(),
          const GenerateKey(),
        ],
      )
    );
  }
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

