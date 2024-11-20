import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/restaurant_client/lib/api.dart';
import '../../state_manager/communication_state_manager.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.bookingDTO});

  final BookingDTO bookingDTO;

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
        return FutureBuilder<String?>(
          future: communicationStateManager.whatsAppConfigurationControllerApi
              .retrieveUserPhoto(
            bookingDTO.branchCode!,
            bookingDTO.customer!.prefix! + bookingDTO.customer!.phone!,
          ),
          builder: (context, snapshot) {
            const double avatarRadius = 30.0;

            if (snapshot.connectionState == ConnectionState.waiting) {
              // Circular shimmer placeholder
              return CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.transparent,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/svg/user.svg',
                  fit: BoxFit.cover,
                  width: avatarRadius * 2,
                  height: avatarRadius * 2,
                ),
              );
            } else if (snapshot.hasData) {
              String imageUrl = snapshot.data!;
              return CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: Colors.transparent,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),

                errorWidget: (context, url, error) => CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const AssetImage('assets/images/profile.png'),
                  backgroundColor: Colors.transparent,
                ),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: imageProvider,
                  backgroundColor: Colors.transparent,
                ),
              );
            } else {
              return CircleAvatar(
                radius: avatarRadius,
                backgroundImage: const AssetImage('assets/images/profile.png'),
                backgroundColor: Colors.transparent,
              );
            }
          },
        );
      },
    );
  }
}
