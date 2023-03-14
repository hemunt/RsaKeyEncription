import 'package:flutter/material.dart';
import 'package:rsa_message_encription/Screens/EncryptMessage.dart';
import 'package:rsa_message_encription/Screens/GenerateKeyScreen.dart';
import '../AppConstent/Colors.dart';
import '../KeyGenerator/RsaKeyHelper.dart';
import '../LocalStorage/SessionManager.dart';
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
      floatingActionButton:_selectedIndex == 0 ? FloatingActionButton(
        onPressed: (){
          RsaKeyHelper helper = RsaKeyHelper();
          setState(() {
            realText = helper.decrypt(encryptedData.trim(), helper.parsePrivateKeyFromPem(privateKey));
          },);
        },
        backgroundColor: secondaryColor,
        child: Icon(Icons.remove_red_eye, color: Colors.white,),
      ) : SizedBox(),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,

          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.black,
          onTap: (val){
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
        title: const Text("",style: TextStyle(
          fontWeight: FontWeight.w400,
        )),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.refresh),
          ),
        ],
        leading:GestureDetector(
            onTap: (){setState(() {
              _selectedIndex = 0;
            });},
            child: const  Icon(Icons.home)),
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
                    child: Text(realText,style:  TextStyle(
                        fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(.6)
                    ),),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                   children: [
                     AppTextField(keyTypeText: "Past Your Encrypted Message", isCopy: false, fieldData: (val){
                       encryptedData = val;
                     }, value: encryptedData,),
                     AppTextField(keyTypeText: "Private Key Here For Decryption",value: privateKey,maxLines: 2, fieldData: (val){
                       privateKey = val;
                     }, isCopy: false,),
                   ],
                  ),
                )
              ],
            )
      ),
        ),
       const EncryptMessage(),
        const GenerateKey(),
      ].elementAt(_selectedIndex),
    );
  }
}
