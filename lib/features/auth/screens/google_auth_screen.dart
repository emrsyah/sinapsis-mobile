import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../core/constant.dart';
import '../../../core/storage/local_storage.dart';
import '../data/auth_repository.dart';
import '../providers/auth_provider.dart';

class GoogleAuthScreen extends ConsumerStatefulWidget {
  const GoogleAuthScreen({super.key});

  @override
  ConsumerState<GoogleAuthScreen> createState() => _GoogleAuthScreenState();
}

class _GoogleAuthScreenState extends ConsumerState<GoogleAuthScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();

    final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onNavigationRequest: _handleNavigation,
          onWebResourceError: (error) {
            setState(() {
              _error = error.description;
              _isLoading = false;
            });
          },
        ),
      );

    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    final authUrl = ApiEndpoints.googleLogin(AppConstants.apiBaseUrl);
    _controller.loadRequest(Uri.parse(authUrl));
  }

  NavigationDecision _handleNavigation(NavigationRequest request) {
    final uri = Uri.parse(request.url);
    final frontendUrl = AppConstants.apiBaseUrl;

    // Listen for the callback redirect with token
    if (uri.toString().startsWith('$frontendUrl/auth/callback')) {
      final token = uri.queryParameters['token'];
      final error = uri.queryParameters['error'];

      if (token != null && token.isNotEmpty) {
        _handleSuccess(token);
        return NavigationDecision.prevent;
      }

      if (error != null) {
        _handleError('Google sign-in failed: $error');
        return NavigationDecision.prevent;
      }
    }

    return NavigationDecision.navigate;
  }

  Future<void> _handleSuccess(String token) async {
    // Save token first so API calls are authenticated
    final storage = ref.read(localStorageProvider);
    await storage.saveToken(token);

    try {
      final user = await ref.read(authRepositoryProvider).getMe();
      if (!mounted) return;
      await ref.read(authProvider.notifier).setAuthenticated(token, user);
    } catch (e) {
      if (!mounted) return;
      _handleError('Failed to fetch user profile. Please try again.');
    }
  }

  void _handleError(String message) {
    if (!mounted) return;
    setState(() {
      _error = message;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in with Google'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          if (_error != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _error = null;
                          _isLoading = true;
                        });
                        final authUrl = ApiEndpoints.googleLogin(
                            AppConstants.apiBaseUrl);
                        _controller.loadRequest(Uri.parse(authUrl));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
