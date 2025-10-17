import 'package:flutter/material.dart';
import '../../models/challenge_model.dart';
import '../common/custom_button.dart';
import '../code_editor/code_input_field.dart';

class ChallengeCard extends StatefulWidget {
  final Challenge challenge;
  final Function(String) onSubmit;
  final Function() onSkip;
  final Function() onHintRequested;

  const ChallengeCard({
    Key? key,
    required this.challenge,
    required this.onSubmit,
    required this.onSkip,
    required this.onHintRequested,
  }) : super(key: key);

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  late String _currentCode;
  String? _selectedOption;
  bool _showHint = false;
  
  @override
  void initState() {
    super.initState();
    _currentCode = widget.challenge.codeTemplate ?? '';
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // XP reward badge
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${widget.challenge.xpReward} XP',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Challenge instruction
            Text(
              widget.challenge.instruction,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            
            const SizedBox(height: 24),
            
            // Challenge content based on type
            _buildChallengeContent(),
            
            const SizedBox(height: 16),
            
            // Hint section
            if (widget.challenge.hints != null && widget.challenge.hints!.isNotEmpty)
              _buildHintSection(),
            
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: 'Skip',
                  onPressed: widget.onSkip,
                  type: ButtonType.outline,
                  isFullWidth: false,
                ),
                CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    if (widget.challenge.type == 'multiple_choice') {
                      widget.onSubmit(_selectedOption ?? '');
                    } else {
                      widget.onSubmit(_currentCode);
                    }
                  },
                  isFullWidth: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildChallengeContent() {
    switch (widget.challenge.type) {
      case 'multiple_choice':
        return _buildMultipleChoiceChallenge();
      case 'fill_in_blank':
        return _buildFillInBlankChallenge();
      case 'code_completion':
      default:
        return _buildCodeCompletionChallenge();
    }
  }
  
  Widget _buildMultipleChoiceChallenge() {
    return Column(
      children: [
        ...(widget.challenge.options ?? []).map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
            activeColor: Theme.of(context).primaryColor,
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ],
    );
  }
  
  Widget _buildFillInBlankChallenge() {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Type your answer here...',
      ),
      onChanged: (value) {
        _currentCode = value;
      },
    );
  }
  
  Widget _buildCodeCompletionChallenge() {
    return CodeInputField(
      initialCode: widget.challenge.codeTemplate ?? '',
      language: 'python', // This should be dynamic based on the selected language
      onCodeChanged: (code) {
        _currentCode = code;
      },
    );
  }
  
  Widget _buildHintSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_showHint)
          TextButton.icon(
            icon: const Icon(Icons.lightbulb_outline),
            label: const Text('Need a hint?'),
            onPressed: () {
              setState(() {
                _showHint = true;
              });
              widget.onHintRequested();
            },
          )
        else if (widget.challenge.hints != null && widget.challenge.hints!.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Hint:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(widget.challenge.hints!.first),
              ],
            ),
          ),
      ],
    );
  }
}