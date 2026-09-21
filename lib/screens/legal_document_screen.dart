import 'package:flutter/material.dart';

class LegalDocumentScreen extends StatelessWidget {
  const LegalDocumentScreen({
    super.key,
    required this.title,
    required this.sections,
  });

  final String title;
  final List<LegalSection> sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemBuilder: (_, index) {
          final section = sections[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(section.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(section.body, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6)),
            ],
          );
        },
      ),
    );
  }
}

class LegalSection {
  const LegalSection(this.title, this.body);
  final String title;
  final String body;
}

const ramiPrivacySections = <LegalSection>[
  LegalSection(
    '현재 앱에서 처리하는 정보',
    'RAMI는 현재 아이가 선택한 카드 식별자, 놀이 행동 기록, 기록 시각과 기기에 저장한 음성 녹음 파일 경로를 로컬에 보관합니다. NFC 태그에는 아동의 개인정보를 저장하지 않고 카드 식별 정보만 사용합니다.',
  ),
  LegalSection(
    '아동과 보호자 정보',
    '만 14세 미만 아동의 개인정보를 동의에 근거해 처리하는 기능을 제공할 경우 법정대리인의 동의와 확인 절차가 필요합니다. 현재 앱은 아동의 실명·전화번호·주소 입력을 요구하지 않는 것을 원칙으로 합니다.',
  ),
  LegalSection(
    '클라우드 기능',
    'Firebase 등 외부 클라우드 저장 기능을 실제 사용자 대상으로 활성화하기 전에는 수집 항목, 이용 목적, 보유 기간, 처리위탁·국외 이전 여부와 이용자 권리 행사 방법을 별도로 확정하고 고지해야 합니다.',
  ),
  LegalSection(
    '삭제와 보호',
    '보호자 화면에서 제공되는 삭제 기능은 기기에 저장된 데모 기록과 녹음 파일을 삭제하는 용도로 사용합니다. 정식 서비스에서는 운영 주체와 개인정보 문의처를 함께 공개해야 합니다.',
  ),
];

const ramiTermsSections = <LegalSection>[
  LegalSection(
    '서비스 목적',
    'RAMI는 그림카드와 NFC를 활용해 아이의 선택과 표현 놀이를 돕는 서비스입니다.',
  ),
  LegalSection(
    '보호자 책임',
    '아동의 기기 사용, 녹음 기능과 외부 콘텐츠 이용은 보호자의 확인과 지도 아래 사용하는 것을 전제로 합니다.',
  ),
  LegalSection(
    '서비스 한계',
    'RAMI는 의료 진단, 치료, 발달 평가 또는 전문 상담을 대신하지 않습니다. 건강이나 발달과 관련한 중요한 판단은 적절한 전문가와 확인해 주세요.',
  ),
  LegalSection(
    '정식 약관',
    '결제, 회원 계정, 클라우드 동기화 등 정식 서비스 기능이 추가될 경우 운영 주체, 이용 조건, 책임 범위, 환불·분쟁 처리 등 필요한 항목을 포함한 정식 약관을 별도로 확정합니다.',
  ),
];
