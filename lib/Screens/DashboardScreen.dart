import 'package:flutter/material.dart';
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
  String? publicKey = "";

@override
  void initState() {
  screenSize = WidgetsBinding.instance.window.physicalSize;
  width = screenSize?.width;
  if(SessionManager.isKeysSet()){
    privateKey = SessionManager.getPrivateKey();
    publicKey = SessionManager.getPublicKey();
  }
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
        leading:const  Icon(Icons.house_rounded),
      ),
      body: [
        SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4 + 30,
                    color: Colors.white,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    color: primaryColor,
                    child: Center(
                      child: Text("Your Message Here...",style:  TextStyle(
                          fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(.6)
                      ),),
                    ),
                  ),
                  Positioned(
                    right: 20.0,
                    bottom: 0,
                    child: GestureDetector(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: secondaryColor
                        ),
                        child: const Icon(Icons.no_encryption,color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          )
      ),
        SingleChildScrollView(
          child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    AppTextField(keyTypeText: "Write Your Message", isCopy: false,),
                    AppTextField(keyTypeText: "Your Private Key",maxLines: 1, readOnly: true, value: privateKey ??"", isCopy: false,),
                    AppTextField(keyTypeText: "Your Encrypted Message", isCopy: true,),
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        height: 60,
                        margin:const  EdgeInsets.all(20.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xffFF5722)
                        ),
                        child: const Center(
                          child: Text(
                            "Encrypt",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    isLoading ? CircularProgressIndicator(color: secondaryColor,) : const SizedBox(),
                  ],
                ),
              )
          ),
        ),
        SingleChildScrollView(
          child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                     AppTextField(keyTypeText: "Private Key",value: privateKey ?? ""),
                     AppTextField(keyTypeText: "Public Key", value: publicKey ??"",),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isLoading = true;
                        });
                        Future.delayed( const Duration(milliseconds: 500), () {
                          RsaKeyHelper rsaKeyHelper = RsaKeyHelper();
                          final pair = rsaKeyHelper.generateKeyPair();
                          final public = pair.publicKey;
                          final private = pair.privateKey;
                          final publicKeyBase64 = rsaKeyHelper.encodePublicKeyToPem(public);
                          final privateKeyBase64 = rsaKeyHelper.encodePrivateKeyToPem(private);
                          SessionManager.setPrivateKey(privateKeyBase64);
                          SessionManager.setPublicKey(publicKeyBase64);
                          setState((){
                            privateKey = privateKeyBase64;
                            publicKey = publicKeyBase64;
                            isLoading = false;
                          });
                        },);
                      },
                      child: Container(
                        height: 60,
                        margin:const EdgeInsets.all(20.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color:const Color(0xffFF5722)
                        ),
                        child: const Center(
                          child: Text(
                            "GENERATE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    isLoading ? CircularProgressIndicator(color: secondaryColor,) : const SizedBox(),
                  ],
                ),
              )
          ),
        ),
      ].elementAt(_selectedIndex),
    );
  }
}
