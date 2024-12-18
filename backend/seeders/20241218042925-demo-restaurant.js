'use strict';
const restaurantFactory = require('../factories/restaurantFactory'); // Import the factory
const CuisineType = require('../models/cuisinetype');  // Import the CuisineType model


/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    // Fetch all cuisine types from the database
    const cuisineTypes = await CuisineType.findAll();

    // Generate 10 fake restaurants using the factory
    const restaurants = [];
    for (let i = 0; i < 10; i++) {
      // Pick a random cuisineTypeId from the available cuisineTypes
      const randomCuisineType = cuisineTypes[Math.floor(Math.random() * cuisineTypes.length)];

      restaurants.push({
        ...restaurantFactory(),  // Use the factory to generate random data
        cuisineTypeId: randomCuisineType.id,  // Assign the random cuisineTypeId
        createdAt: new Date(),
        updatedAt: new Date(),
      });
    }

    console.log(restaurants);

    // Insert the generated data into the 'Restaurants' table
    await queryInterface.bulkInsert('Restaurants', restaurants, {});

    
  },

  async down(queryInterface, Sequelize) {
    // Remove all restaurants in case of rollback
    await queryInterface.bulkDelete('Restaurants', null, {});
  }
};