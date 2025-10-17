const mongoose = require('mongoose');
const dotenv = require('dotenv');
const colors = require('colors');
const fs = require('fs');
const path = require('path');

// Models
const User = require('../models/userModel');
const Lesson = require('../models/lessonModel');
const DSAProblem = require('../models/dsaProblemModel');
const Project = require('../models/projectModel');

// Config
dotenv.config();
const connectDB = require('../config/database');

// Connect to database
connectDB();

// Read JSON files
const lessons = JSON.parse(
  fs.readFileSync(path.join(__dirname, '../data/lessons.json'), 'utf-8')
);

const dsaProblems = JSON.parse(
  fs.readFileSync(path.join(__dirname, '../data/dsa_problems.json'), 'utf-8')
);

const projects = JSON.parse(
  fs.readFileSync(path.join(__dirname, '../data/projects.json'), 'utf-8')
);

// Import data into DB
const importData = async () => {
  try {
    // Clear existing data
    await User.deleteMany();
    await Lesson.deleteMany();
    await DSAProblem.deleteMany();
    await Project.deleteMany();

    console.log('Data cleared...'.red.inverse);

    // Create admin user
    await User.create({
      name: 'Admin User',
      email: 'admin@codelingo.com',
      password: 'password123',
      isAdmin: true,
    });

    console.log('Admin user created...'.green);

    // Import data
    await Lesson.insertMany(lessons);
    await DSAProblem.insertMany(dsaProblems);
    await Project.insertMany(projects);

    console.log('Data imported successfully!'.green.inverse);
    process.exit();
  } catch (error) {
    console.error(`${error}`.red.inverse);
    process.exit(1);
  }
};

// Delete data from DB
const destroyData = async () => {
  try {
    // Clear existing data
    await User.deleteMany();
    await Lesson.deleteMany();
    await DSAProblem.deleteMany();
    await Project.deleteMany();

    console.log('Data destroyed successfully!'.red.inverse);
    process.exit();
  } catch (error) {
    console.error(`${error}`.red.inverse);
    process.exit(1);
  }
};

// Check command line argument to determine action
if (process.argv[2] === '-d') {
  destroyData();
} else {
  importData();
}