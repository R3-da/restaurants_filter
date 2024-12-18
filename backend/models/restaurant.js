// models/restaurant.js
const { Model, DataTypes } = require('sequelize');
const sequelize = require('../db');
const CuisineType = require('./cuisinetype');  // Import CuisineType model

class Restaurant extends Model {}

Restaurant.init(
  {
    name: DataTypes.STRING,
    avatar: DataTypes.STRING,
  },
  {
    sequelize,
    modelName: 'Restaurant',
  }
);

// Define the association
Restaurant.belongsTo(CuisineType);  // A restaurant belongs to a cuisine type
CuisineType.hasMany(Restaurant);  // A cuisine type has many restaurants

module.exports = Restaurant;