import 'package:calculator/src/blocs/UiHandlerBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolbarChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<bool>(
                stream: uiHandlerBloc.calcUi,
                builder: (context, snapshot) {
                  return ChoiceChip(
                    selected: snapshot.data,
                    pressElevation: 0,
                    selectedColor: Color(0xff009e8b),
                    onSelected: (isSelect) {
                      uiHandlerBloc.convChipSelect.add(false);
                      uiHandlerBloc.calcChipSelect.add(true);
                    },
                    label: Text(
                      "Calculator",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: snapshot.data ? Colors.white : Colors.black),
                    ),
                  );
                }),
            SizedBox(
              width: 10,
            ),
            StreamBuilder<bool>(
                stream: uiHandlerBloc.convUi,
                builder: (context, snapshot) {
                  return ChoiceChip(
                      selected: snapshot.data,
                      selectedColor: Color(0xff009e8b),
                      pressElevation: 0,
                      onSelected: (isSelect) {
                        uiHandlerBloc.calcChipSelect.add(false);
                        uiHandlerBloc.convChipSelect.add(true);
                      },
                      label: Text(
                        "Conventer",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: snapshot.data ? Colors.white : Colors.black),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
