const express = require('express');
const router = express.Router();

const userCtrl = require('../controllers/user-controllers');
const multerProfile = require('../middleware/multer-profile');
const auth = require('../middleware/auth');

router.post('/signup', userCtrl.signup);
router.post('/login', userCtrl.login);
router.get('/', auth, userCtrl.getAllUsers);
router.get('/:id', auth, userCtrl.getOneUser);
router.delete('/:id', auth, multerProfile, userCtrl.delete);
router.put('/:id', auth, multerProfile, userCtrl.modifyUser);
router.put('/admin/:id', auth, userCtrl.AdminModifyUser);

module.exports = router;
