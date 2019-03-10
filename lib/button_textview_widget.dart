import 'package:flutter/material.dart';
import 'dart:math';

class ButtonTextInput extends StatefulWidget {
  const ButtonTextInput({this.onPressed});

  final ButtonTextInputCallback onPressed;

  @override
  State<StatefulWidget> createState() => ButtonTextInputState();
}

class ButtonTextInputState extends State<ButtonTextInput> {
  bool showTextView = false;
  double textViewHeight = 40;
  bool isExpanded = false;
  double unExpandedHeight = 40;
  GlobalKey _keyRed = GlobalKey();

  void _handleTap() {
    widget.onPressed(true);
    setState(() {
      showTextView = true;
    });
  }

  _getSizes() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    unExpandedHeight = sizeRed.height;
    setState(() {
      textViewHeight = 40;
    });
    print("SIZE of Red: $sizeRed");
  }

  void expandView() {
    print("double tap!");
    if (!isExpanded) {
      setState(() {
        textViewHeight = MediaQuery.of(context).size.height - 150;
        isExpanded = true;
      });
    } else {
      setState(() {
        textViewHeight = 40;
        isExpanded = false;
      });
    }
  }

  List colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.amber,
    Colors.deepOrange
  ];
  Random random = new Random();

  int index = 0;

  void changeIndex() {
    setState(() => index = random.nextInt(7));
  }

  Widget _status(status) {
    if (status == 0) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: _handleTap,
          tooltip: 'Add new memory',
          child: Icon(Icons.add),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            color: colors[index],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0))),
        margin: const EdgeInsets.all(10.0),
        key: _keyRed,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
//            height: textViewHeight,
              child: InkWell(
                onDoubleTap: expandView,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Write your memory'),
                ),
              ),
            )),
      );
    }
  }

  Widget build(BuildContext context) {
//    _getSizes();
    changeIndex();
    return Center(
        child: AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      firstChild: _status(0),
      secondChild: _status(1),
      crossFadeState:
          showTextView ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    ));
  }
}

typedef ButtonTextInputCallback = void Function(bool newButton);
