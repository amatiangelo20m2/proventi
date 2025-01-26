import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:proventi/app/core/whatconf/link_whatsapp_component.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../api/communication_client/lib/api.dart';
import 'critical_conf_whatsapp_widget.dart';
import 'instance_details_pronta.dart';

class WhatsAppButtonStatus extends StatefulWidget {
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;

  const WhatsAppButtonStatus({
    Key? key,
    this.borderRadius = 14.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.blueGrey,
  }) : super(key: key);

  @override
  _WhatsAppButtonStatusState createState() => _WhatsAppButtonStatusState();
}

class _WhatsAppButtonStatusState extends State<WhatsAppButtonStatus> {
  Timer? _timer;
  bool _isLoading = true;
  bool _hasData = false;
  bool _firstApiTry = false;

  @override
  void initState() {
    super.initState();
    _startApiCall();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _startApiCall();
    });
  }

  void _startApiCall() async {
    setState(() {
      _isLoading = true;
    });
    await _performApiCall();
    setState(() {
      _isLoading = false;
      _hasData = true;
      _firstApiTry = true;
    });
  }

  Future<void> _performApiCall() async {
    await Provider.of<CommunicationStateManager>(context, listen: false).retrieveWaApiConfStatus();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Show shimmer icon during loading or before the first API call
          if (_isLoading || !_firstApiTry)
            Positioned(
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Icon(
                  FontAwesomeIcons.squareWhatsapp,
                  size: 36,
                  color: Colors.grey,
                ),
              ),
            )
          else
            Consumer<CommunicationStateManager>(
              builder: (BuildContext context, CommunicationStateManager value, Widget? child) {
                // State: PRONTA
                if (value.currentWhatsAppConfigurationDTO?.waApiState ==
                    WhatsAppConfigurationDTOWaApiStateEnum.PRONTA) {
                  return IconButton(
                    onPressed: _showProntaInstance,
                    icon: Icon(
                      FontAwesomeIcons.squareWhatsapp,
                      size: 36,
                      color: Colors.green,
                    ),
                  );
                }
                // State: QR
                else if (value.currentWhatsAppConfigurationDTO?.waApiState ==
                    WhatsAppConfigurationDTOWaApiStateEnum.QR) {
                  return Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(LinkWhatsAppComponent.routeName);
                        },
                        icon: const Icon(CupertinoIcons.qrcode, color: Colors.black, size: 30),
                      ),
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(LinkWhatsAppComponent.routeName);
                          },
                          child: Lottie.asset('assets/lotties/danger.json', height: 25),
                        ),
                      ),
                    ],
                  );
                }
                // State: Other
                else {
                  return IconButton(
                    onPressed: _openCriticalWhatsAppProblemManager,
                    icon: Icon(
                      FontAwesomeIcons.squareWhatsapp,
                      size: 36,
                      color: Colors.red,
                    ),
                  );
                }
              },
            ),
        ],
      ),
    );
  }

  void _showProntaInstance() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          content: const InstanceDetailsWhenPronta(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Chiudi', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _openCriticalWhatsAppProblemManager() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          content: const CriticalWhatsAppConfigurationWidget(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Chiudi', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
