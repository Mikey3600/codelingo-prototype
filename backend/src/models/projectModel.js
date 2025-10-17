const mongoose = require('mongoose');

const projectSchema = new mongoose.Schema(
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
      type: Number, // in hours
      required: true
    },
    prerequisites: [{
      type: String
    }],
    tags: [{
      type: String
    }],
    steps: [{
      title: String,
      description: String,
      codeTemplate: String,
      expectedOutput: String
    }],
    xpReward: {
      type: Number,
      default: 100
    },
    isLocked: {
      type: Boolean,
      default: false
    },
    unlockRequirements: {
      lessonIds: [String],
      minLevel: Number
    }
  },
  {
    timestamps: true
  }
);

const Project = mongoose.model('Project', projectSchema);

module.exports = Project;