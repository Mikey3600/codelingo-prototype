const mongoose = require('mongoose');

const testCaseSchema = new mongoose.Schema({
  input: {
    type: String,
    required: true
  },
  expectedOutput: {
    type: String,
    required: true
  },
  isHidden: {
    type: Boolean,
    default: false
  }
});

const dsaProblemSchema = new mongoose.Schema(
  {
    id: {
      type: String,
      required: true,
      unique: true
    },
    title: {
      type: String,
      required: true
    },
    description: {
      type: String,
      required: true
    },
    difficulty: {
      type: String,
      enum: ['easy', 'medium', 'hard'],
      default: 'easy'
    },
    category: {
      type: String,
      required: true
    },
    codeTemplates: {
      python: { type: String, default: '' },
      javascript: { type: String, default: '' },
      java: { type: String, default: '' },
      cpp: { type: String, default: '' }
    },
    testCases: [testCaseSchema],
    hints: [{
      type: String
    }],
    solution: {
      python: { type: String, default: '' },
      javascript: { type: String, default: '' },
      java: { type: String, default: '' },
      cpp: { type: String, default: '' }
    },
    xpReward: {
      type: Number,
      default: 20
    },
    timeComplexity: {
      type: String,
      default: 'O(n)'
    },
    spaceComplexity: {
      type: String,
      default: 'O(n)'
    }
  },
  {
    timestamps: true
  }
);

const DSAProblem = mongoose.model('DSAProblem', dsaProblemSchema);

module.exports = DSAProblem;