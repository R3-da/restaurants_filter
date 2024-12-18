const Sequelize = require('sequelize');

// Initialize Sequelize with SQLite database
const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: './db/development.db'  // Path to your SQLite database
});

module.exports = sequelize;