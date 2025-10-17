const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const dotenv = require('dotenv');
const path = require('path');

// Load environment variables
dotenv.config();

// Import routes
const userRoutes = require('./routes/userRoutes');
const lessonRoutes = require('./routes/lessonRoutes');
const dsaRoutes = require('./routes/dsaRoutes');
const projectRoutes = require('./routes/projectRoutes');

// Import middleware
const { notFound, errorHandler } = require('./middleware/errorMiddleware');

// Import database connection
const connectDB = require('./config/database');

// Initialize express app
const app = express();

// Connect to database
connectDB();

// Middleware
app.use(cors());
app.use(express.json());

// Use morgan logger only in development mode
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'));
}

// Routes
app.use('/api/users', userRoutes);
app.use('/api/lessons', lessonRoutes);
app.use('/api/dsa', dsaRoutes);
app.use('/api/projects', projectRoutes);

// Root route
app.get('/', (req, res) => {
  res.json({ 
    message: 'Welcome to CodeLingo API',
    version: '1.0.0',
    environment: process.env.NODE_ENV
  });
});

// Apply error handling middleware
app.use(notFound);
app.use(errorHandler);

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`);
});

module.exports = app;