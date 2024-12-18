'use strict';
const restaurantFactory = require('../factories/restaurantFactory'); // Import the factory
const CuisineType = require('../models/cuisinetype');  // Import the CuisineType model

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    try {
      // Fetch all cuisine types from the database
      const cuisineTypes = await CuisineType.findAll();
      console.log("Cuisine Types:", cuisineTypes); // Log the fetched cuisine types

      if (cuisineTypes.length === 0) {
        console.log("No cuisine types found in the database.");
        return; // Skip the seeding process if no cuisine types are available
      }

      // Generate 10 fake restaurants using the factory
      const restaurants = [];
      for (let i = 0; i < 10; i++) {
        // Pick a random cuisineType from the available cuisineTypes
        const randomCuisineType = cuisineTypes[Math.floor(Math.random() * cuisineTypes.length)];

        // Use the factory to generate random data, passing the cuisineType object
        const restaurantData = restaurantFactory(randomCuisineType);

        if (restaurantData.avatar) {  // Only add the restaurant if it has a valid avatar
          restaurants.push({
            ...restaurantData,  // Spread the generated restaurant data
            cuisineTypeId: randomCuisineType.id,  // Assign the random cuisineTypeId
            createdAt: new Date(),
            updatedAt: new Date(),
          });
        }
      }

      console.log("Generated Restaurants:", restaurants);

      // Insert the generated data into the 'Restaurants' table
      await queryInterface.bulkInsert('Restaurants', restaurants, {});
    } catch (error) {
      console.error("Error in seeding process:", error);
    }
  },

  async down(queryInterface, Sequelize) {
    // Remove all restaurants in case of rollback
    await queryInterface.bulkDelete('Restaurants', null, {});
  }
};