const dotenv = require('dotenv');

// Load environment variables
dotenv.config();

module.exports = {
  NODE_ENV: process.env.NODE_ENV || 'development',
  PORT: process.env.PORT || 5000,
  MONGODB_URI: process.env.MONGODB_URI || 'mongodb://localhost:27017/codelingo',
  JWT_SECRET: process.env.JWT_SECRET || 'codelingo_secret_key',
  JWT_EXPIRE: process.env.JWT_EXPIRE || '30d',
  XP_PER_LEVEL: 100, // XP required to level up
  MAX_LEVEL: 50 // Maximum level a user can reach
};