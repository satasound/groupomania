const express = require('express');
const router = express.Router();

const postCtrl = require('../controllers/post-controllers');
const multer = require('../middleware/multer');
const auth = require('../middleware/auth');

router.post('/', auth, multer, postCtrl.createPost);
router.get('/', auth, postCtrl.getAllPosts);
router.get('/:id', auth, postCtrl.getOnePost);
router.get('/:user_id/posts', auth, postCtrl.getPostsUser);
router.delete('/:id', auth, multer, postCtrl.deletePost);

module.exports = router;
