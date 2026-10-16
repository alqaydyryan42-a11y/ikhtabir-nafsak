import 'package:flutter/material.dart';

void main() {
  runApp(const IkhtabirApp());
}

class IkhtabirApp extends StatelessWidget {
  const IkhtabirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اختبر نفسك',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF0F4FF),
        useMaterial3: false,
      ),
      home: const HomeScreen(),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  const Question({required this.text, required this.options, required this.correctIndex});
}

const List<Question> allQuestions = [
  Question(text: 'ما هي عاصمة المملكة العربية السعودية؟',
    options: ['مكة المكرمة', 'الرياض', 'جدة', 'المدينة المنورة'], correctIndex: 1),
  Question(text: 'كم عدد أيام السنة الميلادية؟',
    options: ['360 يوم', '365 يوم', '354 يوم', '370 يوم'], correctIndex: 1),
  Question(text: 'ما هو أكبر كوكب في المجموعة الشمسية؟',
    options: ['الأرض', 'المريخ', 'المشتري', 'زحل'], correctIndex: 2),
  Question(text: 'كم عدد فصول السنة؟',
    options: ['اثنان', 'ثلاثة', 'أربعة', 'خمسة'], correctIndex: 2),
  Question(text: 'ما هو الحيوان الملقب بسفينة الصحراء؟',
    options: ['الحصان', 'الجمل', 'الفيل', 'الحمار'], correctIndex: 1),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(color: Colors.indigo.shade50, shape: BoxShape.circle),
                  child: Icon(Icons.psychology, size: 100, color: Colors.indigo.shade700),
                ),
                const SizedBox(height: 30),
                const Text('اختبر نفسك',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.indigo)),
                const SizedBox(height: 12),
                Text('اختبر معلوماتك بأسلوب ممتع وسريع',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700), textAlign: TextAlign.center),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity, height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo, foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 4),
                    child: const Text('ابدأ الاختبار',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
                const Spacer(),
                Text('عدد الأسئلة: ${allQuestions.length}',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  int? selectedIndex;
  bool answered = false;

  void _selectAnswer(int index) {
    if (answered) return;
    setState(() {
      selectedIndex = index;
      answered = true;
      if (index == allQuestions[currentQuestion].correctIndex) score++;
    });
  }

  void _nextQuestion() {
    if (currentQuestion < allQuestions.length - 1) {
      setState(() { currentQuestion++; selectedIndex = null; answered = false; });
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ResultScreen(score: score, total: allQuestions.length)));
    }
  }

  Color _optionColor(int index) {
    if (!answered) return Colors.white;
    if (index == allQuestions[currentQuestion].correctIndex) return Colors.green.shade100;
    if (index == selectedIndex) return Colors.red.shade100;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final question = allQuestions[currentQuestion];
    final progress = (currentQuestion + 1) / allQuestions.length;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('السؤال ${currentQuestion + 1} من ${allQuestions.length}'),
          backgroundColor: Colors.indigo, foregroundColor: Colors.white),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(value: progress, minHeight: 10,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo)),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
                  child: Text(question.text,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.5),
                    textAlign: TextAlign.center),
                ),
                const SizedBox(height: 30),
                ...List.generate(question.options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => _selectAnswer(index),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: _optionColor(index),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300, width: 1.5)),
                        child: Row(
                          children: [
                            Container(width: 32, height: 32,
                              decoration: BoxDecoration(color: Colors.indigo.shade50, shape: BoxShape.circle),
                              child: Center(child: Text(['أ', 'ب', 'ج', 'د'][index],
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)))),
                            const SizedBox(width: 12),
                            Expanded(child: Text(question.options[index], style: const TextStyle(fontSize: 16))),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const Spacer(),
                if (answered)
                  SizedBox(height: 55,
                    child: ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      child: Text(currentQuestion < allQuestions.length - 1 ? 'السؤال التالي' : 'عرض النتيجة',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  const ResultScreen({super.key, required this.score, required this.total});

  String get _message {
    final ratio = score / total;
    if (ratio == 1.0) return 'ممتاز! إجاباتك كلها صحيحة 🏆';
    if (ratio >= 0.7) return 'رائع! نتيجة جيدة جدًا 👏';
    if (ratio >= 0.5) return 'جيد، لكن يمكنك الأفضل 💪';
    return 'لا بأس، حاول مرة أخرى 📚';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                Icon(score >= total * 0.7 ? Icons.emoji_events : Icons.school,
                  size: 100, color: score >= total * 0.7 ? Colors.amber : Colors.indigo),
                const SizedBox(height: 30),
                const Text('النتيجة', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(20)),
                  child: Text('$score / $total',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.indigo)),
                ),
                const SizedBox(height: 24),
                Text(_message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
                const Spacer(),
                SizedBox(width: double.infinity, height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة الاختبار',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
