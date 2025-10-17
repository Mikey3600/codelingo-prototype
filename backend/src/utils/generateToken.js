const jwt = require('jsonwebtoken');

/**
 * Generate a JWT token for user authentication
 * @param {string} id - User ID to encode in the token
 * @param {string} expiresIn - Token expiration time (default: 30 days)
 * @returns {string} JWT token
 */
const generateToken = (id, expiresIn = '30d') => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn,
  });
};

module.exports = generateToken;