const sequelize = require("sequelize");

const db = new sequelize("crudnodejs", "alam", "Sadvikaalam98_", {
  host : "172.16.32.5", 
  dialect: "mysql"
});

db.sync({});

module.exports = db;
