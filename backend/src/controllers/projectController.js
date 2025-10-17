const Project = require('../models/projectModel');
const User = require('../models/userModel');

// @desc    Get all projects
// @route   GET /api/projects
// @access  Public
const getProjects = async (req, res) => {
  try {
    const projects = await Project.find({});
    
    res.json({
      success: true,
      count: projects.length,
      projects
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Get project by ID
// @route   GET /api/projects/:id
// @access  Public
const getProjectById = async (req, res) => {
  try {
    const project = await Project.findOne({ id: req.params.id });

    if (project) {
      res.json({
        success: true,
        project
      });
    } else {
      res.status(404).json({
        success: false,
        message: 'Project not found'
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Start a project
// @route   POST /api/projects/:id/start
// @access  Private
const startProject = async (req, res) => {
  try {
    const project = await Project.findOne({ id: req.params.id });
    
    if (!project) {
      return res.status(404).json({
        success: false,
        message: 'Project not found'
      });
    }

    const user = await User.findById(req.user._id);
    
    // Check if project is locked
    if (project.isLocked) {
      // Check if user meets unlock requirements
      const meetsLevelRequirement = user.level >= project.unlockRequirements.minLevel;
      const completedRequiredLessons = project.unlockRequirements.lessonIds.every(
        lessonId => user.completedLessons.includes(lessonId)
      );
      
      if (!meetsLevelRequirement || !completedRequiredLessons) {
        return res.status(403).json({
          success: false,
          message: 'You have not met the requirements to unlock this project',
          requirements: {
            level: {
              required: project.unlockRequirements.minLevel,
              current: user.level
            },
            lessons: {
              required: project.unlockRequirements.lessonIds,
              completed: user.completedLessons
            }
          }
        });
      }
    }
    
    res.json({
      success: true,
      message: 'Project started successfully',
      project: {
        id: project.id,
        title: project.title,
        steps: project.steps
      }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Complete a project step
// @route   POST /api/projects/:id/steps/:stepId/complete
// @access  Private
const completeProjectStep = async (req, res) => {
  try {
    const { id, stepId } = req.params;
    const { code } = req.body;
    
    const project = await Project.findOne({ id });
    
    if (!project) {
      return res.status(404).json({
        success: false,
        message: 'Project not found'
      });
    }
    
    const stepIndex = parseInt(stepId) - 1;
    if (stepIndex < 0 || stepIndex >= project.steps.length) {
      return res.status(404).json({
        success: false,
        message: 'Step not found'
      });
    }
    
    const step = project.steps[stepIndex];
    
    // In a real application, this would validate the code against expected output
    // For now, we'll simulate with a simple check
    const isCorrect = code && code.length > 0;
    
    if (isCorrect) {
      res.json({
        success: true,
        message: 'Step completed successfully',
        nextStep: stepIndex < project.steps.length - 1 ? stepIndex + 1 : null
      });
    } else {
      res.json({
        success: false,
        message: 'Your solution does not match the expected output'
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

// @desc    Complete a project
// @route   POST /api/projects/:id/complete
// @access  Private
const completeProject = async (req, res) => {
  try {
    const project = await Project.findOne({ id: req.params.id });
    
    if (!project) {
      return res.status(404).json({
        success: false,
        message: 'Project not found'
      });
    }

    const user = await User.findById(req.user._id);
    
    // Check if project is already completed
    if (user.completedProjects.includes(project.id)) {
      return res.status(400).json({
        success: false,
        message: 'Project already completed'
      });
    }
    
    // Add project to completed projects
    user.completedProjects.push(project.id);
    
    // Add XP to user
    user.xp += project.xpReward;
    
    // Update daily progress
    user.dailyProgress += project.xpReward;
    
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
      message: 'Project completed successfully',
      xpEarned: project.xpReward,
      newXp: user.xp,
      newLevel: user.level
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

module.exports = {
  getProjects,
  getProjectById,
  startProject,
  completeProjectStep,
  completeProject
};