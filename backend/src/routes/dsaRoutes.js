const express = require('express');
const router = express.Router();
const { 
  getDSAProblems, 
  getDSAProblemById, 
  submitDSASolution
} = require('../controllers/dsaController');
const { protect } = require('../middleware/authMiddleware');

// Public routes
router.get('/', getDSAProblems);
router.get('/:id', getDSAProblemById);

// Protected routes
router.post('/:id/submit', protect, submitDSASolution);

module.exports = router;