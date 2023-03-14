import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final String? keyTypeText;
  final String? value;
  final String? label;
  final bool isCopy;
  final bool readOnly;
  final int maxLines;
  final Function(String) fieldData;
  AppTextField({Key? key, this.keyTypeText, this.value, this.isCopy = true, this.maxLines = 6,  this.readOnly = false, required this.fieldData, this.label}) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String fieldValue = "";
   @override
  void initState() {
    fieldValue = widget.value??"";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(widget.keyTypeText ?? "Your Key", style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xff212121)
          ),),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 4.0, bottom: 20.0),
          decoration: BoxDecoration(
              color:const Color(0xffececec),
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: widget.readOnly,
                  controller: TextEditingController(text: widget.value)..selection = TextSelection.collapsed(offset: widget.value!.length),
                  maxLines: widget.maxLines,
                  onChanged: (text) {
                    fieldValue = text;
                    widget.fieldData(text);
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none
                  ),
                ),
              ),
              widget.isCopy ? Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () async{
                    await Clipboard.setData(ClipboardData(text: fieldValue));
                    final snackBar = SnackBar(
                      content: Row(
                        children: [
                          Text("${widget.label} ", style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                          Text("added to clipboard"),
                        ],
                      ),
                      action: SnackBarAction(
                        label: 'Ok',
                        onPressed: () {
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration:const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),bottomLeft:  Radius.circular(20.0)),
                          color: Color(0xffd9d9d9)
                      ),
                      child: const Icon(Icons.copy, size: 20,)),
                ),
              ) : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
