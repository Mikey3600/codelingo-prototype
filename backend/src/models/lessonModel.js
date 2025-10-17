const mongoose = require('mongoose');

const challengeSchema = new mongoose.Schema({
  id: {
    type: String,
    required: true,
    unique: true
  },
  type: {
    type: String,
    enum: ['multiple_choice', 'fill_in_blank', 'code_completion', 'code_correction'],
    required: true
  },
  instruction: {
    type: String,
    required: true
  },
  codeTemplate: {
    type: String,
    default: null
  },
  options: [{
    type: String
  }],
  correctAnswer: {
    type: String,
    required: true
  },
  hints: [{
    type: String
  }],
  xpReward: {
    type: Number,
    default: 10
  }
});

const lessonSchema = new mongoose.Schema(
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
    language: {
      type: String,
      required: true
    },
    level: {
      type: String,
      enum: ['beginner', 'intermediate', 'advanced'],
      default: 'beginner'
    },
    duration: {
      type: Number, // in minutes
      required: true
    },
    prerequisites: [{
      type: String
    }],
    challenges: [challengeSchema],
    totalXp: {
      type: Number,
      required: true
    },
    order: {
      type: Number,
      required: true
    }
  },
  {
    timestamps: true
  }
);

const Lesson = mongoose.model('Lesson', lessonSchema);

module.exports = Lesson;