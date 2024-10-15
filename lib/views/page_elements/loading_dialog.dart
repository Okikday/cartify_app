import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const loadingMessages = [
  "Just a moment...",
  "Please wait...",
  "Hold on...",
  "Loading, please wait...",
  "Hang tight...",
  "Almost there...",
  "Still with us? Just tightening a few screws...",
  "One moment please...",
  "Just a sec...",
  "Fetching your data...",
  "Processing, please wait...",
  "Please hold on...",
  "Working on it...",
  "Stay with us...",
  "We're getting there...",
  "Give us a second...",
  "Waiting for things to load...",
  "Getting everything ready...",
  "Loading, please be patient...",
  "Please stand by...",
  "Getting things in order...",
  "Thank you for your patience...",
  "Just a little bit longer...",
  "Preparing your content...",
  "Gathering the details...",
  "We’re almost ready...",
  "Almost done...",
  "Patience, we’re on it...",
  "Wait just a little longer...",
  "Getting things set up...",
  "Hang on, loading now..."
];

class LoadingDialog extends ConsumerStatefulWidget {
  final bool canPop;
  final String? msg;

  const LoadingDialog({super.key, this.canPop = false, this.msg});

  @override
  ConsumerState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends ConsumerState<LoadingDialog> {
  int msgIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      setState(() {
        msgIndex == loadingMessages.length-1 ? msgIndex = 0 : msgIndex++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: widget.canPop,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(36),
            ),
            width: screenWidth * 0.6,
            height: screenWidth * 0.4,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: CircularProgressIndicator(strokeCap: StrokeCap.round),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: ConstantWidgets.text(context, loadingMessages[msgIndex]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
