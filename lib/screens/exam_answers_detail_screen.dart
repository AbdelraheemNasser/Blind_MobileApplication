import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ExamAnswersDetailScreen extends StatefulWidget {
  final String examId;
  final String examTitle;

  const ExamAnswersDetailScreen({
    super.key,
    required this.examId,
    required this.examTitle,
  });

  @override
  State<ExamAnswersDetailScreen> createState() => _ExamAnswersDetailScreenState();
}

class _ExamAnswersDetailScreenState extends State<ExamAnswersDetailScreen> {
  List<dynamic> _answers = [];
  Map<String, dynamic>? _exam;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Load exam details
      final exam = await ApiService.getExam(widget.examId);
      
      // Load all answers and filter by examId
      final allAnswers = await ApiService.getAnswers('1'); // Get all answers
      final examAnswers = allAnswers.where((a) => a['examId'] == widget.examId).toList();
      
      setState(() {
        _exam = exam;
        _answers = examAnswers;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading answers: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        elevation: 0,
        title: Text(
          widget.examTitle,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _answers.isEmpty
              ? const Center(
                  child: Text(
                    'لا توجد إجابات لهذا الامتحان',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _answers.length,
                  itemBuilder: (context, index) {
                    final answer = _answers[index];
                    return _buildAnswerCard(answer, index);
                  },
                ),
    );
  }

  Widget _buildAnswerCard(dynamic answer, int index) {
    final questionId = answer['questionId'];
    final questionText = _getQuestionText(questionId);
    final answerText = answer['answerText'] ?? 'لم يتم تحويل الإجابة بعد';
    final audioFile = answer['audioFile'];
    final submittedAt = answer['submittedAt'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'سؤال $questionId',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              if (audioFile != null)
                const Icon(Icons.mic, color: Color(0xFF1A237E), size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            questionText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.record_voice_over, size: 18, color: Color(0xFF1A237E)),
                    SizedBox(width: 8),
                    Text(
                      'إجابة الطالب:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  answerText,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          if (submittedAt.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.black54),
                const SizedBox(width: 6),
                Text(
                  'تم التسليم: ${_formatDate(submittedAt)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _getQuestionText(int questionId) {
    if (_exam == null || _exam!['questions'] == null) {
      return 'السؤال رقم $questionId';
    }
    
    final questions = _exam!['questions'] as List;
    if (questionId > 0 && questionId <= questions.length) {
      return questions[questionId - 1]['text'] ?? 'السؤال رقم $questionId';
    }
    
    return 'السؤال رقم $questionId';
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateStr;
    }
  }
}
