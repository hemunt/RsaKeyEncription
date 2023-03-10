import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? keyTypeText;
  const AppTextField({Key? key, this.keyTypeText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(keyTypeText ??"Your Key", style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xff212121)
          ),),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 4.0, bottom: 20.0),
          decoration: BoxDecoration(
              color: Color(0xffececec),
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 6,
                  onChanged: (value){
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),bottomLeft:  Radius.circular(20.0)),
                        color: Color(0xffd9d9d9)
                    ),
                    child: Icon(Icons.copy, size: 20,)),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
