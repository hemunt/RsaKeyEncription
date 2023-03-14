import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rsa_message_encription/Screens/EncryptMessage.dart';
import 'package:rsa_message_encription/Screens/GenerateKeyScreen.dart';

import '../AppConstent/Colors.dart';
import '../Controller/EncryptionScreenController.dart';
import '../Controller/GenerareKeyScreenController.dart';
import '../KeyGenerator/RsaKeyHelper.dart';
import '../TextField/AppTextField.dart';

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
      // backgroundColor: primaryColor,
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
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
              child: const Icon(
                Icons.remove_red_eye,
                color: Colors.white,
              ),
            )
          : SizedBox(),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.black,
          onTap: (val) {
            setState(() {
              _selectedIndex = val;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: 'encrypt Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.key),
              label: 'Keys',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          "",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          _selectedIndex == 0
              ? GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: realText));
                    final snackBar = SnackBar(
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
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.copy,
                      size: 20,
                    ),
                  ),
                )
              : const SizedBox(),
          GestureDetector(
            onTap: () {
              if (_selectedIndex == 0) {
                setState(() {
                  privateKey = "";
                  encryptedData = "";
                });
              } else if (_selectedIndex == 1) {
                controller.refreshPage();
              } else {
                controller2.refreshPage();
              }
            },
            child: Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 16.0, bottom: 10.0),
                child: const Icon(Icons.refresh)),
          ),
        ],
        leading: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: const Icon(Icons.home)),
      ),
      body: [
        SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
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
          )),
        ),
        const EncryptMessage(),
        const GenerateKey(),
      ].elementAt(_selectedIndex),
    );
  }
}
