var mongoose = require("mongoose"),
  jwt = require("jsonwebtoken"),
  bcrypt = require("bcryptjs"),
  User = mongoose.model("users");

exports.register = function (req, res) {
  var newUser = new User(req.body);
  newUser.password = bcrypt.hashSync(req.body.password, 10);
  newUser.save(function (err, user) {
    if (err) {
      return res.status(400).send({ message: err });
    } else {
      user.password = undefined;
      return res.json(user);
    }
  });
};

exports.sign_in = function (req, res) {
  console.log(`Email: ${req.body.email}`);
  User.findOne(
    {
      email: req.body.email,
    },
    function (err, user) {
      if (!user || !user.comparePassword(req.body.password)) {
        return res
          .status(401)
          .json({ message: "Authentication failed. Invalid user or password" });
      }
      return res.json({
        token: jwt.sign(
          { email: user.email, userName: user.userName, _id: user._id },
          "userAPIS"
        ),
      });
    }
  );
};

exports.get_users = function (req, res) {
  const users = User.find().toArray();
  if (users) {
    next();
  } else {
    return res.json({ message: "No users found" });
  }
};

exports.loginRequired = function (req, res, next) {
  if (req.user) {
    next();
  } else {
    return res.status(401).json({ message: "Unauthorized user!" });
  }
};

exports.profile = function (req, res, next) {
  if (req.user) {
    res.send(req.user);
    next();
  } else {
    return res.status(401).json({ message: "Invalid token" });
  }
};
