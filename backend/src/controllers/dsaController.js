const DSAProblem = require('../models/dsaProblemModel');
const User = require('../models/userModel');

// @desc    Get all DSA problems
// @route   GET /api/dsa
// @access  Public
const getDSAProblems = async (req, res) => {
  try {
    const problems = await DSAProblem.find({}).select('-testCases.isHidden -solution');
    
    res.json({
      success: true,
      count: problems.length,
      problems
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get DSA problem by ID
// @route   GET /api/dsa/:id
// @access  Public
const getDSAProblemById = async (req, res) => {
  try {
    const problem = await DSAProblem.findOne({ id: req.params.id });

    if (problem) {
      // Remove hidden test cases and solutions from response
      const problemData = problem.toObject();
      problemData.testCases = problemData.testCases.filter(test => !test.isHidden);
      delete problemData.solution;
      
      res.json({
        success: true,
        problem: problemData
      });
    } else {
      res.status(404).json({
        success: false,
        message: 'DSA problem not found'
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Submit solution for DSA problem
// @route   POST /api/dsa/:id/submit
// @access  Private
const submitDSASolution = async (req, res) => {
  try {
    const { code, language } = req.body;
    
    if (!code || !language) {
      return res.status(400).json({
        success: false,
        message: 'Please provide code and language'
      });
    }
    
    const problem = await DSAProblem.findOne({ id: req.params.id });
    
    if (!problem) {
      return res.status(404).json({
        success: false,
        message: 'DSA problem not found'
      });
    }
    
    // In a real application, this would execute the code against test cases
    // For now, we'll simulate code execution with a simple check
    const isCorrect = code.includes(problem.solution[language]?.substring(0, 10));
    
    if (isCorrect) {
      const user = await User.findById(req.user._id);
      
      // Check if problem is already completed
      if (!user.completedDSAProblems.includes(problem.id)) {
        // Add problem to completed problems
        user.completedDSAProblems.push(problem.id);
        
        // Add XP to user
        user.xp += problem.xpReward;
        
        // Update daily progress
        user.dailyProgress += problem.xpReward;
        
        // Check if user leveled up
        const newLevel = Math.floor(user.xp / 100) + 1;
        if (newLevel > user.level) {
          user.level = newLevel;
        }
        
        // Update last active
        user.lastActive = Date.now();
        
        await user.save();
      }
      
      res.json({
        success: true,
        result: {
          passed: true,
          message: 'All test cases passed!',
          xpEarned: user.completedDSAProblems.includes(problem.id) ? 0 : problem.xpReward,
          newXp: user.xp,
          newLevel: user.level
        }
      });
    } else {
      res.json({
        success: true,
        result: {
          passed: false,
          message: 'Some test cases failed. Try again!',
          xpEarned: 0
        }
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
  getDSAProblems,
  getDSAProblemById,
  submitDSASolution
};