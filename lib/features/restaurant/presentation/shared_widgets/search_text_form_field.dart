import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class StreamedSearchTextField extends StatefulWidget {
  const StreamedSearchTextField({
    super.key,
    required FocusNode currentFocusNode,
    required TextEditingController currentController,
    EdgeInsetsGeometry? margin,
    bool enabled = true,
    TextStyle? style,
    void Function(String)? onChanged,
    ValueChanged<String?>? onSubmitted,
  })  : _currentFocusNode = currentFocusNode,
        _currentController = currentController,
        _margin = margin,
        _enabled = enabled,
        _style = style,
        _onChanged = onChanged,
        _onSubmitted = onSubmitted;

  final FocusNode _currentFocusNode;
  final TextEditingController _currentController;
  final EdgeInsetsGeometry? _margin;
  final bool _enabled;
  final TextStyle? _style;
  final void Function(String)? _onChanged;
  final ValueChanged<String?>? _onSubmitted;

  @override
  State<StreamedSearchTextField> createState() =>
      _StreamedSearchTextFieldState();
}

class _StreamedSearchTextFieldState extends State<StreamedSearchTextField> {
  StreamController<String>? _streamController;

  @override
  void dispose() {
    _closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SearchTextFormField(
      currentFocusNode: widget._currentFocusNode,
      currentController: widget._currentController,
      margin: widget._margin,
      enabled: widget._enabled,
      style: widget._style,
      onChanged: (text) {
        _createStreamIfNeeded();
        _streamController?.add(text);
      },
      onSubmitted: widget._onSubmitted,
    );
  }

  void _createStreamIfNeeded() {
    if (_streamController == null) {
      _streamController = StreamController<String>();
      _buildStreamListener();
    }
  }

  void _closeStream() {
    _streamController?.close();
    _streamController = null;
  }

  void onTimeOut(Stream<String>? stream) {
    if (stream == null) return;

    stream.timeout(const Duration(seconds: 5),
        onTimeout: (_) => onTimeOut(stream));
  }

  void _buildStreamListener() {
    _streamController?.stream
        .debounceTime(const Duration(milliseconds: 300))
        .distinct()
        .timeout(
          const Duration(seconds: 5),
          onTimeout: (_) => onTimeOut(_streamController?.stream),
        )
        .listen(widget._onChanged);
  }
}

class _SearchTextFormField extends StatelessWidget {
  const _SearchTextFormField({
    super.key,
    required FocusNode currentFocusNode,
    required TextEditingController currentController,
    EdgeInsetsGeometry? margin,
    bool enabled = true,
    TextStyle? style,
    void Function(String)? onChanged,
    ValueChanged<String?>? onSubmitted,
  })  : _currentFocusNode = currentFocusNode,
        _currentController = currentController,
        _margin = margin,
        _enabled = enabled,
        _style = style,
        _onChanged = onChanged,
        _onSubmitted = onSubmitted;

  final FocusNode _currentFocusNode;
  final TextEditingController _currentController;
  final EdgeInsetsGeometry? _margin;
  final bool _enabled;
  final TextStyle? _style;
  final void Function(String)? _onChanged;
  final ValueChanged<String?>? _onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _margin ?? const EdgeInsets.all(8),
      child: TextFormField(
        focusNode: _currentFocusNode,
        controller: _currentController,
        enabled: _enabled,
        style: _style,
        onChanged: _onChanged,
        onFieldSubmitted: _onSubmitted,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
