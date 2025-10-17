import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'syntax_highlighter.dart';

class CodeInputField extends StatefulWidget {
  final String initialCode;
  final String language;
  final Function(String) onCodeChanged;
  final bool readOnly;
  final int? maxLines;

  const CodeInputField({
    Key? key,
    required this.initialCode,
    required this.language,
    required this.onCodeChanged,
    this.readOnly = false,
    this.maxLines,
  }) : super(key: key);

  @override
  State<CodeInputField> createState() => _CodeInputFieldState();
}

class _CodeInputFieldState extends State<CodeInputField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialCode);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]!
              : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Code editor header with language indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[850]
                  : Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.language.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    // Copy button
                    IconButton(
                      icon: const Icon(Icons.copy, size: 18),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _controller.text));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code copied to clipboard'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      tooltip: 'Copy code',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 12),
                    // Format button (placeholder for future functionality)
                    IconButton(
                      icon: const Icon(Icons.format_align_left, size: 18),
                      onPressed: () {
                        // Format code functionality would go here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code formatting not implemented yet'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      tooltip: 'Format code',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Code editor
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLines: widget.maxLines ?? 10,
              minLines: 5,
              readOnly: widget.readOnly,
              onChanged: (value) {
                widget.onCodeChanged(value);
              },
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}