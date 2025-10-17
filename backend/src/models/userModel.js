const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Please provide your name'],
      trim: true
    },
    email: {
      type: String,
      required: [true, 'Please provide your email'],
      unique: true,
      lowercase: true,
      trim: true
    },
    password: {
      type: String,
      required: [true, 'Please provide a password'],
      minlength: 8,
      select: false
    },
    photoUrl: {
      type: String,
      default: null
    },
    level: {
      type: Number,
      default: 1
    },
    xp: {
      type: Number,
      default: 0
    },
    streak: {
      type: Number,
      default: 0
    },
    lastActive: {
      type: Date,
      default: Date.now
    },
    dailyGoal: {
      type: Number,
      default: 50
    },
    dailyProgress: {
      type: Number,
      default: 0
    },
    completedLessons: [{
      type: String
    }],
    completedProjects: [{
      type: String
    }],
    completedDSAProblems: [{
      type: String
    }]
  },
  {
    timestamps: true
  }
);

// Encrypt password before saving
userSchema.pre('save', async function(next) {
  if (!this.isModified('password')) {
    return next();
  }
  
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

// Method to check if password matches
userSchema.methods.matchPassword = async function(enteredPassword) {
  return await bcrypt.compare(enteredPassword, this.password);
};

const User = mongoose.model('User', userSchema);

module.exports = User;