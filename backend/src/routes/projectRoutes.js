const express = require('express');
const router = express.Router();
const { 
  getProjects, 
  getProjectById, 
  startProject,
  completeProjectStep,
  completeProject
} = require('../controllers/projectController');
const { protect } = require('../middleware/authMiddleware');

// Public routes
router.get('/', getProjects);
router.get('/:id', getProjectById);

// Protected routes
router.post('/:id/start', protect, startProject);
router.post('/:id/steps/:stepId/complete', protect, completeProjectStep);
router.post('/:id/complete', protect, completeProject);

module.exports = router;