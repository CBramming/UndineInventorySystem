import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({
    Key? key,
    required this.text,
    this.maxLines = 5,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => measureText());
  }

  void measureText() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, height: 1.5),
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );

    final maxWidth = MediaQuery.of(context).size.width - 40;
    textPainter.layout(maxWidth: maxWidth);

    final textHeight = textPainter.size.height;
    final maxAllowedHeight =
        Theme.of(context).textTheme.labelMedium!.fontSize! *
            widget.maxLines *
            1.5;

    final bool didOverflow = textHeight > maxAllowedHeight;
    if (didOverflow != showButton) {
      setState(() {
        showButton = didOverflow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: isExpanded
                ? double.infinity
                : Theme.of(context).textTheme.labelLarge!.fontSize! *
                    widget.maxLines *
                    1.5,
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
              height: 1.5,
            ),
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
        if (showButton)
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Row(
              children: <Widget>[
                Text(
                  isExpanded ? 'Show less' : 'Show more',
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
