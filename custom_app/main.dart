import 'package:flutter/material.dart';

void main() => runApp(const IkhtabirApp());

// ═══════════ الألوان ═══════════
class C {
  static const bg = Color(0xFF0A0620);
  static const card = Color(0xFF161236);
  static const cardAlt = Color(0xFF1E1A45);
  static const purple = Color(0xFF8B5CF6);
  static const purpleLt = Color(0xFFA78BFA);
  static const blue = Color(0xFF3B82F6);
  static const blueLt = Color(0xFF60A5FA);
  static const cyan = Color(0xFF22D3EE);
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const orange = Color(0xFFF97316);
  static const pink = Color(0xFFEC4899);
  static const textMain = Colors.white;
  static const textSoft = Color(0xFFB8B5D6);
  static const textMuted = Color(0xFF7B7899);
  static const border = Color(0xFF2A2550);
  static const gradPrimary = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF3B82F6)],
    begin: Alignment.centerRight, end: Alignment.centerLeft);
  static const gradSplash = LinearGradient(
    colors: [Color(0xFF2D1B69), Color(0xFF0A0620)],
    begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

// ═══════════ النماذج ═══════════
class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  Question(this.text, this.options, this.correctIndex);
}

class QuizResult {
  final String title;
  final int score;
  final int total;
  QuizResult(this.title, this.score, this.total);
  double get percent => total > 0 ? (score / total) * 100 : 0;
}

// ═══════════ البيانات ═══════════
final sampleQuestions = <Question>[
  Question('ما هي عاصمة المملكة العربية السعودية؟',
    ['مكة المكرمة', 'الرياض', 'جدة', 'المدينة المنورة'], 1),
  Question('كم عدد أيام السنة الميلادية؟',
    ['360 يوم', '365 يوم', '354 يوم', '370 يوم'], 1),
  Question('ما هو أكبر كوكب في المجموعة الشمسية؟',
    ['الأرض', 'المريخ', 'المشتري', 'زحل'], 2),
  Question('كم عدد فصول السنة؟',
    ['اثنان', 'ثلاثة', 'أربعة', 'خمسة'], 2),
  Question('ما هو الحيوان الملقب بسفينة الصحراء؟',
    ['الحصان', 'الجمل', 'الفيل', 'الحمار'], 1),
  Question('ما هو العنصر الأكثر وفرة في الغلاف الجوي؟',
    ['الأكسجين', 'النيتروجين', 'ثاني أكسيد الكربون', 'الهيدروجين'], 1),
  Question('كم عدد ألوان قوس قزح؟',
    ['خمسة', 'ستة', 'سبعة', 'ثمانية'], 2),
  Question('ما هي أكبر قارة في العالم؟',
    ['أفريقيا', 'آسيا', 'أوروبا', 'أمريكا الشمالية'], 1),
  Question('في أي عام هبط الإنسان على القمر؟',
    ['1965', '1969', '1972', '1975'], 1),
  Question('ما هي عملة اليابان؟',
    ['اليوان', 'الوون', 'الين', 'الدولار'], 2),
];

final savedResults = <QuizResult>[];

// ═══════════ التطبيق ═══════════
class IkhtabirApp extends StatelessWidget {
  const IkhtabirApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبر نفسك',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: C.bg,
        colorScheme: const ColorScheme.dark(
          primary: C.purple, secondary: C.blue, surface: C.card),
      ),
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl, child: child!),
      home: const SplashScreen(),
    );
  }
}

// ═══════════ Splash ═══════════
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const MainShell()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: C.gradSplash),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              const RJLogo(size: 160),
              const SizedBox(height: 24),
              const Text('اختبر نفسك',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold,
                  color: Colors.white, letterSpacing: 1)),
              const SizedBox(height: 8),
              Text('كل معلومة خطوة أقرب لفهمك',
                style: TextStyle(fontSize: 14,
                  color: Colors.white.withOpacity(0.7))),
              const Spacer(flex: 2),
              Container(
                width: 100, height: 4,
                decoration: BoxDecoration(
                  gradient: C.gradPrimary,
                  borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════ RJ Logo (قلب + تاج + RJ) ═══════════
class RJLogo extends StatelessWidget {
  final double size;
  const RJLogo({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.15,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // التوهج الخارجي
          Positioned(
            top: size * 0.2,
            child: Container(
              width: size * 1.1,
              height: size * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    C.purple.withOpacity(0.55),
                    C.blue.withOpacity(0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // القلب مملوء بتدرج
          Positioned(
            top: size * 0.22,
            child: ShaderMask(
              shaderCallback: (r) => const LinearGradient(
                colors: [Color(0xFFB794F6), Color(0xFF6366F1), Color(0xFF3B82F6)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ).createShader(r),
              child: Icon(
                Icons.favorite,
                size: size * 0.82,
                color: Colors.white,
              ),
            ),
          ),
          // حدود القلب الخارجية بنفسجية متوهجة
          Positioned(
            top: size * 0.22,
            child: Icon(
              Icons.favorite_border,
              size: size * 0.9,
              color: const Color(0xFFB794F6).withOpacity(0.7),
              shadows: [
                Shadow(color: C.purpleLt, blurRadius: 12),
                Shadow(color: C.cyan, blurRadius: 20),
              ],
            ),
          ),
          // التاج أعلى القلب
          Positioned(
            top: size * 0.02,
            child: CustomPaint(
              size: Size(size * 0.32, size * 0.16),
              painter: _CrownPainter(),
            ),
          ),
          // حروف RJ داخل القلب
          Positioned(
            top: size * 0.42,
            child: Text(
              'RJ',
              style: TextStyle(
                fontSize: size * 0.28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                letterSpacing: -3,
                shadows: [
                  Shadow(color: Colors.white.withOpacity(0.9), blurRadius: 8),
                  Shadow(color: const Color(0xFFB794F6), blurRadius: 16),
                  Shadow(color: C.blueLt, blurRadius: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CrownPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFB794F6), Color(0xFF22D3EE), Color(0xFF60A5FA)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.35)
      ..lineTo(size.width * 0.25, size.height * 0.65)
      ..lineTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.75, size.height * 0.65)
      ..lineTo(size.width, size.height * 0.35)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);

    // نقطة صغيرة لامعة على قمة التاج
    final dotPaint = Paint()..color = C.cyan;
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.05),
      size.width * 0.05, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════ Main Shell ═══════════
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _i = 0;
  final _pages = const [
    HomeScreen(), SummariesScreen(), QuizzesListScreen(), MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _i, children: _pages),
      bottomNavigationBar: _bottomNav());
  }

  Widget _bottomNav() {
    final items = [
      (Icons.home_rounded, 'الرئيسية'),
      (Icons.description_rounded, 'ملخصاتي'),
      (Icons.quiz_rounded, 'الاختبارات'),
      (Icons.more_horiz_rounded, 'المزيد'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: C.card,
        border: const Border(top: BorderSide(color: C.border, width: 1)),
        boxShadow: [BoxShadow(color: C.purple.withOpacity(0.15),
          blurRadius: 20, offset: const Offset(0, -4))]),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: List.generate(items.length, (i) {
              final active = i == _i;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _i = i),
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(items[i].$1, size: 24,
                          color: active ? C.purpleLt : C.textMuted),
                        const SizedBox(height: 4),
                        Text(items[i].$2,
                          style: TextStyle(fontSize: 11,
                            fontWeight: active ? FontWeight.bold : FontWeight.normal,
                            color: active ? C.purpleLt : C.textMuted)),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ═══════════ Home ═══════════
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 20),
            _startCard(context),
            const SizedBox(height: 16),
            _quickActions(context),
            const SizedBox(height: 20),
            _latestResults(context),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle, gradient: C.gradPrimary),
          child: const CircleAvatar(
            radius: 22, backgroundColor: C.card,
            child: Icon(Icons.person, color: C.purpleLt)),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('مرحبًا بك 👋',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                  color: C.textMain)),
              SizedBox(height: 2),
              Text('لنبدأ رحلتك نحو معرفة أعمق',
                style: TextStyle(fontSize: 12, color: C.textSoft)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: C.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: C.border)),
          child: const Icon(Icons.notifications_none_rounded,
            color: C.textMain),
        ),
      ],
    );
  }

  Widget _startCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => const QuizSetupScreen())),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: C.gradPrimary,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [BoxShadow(color: C.purple.withOpacity(0.4),
            blurRadius: 24, offset: const Offset(0, 8))]),
        child: Row(
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.auto_awesome_rounded,
                color: Colors.white, size: 30),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ابدأ اختبار جديد',
                    style: TextStyle(color: Colors.white, fontSize: 17,
                      fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('حوّل ملخصاتك إلى اختبارات ذكية',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _quickActions(BuildContext context) {
    final items = [
      (Icons.description_rounded, 'ملخصاتي', C.success,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SummariesScreen()))),
      (Icons.quiz_rounded, 'الاختبارات', C.purple,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizzesListScreen()))),
      (Icons.history_rounded, 'سجل المحاولات', C.blue,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()))),
      (Icons.settings_rounded, 'الإعدادات', C.orange,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
    ];
    return Row(
      children: items.map((e) => Expanded(
        child: GestureDetector(
          onTap: e.$4,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: C.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: C.border)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: e.$3.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12)),
                  child: Icon(e.$1, color: e.$3, size: 22),
                ),
                const SizedBox(height: 8),
                Text(e.$2, textAlign: TextAlign.center,
                  style: const TextStyle(color: C.textSoft, fontSize: 11)),
              ],
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _latestResults(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text('آخر النتائج',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,
                  color: C.textMain)),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => const HistoryScreen())),
              child: const Text('عرض الكل',
                style: TextStyle(color: C.purpleLt, fontSize: 13)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (savedResults.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: C.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: C.border)),
            child: const Center(
              child: Text('لا توجد نتائج بعد',
                style: TextStyle(color: C.textMuted)),
            ),
          )
        else
          ...savedResults.take(3).map(_resultRow),
      ],
    );
  }

  Widget _resultRow(QuizResult r) {
    final pct = r.percent;
    final color = pct >= 80 ? C.success : pct >= 50 ? C.warning : C.error;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: C.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: C.border)),
      child: Row(
        children: [
          SizedBox(
            width: 54, height: 54,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: pct / 100, strokeWidth: 5,
                  backgroundColor: C.cardAlt,
                  valueColor: AlwaysStoppedAnimation(color)),
                Text('${pct.toStringAsFixed(0)}%',
                  style: TextStyle(color: color, fontSize: 12,
                    fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.title,
                  style: const TextStyle(color: C.textMain,
                    fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text('${r.score} من ${r.total} سؤال',
                  style: const TextStyle(color: C.textMuted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════ Summaries (قريبًا) ═══════════
class SummariesScreen extends StatelessWidget {
  const SummariesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ملخصاتي',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                color: C.textMain)),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  Icon(Icons.description_outlined, size: 100,
                    color: C.textMuted.withOpacity(0.4)),
                  const SizedBox(height: 16),
                  const Text('ميزة الملخصات ستُفعّل قريبًا',
                    style: TextStyle(color: C.textSoft, fontSize: 15)),
                  const SizedBox(height: 8),
                  const Text('سنضيف التخزين والذكاء الاصطناعي في المرحلة القادمة',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: C.textMuted, fontSize: 12)),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// ═══════════ Quizzes List ═══════════
class QuizzesListScreen extends StatelessWidget {
  const QuizzesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text('الاختبارات',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                color: C.textMain)),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              children: [
                _tile(context, 'اختبار المعلومات العامة', sampleQuestions.length, C.purple),
                _tile(context, 'اختبار سريع', 5, C.blue),
                _tile(context, 'اختبار مكثّف', 10, C.success),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, String title, int count, Color color) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => const QuizSetupScreen())),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: C.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: C.border)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12)),
              child: Icon(Icons.quiz_rounded, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: const TextStyle(color: C.textMain,
                      fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('$count أسئلة',
                    style: const TextStyle(color: C.textMuted, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.play_circle_fill_rounded,
              color: C.purpleLt, size: 30),
          ],
        ),
      ),
    );
  }
}

// ═══════════ More ═══════════
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.person_rounded, 'ملفي الشخصي', C.purple,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()))),
      (Icons.history_rounded, 'سجل المحاولات', C.blue,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()))),
      (Icons.bar_chart_rounded, 'الإحصائيات', C.success,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StatisticsScreen()))),
      (Icons.settings_rounded, 'الإعدادات', C.orange,
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('المزيد',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                color: C.textMain)),
            const SizedBox(height: 20),
            ...items.map((e) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: e.$4,
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: C.card,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: C.border)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: e.$3.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12)),
                        child: Icon(e.$1, color: e.$3, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Text(e.$2,
                        style: const TextStyle(color: C.textMain,
                          fontSize: 15, fontWeight: FontWeight.bold))),
                      const Icon(Icons.arrow_back_ios_new_rounded,
                        color: C.textMuted, size: 16),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// ═══════════ Quiz Setup ═══════════
class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});
  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  int _count = 5;
  String _difficulty = 'متوسط';

  void _start() {
    final questions = sampleQuestions.take(_count).toList();
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => QuizPlayScreen(questions: questions)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_rounded),
          onPressed: () => Navigator.pop(context)),
        title: const Text('إنشاء اختبار'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sectionTitle('عدد الأسئلة'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [5, 10, 15, 20].map((c) => ChoiceChip(
                label: Text('$c'),
                selected: _count == c,
                onSelected: (_) => setState(() => _count = c),
                selectedColor: C.purple,
                backgroundColor: C.cardAlt,
                labelStyle: TextStyle(
                  color: _count == c ? Colors.white : C.textSoft,
                  fontWeight: FontWeight.bold),
              )).toList(),
            ),
            const SizedBox(height: 24),
            _sectionTitle('مستوى الصعوبة'),
            const SizedBox(height: 10),
            Row(
              children: [
                ('سهل', C.success, Icons.sentiment_satisfied_alt),
                ('متوسط', C.warning, Icons.sentiment_neutral),
                ('صعب', C.error, Icons.local_fire_department),
              ].map((l) {
                final sel = _difficulty == l.$1;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _difficulty = l.$1),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: sel ? l.$2.withOpacity(0.25) : C.cardAlt,
                        border: Border.all(
                          color: sel ? l.$2 : Colors.transparent, width: 2),
                        borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          Icon(l.$3, color: sel ? l.$2 : C.textMuted),
                          const SizedBox(height: 6),
                          Text(l.$1, style: TextStyle(
                            color: sel ? l.$2 : C.textMuted,
                            fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _start,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: C.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
              child: const Text('ابدأ الاختبار',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                  color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String t) => Text(t,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
      color: C.textMain));
}

// ═══════════ Quiz Play ═══════════
class QuizPlayScreen extends StatefulWidget {
  final List<Question> questions;
  const QuizPlayScreen({super.key, required this.questions});
  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  int _current = 0;
  final Map<int, int> _answers = {};

  Question get q => widget.questions[_current];
  bool get answered => _answers.containsKey(_current);

  void _select(int i) {
    if (answered) return;
    setState(() => _answers[_current] = i);
  }

  void _next() {
    if (_current < widget.questions.length - 1) {
      setState(() => _current++);
    } else {
      _finish();
    }
  }

  void _prev() {
    if (_current > 0) setState(() => _current--);
  }

  void _finish() {
    int score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (_answers[i] == widget.questions[i].correctIndex) score++;
    }
    savedResults.insert(0, QuizResult(
      'اختبار المعلومات العامة', score, widget.questions.length));
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (_) => ResultScreen(
        score: score, total: widget.questions.length)));
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_current + 1) / widget.questions.length;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context)),
        title: Text('سؤال ${_current + 1} من ${widget.questions.length}'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: C.cardAlt,
            valueColor: const AlwaysStoppedAnimation(C.purple),
            minHeight: 6),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: C.purple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)),
                    child: const Text('اختيار من متعدد',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: C.gradPrimary,
                      borderRadius: BorderRadius.circular(18)),
                    child: Text(q.text,
                      style: const TextStyle(fontSize: 18, height: 1.6,
                        fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(q.options.length, _option),
                ],
              ),
            ),
          ),
          _buttons(),
        ],
      ),
    );
  }

  Widget _option(int i) {
    final selected = _answers[_current] == i;
    final correct = q.correctIndex == i;
    Color border = Colors.transparent;
    Color bg = C.cardAlt;
    if (answered) {
      if (correct) { border = C.success; bg = C.success.withOpacity(0.15); }
      else if (selected) { border = C.error; bg = C.error.withOpacity(0.15); }
    } else if (selected) {
      border = C.purple; bg = C.purple.withOpacity(0.2);
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => _select(i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: border, width: 2),
            borderRadius: BorderRadius.circular(14)),
          child: Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? C.purple : Colors.white.withOpacity(0.1)),
                alignment: Alignment.center,
                child: Text(String.fromCharCode(65 + i),
                  style: const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 14),
              Expanded(child: Text(q.options[i],
                style: const TextStyle(color: C.textMain, fontSize: 15))),
              if (answered && correct)
                const Icon(Icons.check_circle, color: C.success),
              if (answered && selected && !correct)
                const Icon(Icons.cancel, color: C.error),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (_current > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _prev,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('السابق'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: C.purple),
                  foregroundColor: C.purpleLt),
              ),
            ),
          if (_current > 0) const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: answered ? _next : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: C.purple,
                disabledBackgroundColor: C.cardAlt,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
              child: Text(
                _current < widget.questions.length - 1
                  ? 'السؤال التالي' : 'عرض النتيجة',
                style: const TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════ Result ═══════════
class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  const ResultScreen({super.key, required this.score, required this.total});

  double get pct => total > 0 ? (score / total) * 100 : 0;
  Color get color => pct >= 80 ? C.success : pct >= 50 ? C.warning : C.error;
  String get message {
    if (pct >= 90) return 'ممتاز! أداء رائع 🎉';
    if (pct >= 75) return 'جيد جدًا! استمر 👏';
    if (pct >= 50) return 'جيد، يحتاج بعض المراجعة 💪';
    return 'يحتاج مراجعة أكثر، لا تستسلم 📚';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نتيجة الاختبار')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 200, height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200, height: 200,
                    child: CircularProgressIndicator(
                      value: pct / 100, strokeWidth: 14,
                      backgroundColor: C.cardAlt,
                      valueColor: AlwaysStoppedAnimation(color)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${pct.toStringAsFixed(0)}%',
                        style: TextStyle(fontSize: 44,
                          fontWeight: FontWeight.bold, color: color)),
                      Text('$score / $total',
                        style: const TextStyle(fontSize: 16,
                          color: C.textMuted)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold, color: C.textMain)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              icon: const Icon(Icons.home_rounded),
              label: const Text('العودة للرئيسية'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                backgroundColor: C.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const QuizSetupScreen())),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('إعادة الاختبار'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                side: const BorderSide(color: C.purple),
                foregroundColor: C.purpleLt,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════ History ═══════════
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_rounded),
          onPressed: () => Navigator.pop(context)),
        title: const Text('سجل المحاولات'),
      ),
      body: savedResults.isEmpty
        ? const Center(child: Text('لا توجد نتائج بعد',
            style: TextStyle(color: C.textMuted, fontSize: 15)))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: savedResults.length,
            itemBuilder: (context, i) {
              final r = savedResults[i];
              final pct = r.percent;
              final color = pct >= 80 ? C.success
                          : pct >= 50 ? C.warning : C.error;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: C.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: C.border)),
                child: Row(
                  children: [
                    Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(14)),
                      alignment: Alignment.center,
                      child: Text('${pct.toStringAsFixed(0)}%',
                        style: TextStyle(color: color,
                          fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.title,
                            style: const TextStyle(color: C.textMain,
                              fontWeight: FontWeight.bold),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Text('${r.score}/${r.total} سؤال',
                            style: const TextStyle(color: C.textMuted,
                              fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}

// ═══════════ Statistics ═══════════
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_rounded),
          onPressed: () => Navigator.pop(context)),
        title: const Text('الإحصائيات'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _card('عدد الاختبارات', '${savedResults.length}',
              Icons.quiz, C.purple),
            const SizedBox(height: 12),
            _card('متوسط الدرجات',
              savedResults.isEmpty ? '0%' :
              '${(savedResults.map((r) => r.percent).reduce((a,b) => a+b) / savedResults.length).toStringAsFixed(0)}%',
              Icons.trending_up, C.success),
            const SizedBox(height: 12),
            _card('أفضل نتيجة',
              savedResults.isEmpty ? '0%' :
              '${savedResults.map((r) => r.percent).reduce((a,b) => a > b ? a : b).toStringAsFixed(0)}%',
              Icons.emoji_events, C.warning),
          ],
        ),
      ),
    );
  }

  Widget _card(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: C.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: C.border)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(label,
            style: const TextStyle(color: C.textSoft, fontSize: 14))),
          Text(value,
            style: TextStyle(color: color, fontSize: 22,
              fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ═══════════ Settings ═══════════
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_rounded),
          onPressed: () => Navigator.pop(context)),
        title: const Text('الإعدادات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tile(Icons.language, 'اللغة', 'العربية'),
          _tile(Icons.dark_mode, 'الوضع الليلي', 'مفعّل'),
          _tile(Icons.notifications, 'الإشعارات', 'مفعّلة'),
          _tile(Icons.info_outline, 'حول التطبيق', 'الإصدار 1.0.0'),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title, String trailing) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: C.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: C.border)),
      child: Row(
        children: [
          Icon(icon, color: C.purpleLt, size: 22),
          const SizedBox(width: 14),
          Expanded(child: Text(title,
            style: const TextStyle(color: C.textMain, fontSize: 15))),
          Text(trailing,
            style: const TextStyle(color: C.textMuted, fontSize: 13)),
        ],
      ),
    );
  }
}

// ═══════════ Profile ═══════════
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_rounded),
          onPressed: () => Navigator.pop(context)),
        title: const Text('ملفي الشخصي'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const RJLogo(size: 140),
            const SizedBox(height: 20),
            const Text('اختبر نفسك',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,
                color: C.textMain)),
            const SizedBox(height: 8),
            const Text('كل يوم خطوة نحو النجاح',
              style: TextStyle(fontSize: 14, color: C.textSoft)),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: C.card,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: C.border)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _stat('${savedResults.length}', 'اختبار'),
                  Container(width: 1, height: 40, color: C.border),
                  _stat('${savedResults.fold<int>(0, (a, r) => a + r.score)}',
                    'إجابة صحيحة'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 26,
          fontWeight: FontWeight.bold, color: C.purpleLt)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: C.textSoft, fontSize: 13)),
      ],
    );
  }
}
