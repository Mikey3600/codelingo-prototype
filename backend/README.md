# CodeLingo Backend API

This is the backend API for the CodeLingo learning platform, built with Node.js, Express, and MongoDB.

## Setup Instructions

1. Install dependencies:
   ```
   npm install
   ```

2. Create a `.env` file in the root directory with the following variables:
   ```
   NODE_ENV=development
   PORT=5000
   MONGODB_URI=mongodb://localhost:27017/codelingo
   JWT_SECRET=your_jwt_secret_key
   ```

3. Start the development server:
   ```
   npm run dev
   ```

## API Endpoints

### Users
- `POST /api/users/register` - Register a new user
- `POST /api/users/login` - Login user
- `GET /api/users/profile` - Get user profile (protected)
- `PUT /api/users/profile` - Update user profile (protected)
- `GET /api/users/progress` - Get user progress (protected)

### Lessons
- `GET /api/lessons` - Get all lessons
- `GET /api/lessons/:id` - Get lesson by ID
- `POST /api/lessons/:id/complete` - Complete a lesson (protected)
- `POST /api/lessons/:lessonId/challenges/:challengeId/complete` - Complete a challenge (protected)

### DSA Problems
- `GET /api/dsa` - Get all DSA problems
- `GET /api/dsa/:id` - Get DSA problem by ID
- `POST /api/dsa/:id/submit` - Submit solution for DSA problem (protected)

### Projects
- `GET /api/projects` - Get all projects
- `GET /api/projects/:id` - Get project by ID
- `POST /api/projects/:id/start` - Start a project (protected)
- `POST /api/projects/:id/steps/:stepId/complete` - Complete a project step (protected)
- `POST /api/projects/:id/complete` - Complete a project (protected)

## Project Structure

```
backend/
├── src/
│   ├── config/         # Configuration files
│   ├── controllers/    # Route controllers
│   ├── middleware/     # Custom middleware
│   ├── models/         # Database models
│   ├── routes/         # API routes
│   ├── services/       # Business logic
│   ├── utils/          # Utility functions
│   └── server.js       # Entry point
├── .env                # Environment variables
└── package.json        # Dependencies and scripts
```