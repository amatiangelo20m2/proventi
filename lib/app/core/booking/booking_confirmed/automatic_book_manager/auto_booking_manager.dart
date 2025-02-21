import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/global/style.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../../../../api/restaurant_client/lib/api.dart';
import '../../../../../state_manager/restaurant_state_manager.dart';
import '../../../../custom_widgets/toggle_pro20/appinio_animated_toggle_tab.dart';

class AutoBookingManager extends StatefulWidget {
  const AutoBookingManager({super.key,
    required this.currentDate});

  final DateTime currentDate;

  @override
  State<AutoBookingManager> createState() => _AutoBookingManagerState();
}

class _AutoBookingManagerState extends State<AutoBookingManager> {

  SuperTooltipController controller = SuperTooltipController();

  bool acceptLunch = false;
  bool refuseLunch = false;
  bool acceptDinner = false;
  bool refuseDinner = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantStateManager>(
      builder: (context, restaurantStateManager, child) {
        return SuperTooltip(
          controller: controller,
          popupDirection: TooltipDirection.down,
          closeButtonType: CloseButtonType.outside,
          content: IntrinsicWidth(
            child: IntrinsicHeight(
              child: SizedBox(
                child: _buildConfigCard(restaurantStateManager),
              ),
            ),
          ),
          child: _buildIconBasedOnConfig(restaurantStateManager
              .restaurantConfiguration!
              .automaticApproveRefuseBookConf),
        );
      },
    );
  }

  /// Builds the configuration card containing switchers for lunch and dinner.
  Widget _buildConfigCard(RestaurantStateManager restaurantStateManager) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Configurazione per ${italianDateFormat.format(widget.currentDate)}', style: const TextStyle(fontSize: 12),),
              ),
            ],
          ),
          Row(
            children: [
              Icon(CupertinoIcons.sun_max_fill, size: 40, color: globalGold),
              _buildSwitcher(
                restaurantStateManager,
                widget.currentDate,
                isLunch: true,
              ),
            ],
          ),
          Row(
            children: [
              Icon(CupertinoIcons.moon, size: 40, color: elegantBlue),
              _buildSwitcher(
                restaurantStateManager,
                widget.currentDate,
                isLunch: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a switcher widget for lunch or dinner based on the `isLunch` flag.
  Widget _buildSwitcher(
      RestaurantStateManager restaurantStateManager,
      DateTime currentDate,
      {required bool isLunch}) {
    final configs = _getBookingConfigurations(restaurantStateManager, currentDate);
    int initialIndex = 0;

    if(isLunch) {
      initialIndex = !configs["acceptLunch"]! && !configs["refuseLunch"]!
          ? 0
          : configs["acceptLunch"]!
          ? 1
          : 2;
    }else{
      initialIndex = !configs["acceptDinner"]! && !configs["refuseDinner"]!
          ? 0
          : configs["acceptDinner"]!
          ? 1
          : 2;
    }


    return SwitchPro20(
      initialIndex: initialIndex,
      callback: (int index) async {

        print('Update conf index: $index');

        setState(() {
          if (isLunch) {
            switch (index) {
              case 0:
                acceptLunch = false;
                refuseLunch = false;
                break;
              case 1:
                acceptLunch = true;
                refuseLunch = false;
                break;
              case 2:
                acceptLunch = false;
                refuseLunch = true;
                break;
            }
          } else {
            switch (index) {
              case 0:
                acceptDinner = false;
                refuseDinner = false;
                break;
              case 1:
                acceptDinner = true;
                refuseDinner = false;
                break;
              case 2:
                acceptDinner = false;
                refuseDinner = true;
                break;
            }
          }
        });


        await restaurantStateManager.updateAutomaticBookingManageConfiguration(
          currentDate,
          acceptLunch: acceptLunch,
          refuseLunch: refuseLunch,
          acceptDinner: acceptDinner,
          refuseDinner: refuseDinner,
        );


      },
      tabTexts: const [
        Text('Inattivo', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text('Conferma Tutto', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
        Text('Rifiuta Tutto', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
      ],
      height: MediaQuery.of(context).size.height * 1 / 14,
      width: MediaQuery.of(context).size.width / 2,
      boxDecoration: const BoxDecoration(color: Colors.transparent),
      animatedBoxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      activeStyle: const TextStyle(color: Colors.white),
      inactiveStyle: const TextStyle(color: Colors.black),
    );
  }

  /// Extracts and returns the booking configurations for the current date.
  Map<String, bool> _getBookingConfigurations(
      RestaurantStateManager restaurantStateManager, DateTime currentDate) {

    bool acceptLunch = false, refuseLunch = false, acceptDinner = false, refuseDinner = false;

    if (restaurantStateManager.restaurantConfiguration!.automaticApproveRefuseBookConf.isNotEmpty) {
      for (var conf in restaurantStateManager.restaurantConfiguration!.automaticApproveRefuseBookConf) {
        if (isSameDay(conf.date!, currentDate)) {
          acceptLunch = conf.doAcceptBookingLunch ?? false;
          refuseLunch = conf.doRefuseBookingLunch ?? false;
          acceptDinner = conf.doAcceptBookingDinner ?? false;
          refuseDinner = conf.doRefuseBookingDinner ?? false;
        }
      }
    }

    return {
      "acceptLunch": acceptLunch,
      "refuseLunch": refuseLunch,
      "acceptDinner": acceptDinner,
      "refuseDinner": refuseDinner,
    };
  }

  /// Builds the icon based on the current booking configuration.
  Widget _buildIconBasedOnConfig(List<AutomaticApproveRefusedBookConf> automaticApproveRefuseBookConf) {
    // Find the configuration for the selected date
    var configForSelectedDate = automaticApproveRefuseBookConf.firstWhere(
          (element) => isSameDay(element.date!, widget.currentDate),
      orElse: () => AutomaticApproveRefusedBookConf(),
    );

    // Default icon colors
    Color sunIconColor = Colors.grey;
    Color moonIconColor = Colors.grey;

    // Update icon colors based on the configuration
    if (configForSelectedDate.date != null) {
      if (configForSelectedDate.doAcceptBookingLunch == true) {
        sunIconColor = elegantGreen;
      } else if (configForSelectedDate.doRefuseBookingLunch == true) {
        sunIconColor = elegantRed;
      }

      if (configForSelectedDate.doAcceptBookingDinner == true) {
        moonIconColor = elegantGreen;

      } else if (configForSelectedDate.doRefuseBookingDinner == true) {
        moonIconColor = elegantRed;
      }
    }

    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.sun_min,
              color: sunIconColor,
              size: 30,
            ),

            Icon(
              CupertinoIcons.moon_stars,
              color: moonIconColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
