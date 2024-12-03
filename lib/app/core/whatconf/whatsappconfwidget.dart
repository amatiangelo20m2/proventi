import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:proventi/api/communication_client/lib/api.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';

class AnimatedBorderContainer extends StatefulWidget {
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;

  const AnimatedBorderContainer({
    Key? key,
    this.borderRadius = 14.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.blueGrey,
  }) : super(key: key);

  @override
  _AnimatedBorderContainerState createState() => _AnimatedBorderContainerState();
}

class _AnimatedBorderContainerState extends State<AnimatedBorderContainer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  Timer? _timer;
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _startApiCall();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _startApiCall();
    });
  }

  void _startApiCall() async {
    setState(() {
      _isLoading = true;
    });
    _controller.repeat();
    await _performApiCall();
    _controller.stop();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _performApiCall() async {
    await Provider.of<CommunicationStateManager>(context, listen: false).retrieveWaApiConfStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BorderPainter(
        animation: _animation,
        borderRadius: widget.borderRadius,
        borderWidth: widget.borderWidth,
        borderColor: _isLoading ? widget.borderColor : Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Consumer<CommunicationStateManager>(
          builder: (BuildContext context, CommunicationStateManager value, Widget? child) {

            if(value.currentWhatsAppConfigurationDTO?.waApiState
                == WhatsAppConfigurationDTOWaApiStateEnum.PRONTA){
              return IconButton(onPressed: (){

              }, icon: const Icon(FontAwesomeIcons.whatsapp,
                  color: Colors.green));
            }else if (value.currentWhatsAppConfigurationDTO?.waApiState
                == WhatsAppConfigurationDTOWaApiStateEnum.QR){
              Fluttertoast.showToast(
                  msg: "️⚠️Il numero whatsapp non è pronto. Scansiona il codice qr per collegare il numero",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2);
              return Stack(
                children: [ IconButton(onPressed: (){
                    
                }, icon: const Icon(CupertinoIcons.qrcode,
                    color: Colors.black, size: 25,)),
                  Positioned(right:0, child: Lottie.asset('assets/lotties/danger.json', height: 30))
              ]);
            }else{
              Fluttertoast.showToast(
                  msg: "⚠️⚠️⚠️ATTENZIONE! Numero what's app risulta non collegato⚠️⚠️⚠️",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2);
              return IconButton(onPressed: (){

              }, icon: const Icon(FontAwesomeIcons.whatsapp,
                  color: Colors.red));
            }
          },

        ),
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final Animation<double> animation;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;

  BorderPainter({
    required this.animation,
    required this.borderRadius,
    required this.borderWidth,
    required this.borderColor,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final pathMetrics = path.computeMetrics().toList();
    final totalLength = pathMetrics.fold(0.0, (sum, metric) => sum + metric.length);
    final currentLength = totalLength * animation.value;

    for (final metric in pathMetrics) {
      if (currentLength <= metric.length) {
        final extractPath = metric.extractPath(0, currentLength);
        canvas.drawPath(extractPath, paint);
        break;
      } else {
        canvas.drawPath(metric.extractPath(0, metric.length), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}