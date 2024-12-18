'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.bulkInsert('CuisineTypes', [
      { name: 'Italian', createdAt: new Date(), updatedAt: new Date() },
      { name: 'Chinese', createdAt: new Date(), updatedAt: new Date() },
      { name: 'Indian', createdAt: new Date(), updatedAt: new Date() },
      { name: 'Mexican', createdAt: new Date(), updatedAt: new Date() },
      { name: 'Japanese', createdAt: new Date(), updatedAt: new Date() },
      { name: 'French', createdAt: new Date(), updatedAt: new Date() },
    ], {});
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete('CuisineTypes', null, {});
  }
};