const express = require('express');
const router = express.Router();

const userCtrl = require('../controllers/user-controllers');
const multer = require('../middleware/multer');
const auth = require('../middleware/auth');

router.post('/signup', userCtrl.signup);
router.post('/login', userCtrl.login);
router.get('/', auth, userCtrl.getAllUsers);
router.get('/:id', auth, userCtrl.getOneUser);
router.delete('/:id', auth, multer, userCtrl.delete);
router.put('/:id', auth, multer, userCtrl.modifyUser);
router.put('/admin/:id', auth, userCtrl.AdminModifyUser);

module.exports = router;
