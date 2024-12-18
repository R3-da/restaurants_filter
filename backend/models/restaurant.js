const { Model, DataTypes } = require('sequelize');
const sequelize = require('../db');  // Import the sequelize instance

class Restaurant extends Model {}

Restaurant.init(
  {
    name: DataTypes.STRING,
    cuisineType: DataTypes.STRING,
    avatar: DataTypes.STRING,
  },
  {
    sequelize,  // Pass the sequelize instance here
    modelName: 'Restaurant',  // The model name
  }
);

module.exports = Restaurant;  // Export the model