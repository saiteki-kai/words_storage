import 'package:flutter/material.dart';
import 'package:learningwords/components/labeled_radio.dart';
import 'package:learningwords/models/item.dart';

class StateDialog extends StatefulWidget {
  final Function onConfirm;

  const StateDialog({Key key, this.onConfirm}) : super(key: key);

  @override
  _StateDialogState createState() => _StateDialogState();
}

class _StateDialogState extends State<StateDialog> {
  final states = ["Learned", "Learning", "To Learn"];
  var _state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      title: const Text("Select State"),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: states.map((s) {
            return LabeledRadio<LearnState>(
              label: s,
              value: LearnState.values[states.indexOf(s)],
              groupValue: _state,
              onChanged: (LearnState value) {
                setState(() => _state = value);
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        _CustomAction(
          title: "CANCEL",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        _CustomAction(
          title: "CONFIRM",
          enabled: _state != null,
          onPressed: () {
            var index = 0;
            if (_state != null) {
              index = LearnState.values.indexOf(_state);
            }
            widget.onConfirm(_state, index);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class DeleteDialog extends StatelessWidget {
  final Function onConfirm;

  const DeleteDialog({Key key, this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      title: const Text('Confirm Delete'),
      content: const Text("Are you sure you want to delete selected words?"),
      actions: [
        _CustomAction(
          title: "CANCEL",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        _CustomAction(
          title: "OK",
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class _CustomAction extends StatelessWidget {
  final String title;
  final bool enabled;
  final Function onPressed;

  const _CustomAction({
    Key key,
    this.title,
    this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: enabled ? onPressed : null,
      padding: const EdgeInsets.all(8.0),
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(title),
    );
  }
}