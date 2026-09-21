import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'nfc_wait_screen.dart';
import 'parent_history_screen.dart';
import 'legal_document_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.firebaseReady});

  final bool firebaseReady;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _versionLabel = '버전 확인 중';
  String _versionOnly = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() {
      _versionOnly = info.version;
      _versionLabel = 'RAMI v${info.version} (${info.buildNumber})';
    });
  }

  void _openLegal(String kind) {
    final isPrivacy = kind == 'privacy' || kind == 'child_privacy';
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => LegalDocumentScreen(
        title: isPrivacy
            ? (kind == 'child_privacy' ? '아동·보호자 개인정보 안내' : '개인정보 처리 안내')
            : '서비스 이용약관',
        sections: isPrivacy ? ramiPrivacySections : ramiTermsSections,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RAMI'),
        actions: [
          PopupMenuButton<String>(
            tooltip: '메뉴',
            onSelected: (value) {
              if (value == 'privacy' || value == 'child_privacy' || value == 'terms') {
                _openLegal(value);
              } else if (value == 'licenses') {
                showLicensePage(
                  context: context,
                  applicationName: 'RAMI',
                  applicationVersion: _versionOnly,
                );
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'privacy',
                child: Text('개인정보 처리방침'),
              ),
              const PopupMenuItem(
                value: 'child_privacy',
                child: Text('아동·보호자 개인정보 안내'),
              ),
              const PopupMenuItem(
                value: 'terms',
                child: Text('서비스 이용약관'),
              ),
              const PopupMenuItem(
                value: 'licenses',
                child: Text('오픈소스 라이선스'),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                enabled: false,
                value: 'version',
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    _versionLabel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              const Text('🌱', style: TextStyle(fontSize: 84)),
              const SizedBox(height: 16),
              Text('라미', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 46)),
              const SizedBox(height: 12),
              Text(
                '그림으로 고르고\n놀이로 표현해요',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 74,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const NfcWaitScreen()),
                  ),
                  child: const Text('아이 모드', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ParentHistoryScreen(firebaseReady: widget.firebaseReady)),
                ),
                icon: const Icon(Icons.lock_outline),
                label: const Text('부모 모드'),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
