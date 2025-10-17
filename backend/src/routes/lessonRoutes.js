const express = require('express');
const router = express.Router();
const { 
  getLessons, 
  getLessonById, 
  completeLesson,
  completeChallenge
} = require('../controllers/lessonController');
const { protect } = require('../middleware/authMiddleware');

// Public routes
router.get('/', getLessons);
router.get('/:id', getLessonById);

// Protected routes
router.post('/:id/complete', protect, completeLesson);
router.post('/:lessonId/challenges/:challengeId/complete', protect, completeChallenge);

module.exports = router;