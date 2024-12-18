// models/restaurant.js
const { Model, DataTypes } = require('sequelize');
const sequelize = require('../db');
const CuisineType = require('./cuisinetype');  // Import CuisineType model

class Restaurant extends Model {}

Restaurant.init(
  {
    name: {
      type: DataTypes.STRING,
      allowNull: false,  // You can add validation if necessary
    },
    avatar: {
      type: DataTypes.STRING,
      allowNull: true,  // Avatar is optional, so allowNull can be true
    },
  },
  {
    sequelize,
    modelName: 'Restaurant',
  }
);

// Define the association
Restaurant.belongsTo(CuisineType, {
  foreignKey: 'cuisineTypeId',  // This is optional if Sequelize can infer it
  as: 'cuisineType',  // Alias for the association
});

CuisineType.hasMany(Restaurant, {
  foreignKey: 'cuisineTypeId',
  as: 'restaurants',  // Alias for the association
});

module.exports = Restaurant;