require('dotenv').config();
const { Sequelize, DataTypes } = require('sequelize');

const sequelize = new Sequelize('groupomania', 'root', '', {
  host: 'localhost',
  dialect: 'mysql',
});

module.exports = sequelize;
