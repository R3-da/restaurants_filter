'use strict';
const restaurantFactory = require('../factories/restaurantFactory'); // Import the factory

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    // Generate 10 fake restaurants using the factory
    const restaurants = [];
    for (let i = 0; i < 10; i++) {
      restaurants.push({
        ...restaurantFactory(),  // Use the factory to generate random data
        createdAt: new Date(),
        updatedAt: new Date(),
      });
    }

    // Insert the generated data into the 'Restaurants' table
    await queryInterface.bulkInsert('Restaurants', restaurants, {});
  },

  async down (queryInterface, Sequelize) {
    // Remove all restaurants in case of rollback
    await queryInterface.bulkDelete('Restaurants', null, {});
  }
};