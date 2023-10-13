module.exports = function (app) {
  var userHandlers = require("../controller/userControllers.js");

  app.route("/sign_in").post(userHandlers.sign_in);
  app.route("/auth/register").post(userHandlers.register);
  app.route("/auth/ger_users").post(userHandlers.get_users);
};
