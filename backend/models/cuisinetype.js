// models/cuisinetype.js
const { Model, DataTypes } = require('sequelize');
const sequelize = require('../db');

class CuisineType extends Model {}

CuisineType.init(
  {
    name: DataTypes.STRING,
  },
  {
    sequelize,
    modelName: 'CuisineType',
  }
);

module.exports = CuisineType;