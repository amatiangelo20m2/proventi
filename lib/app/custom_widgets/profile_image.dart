import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../state_manager/communication_state_manager.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.prefix, required this.phone, required this.branchCode, required this.avatarRadious});

  final String prefix;
  final String phone;
  final String branchCode;
  final double avatarRadious;


  // Singleton cache for storing image URLs
  static final Map<String, String?> _photoCache = {};

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunicationStateManager>(
      builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
        // Generate the key for this customer
        final String cacheKey = prefix + phone;

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
              // Circular shimmer placeholder
              return _buildShimmerAvatar();
            } else if (snapshot.hasError) {
              // On error, don't cache the key and show fallback
              return _buildFallbackAvatar();
            } else if (snapshot.hasData) {
              // Cache the successful result
              _photoCache[cacheKey] = snapshot.data;
              return _buildCachedNetworkImage(snapshot.data!);
            } else {
              // If no data, show fallback avatar
              return _buildFallbackAvatar();
            }
          },
        );
      },
    );
  }

  // Helper to build the fallback avatar
  Widget _buildFallbackAvatar() {

    return CircleAvatar(
      radius: avatarRadious,
      backgroundImage: const AssetImage('assets/images/profile.png'),
      backgroundColor: Colors.transparent,
    );
  }

  // Helper to build shimmer avatar (loading placeholder)
  Widget _buildShimmerAvatar() {

    return CircleAvatar(
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
    );
  }

  // Helper to build the network image avatar
  Widget _buildCachedNetworkImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => _buildShimmerAvatar(),
      errorWidget: (context, url, error) => _buildFallbackAvatar(),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: avatarRadious,
        backgroundImage: imageProvider,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}