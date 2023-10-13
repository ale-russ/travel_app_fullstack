const express = require("express");
const router = require("express").Router();
const { login, getUsers, addUser } = require("./auth/auth");

router.route("/login").post(login);
module.exports = router;
