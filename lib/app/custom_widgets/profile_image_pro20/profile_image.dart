import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:proventi/global/style.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../api/restaurant_client/lib/api.dart';
import '../../../state_manager/communication_state_manager.dart';
import '../../core/customer/single_customer_history.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.branchCode,
    required this.avatarRadious,
    required this.customer,
    required this.allowNavigation,
    this.noShowBookings = 0,
  });

  final CustomerDTO customer;
  final String branchCode;
  final double avatarRadious;
  final bool allowNavigation;
  final num noShowBookings;

  static final Map<String, String?> _photoCache = {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(allowNavigation){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleCustomerHistory(
                customerDTO: CustomerDTO(
                    firstName: customer.firstName ?? '',
                    lastName: customer.lastName ?? '',
                    customerId: customer.customerId,
                    prefix: customer.prefix! ?? '',
                    phone: customer.phone! ?? '',
                    email: customer.email! ?? '---'
                ), branchCode: branchCode ?? '',
              ),
            ),
          );
        }
      },
      child: Hero(
        tag: customer.prefix! + customer.phone!,
        child: Consumer<CommunicationStateManager>(
          builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
            // Generate the key for this customer
            final String cacheKey = customer.prefix! + customer.phone!;

            // Check if the image URL is already cached
            if (_photoCache.containsKey(cacheKey)) {
              final cachedImageUrl = _photoCache[cacheKey];
              if (cachedImageUrl == null) {
                // Error case, show fallback image
                return _buildFallbackAvatar();
              } else {
                // Cached image URL exists, display the image
                return _buildCachedNetworkImage(cachedImageUrl);
              }
            }

            // If not cached, fetch from the API
            return FutureBuilder<String?>(
              future: communicationStateManager.whatsAppConfigurationControllerApi
                  .retrieveUserPhoto(
                branchCode,
                cacheKey,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildShimmerAvatar();
                } else if (snapshot.hasError) {
                  return _buildFallbackAvatar();
                } else if (snapshot.hasData) {
                  _photoCache[cacheKey] = snapshot.data;
                  return _buildCachedNetworkImage(snapshot.data!);
                } else {
                  return _buildFallbackAvatar();
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return _buildAvatarContainer(
      CircleAvatar(
        radius: avatarRadious * 0.96,
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/user.png',
              fit: BoxFit.contain,
              width: avatarRadious * 1.3,
              height: avatarRadious * 2,
            ),
          ),
        ),
      ),
    );
  }

  // Helper to build shimmer avatar (loading placeholder)
  Widget _buildShimmerAvatar() {
    return _buildAvatarContainer(
      CircleAvatar(
        radius: avatarRadious,
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
    );
  }

  // Helper to build the network image avatar
  Widget _buildCachedNetworkImage(String imageUrl) {
    return _buildAvatarContainer(
      Stack(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => _buildShimmerAvatar(),
              errorWidget: (context, url, error) => _buildFallbackAvatar(),
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: avatarRadious,
                backgroundImage: imageProvider,
                backgroundColor: Colors.transparent,
              ),
            ),
            if(noShowBookings > 0) Positioned(
                right: 0, bottom: 0, child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.circle, color: Colors.white,),
                  Lottie.asset('assets/lotties/danger.json', width: 20, height: 20, fit: BoxFit.cover)
                ])),
          ]
      ),
    );
  }

  Widget _buildAvatarContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}