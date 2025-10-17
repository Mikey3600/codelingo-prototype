const Lesson = require('../models/lessonModel');
const User = require('../models/userModel');

// @desc    Get all lessons
// @route   GET /api/lessons
// @access  Public
const getLessons = async (req, res) => {
  try {
    const lessons = await Lesson.find({}).select('-challenges.correctAnswer');
    
    res.json({
      success: true,
      count: lessons.length,
      lessons
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get lesson by ID
// @route   GET /api/lessons/:id
// @access  Public
const getLessonById = async (req, res) => {
  try {
    const lesson = await Lesson.findOne({ id: req.params.id });

    if (lesson) {
      // Remove correct answers from response for security
      const lessonData = lesson.toObject();
      lessonData.challenges = lessonData.challenges.map(challenge => {
        const { correctAnswer, ...rest } = challenge;
        return rest;
      });
      
      res.json({
        success: true,
        lesson: lessonData
      });
    } else {
      res.status(404).json({
        success: false,
        message: 'Lesson not found'
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Complete a lesson
// @route   POST /api/lessons/:id/complete
// @access  Private
const completeLesson = async (req, res) => {
  try {
    const lesson = await Lesson.findOne({ id: req.params.id });
    
    if (!lesson) {
      return res.status(404).json({
        success: false,
        message: 'Lesson not found'
      });
    }

    const user = await User.findById(req.user._id);
    
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    // Check if lesson is already completed
    if (user.completedLessons.includes(lesson.id)) {
      return res.status(400).json({
        success: false,
        message: 'Lesson already completed'
      });
    }

    // Add lesson to completed lessons
    user.completedLessons.push(lesson.id);
    
    // Add XP to user
    user.xp += lesson.totalXp;
    
    // Update daily progress
    user.dailyProgress += lesson.totalXp;
    
    // Check if user leveled up (simple level calculation)
    const newLevel = Math.floor(user.xp / 100) + 1;
    if (newLevel > user.level) {
      user.level = newLevel;
    }
    
    // Update streak if needed
    const lastActiveDate = new Date(user.lastActive);
    const currentDate = new Date();
    
    // Reset streak if more than a day has passed
    if (currentDate.getDate() !== lastActiveDate.getDate() || 
        currentDate.getMonth() !== lastActiveDate.getMonth() || 
        currentDate.getFullYear() !== lastActiveDate.getFullYear()) {
      user.streak += 1;
    }
    
    // Update last active
    user.lastActive = Date.now();
    
    await user.save();
    
    res.json({
      success: true,
      message: 'Lesson completed successfully',
      xpEarned: lesson.totalXp,
      newXp: user.xp,
      newLevel: user.level,
      streak: user.streak
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Complete a challenge within a lesson
// @route   POST /api/lessons/:lessonId/challenges/:challengeId/complete
// @access  Private
const completeChallenge = async (req, res) => {
  try {
    const { lessonId, challengeId } = req.params;
    const { answer } = req.body;
    
    const lesson = await Lesson.findOne({ id: lessonId });
    
    if (!lesson) {
      return res.status(404).json({
        success: false,
        message: 'Lesson not found'
      });
    }
    
    const challenge = lesson.challenges.find(c => c.id === challengeId);
    
    if (!challenge) {
      return res.status(404).json({
        success: false,
        message: 'Challenge not found'
      });
    }
    
    // Check if answer is correct
    const isCorrect = answer === challenge.correctAnswer;
    
    if (isCorrect) {
      const user = await User.findById(req.user._id);
      
      // Add XP to user
      user.xp += challenge.xpReward;
      
      // Update daily progress
      user.dailyProgress += challenge.xpReward;
      
      // Check if user leveled up
      const newLevel = Math.floor(user.xp / 100) + 1;
      if (newLevel > user.level) {
        user.level = newLevel;
      }
      
      // Update last active
      user.lastActive = Date.now();
      
      await user.save();
      
      res.json({
        success: true,
        isCorrect,
        xpEarned: challenge.xpReward,
        newXp: user.xp,
        newLevel: user.level
      });
    } else {
      res.json({
        success: true,
        isCorrect,
        xpEarned: 0
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

module.exports = {
  getLessons,
  getLessonById,
  completeLesson,
  completeChallenge
};