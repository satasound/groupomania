const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const commentCtrl = require('../controllers/comment-controllers');


router.post('/', auth, commentCtrl.createComment);
router.delete('/:id', auth, commentCtrl.deleteComment);
router.get('/:post_id', auth, commentCtrl.getPostComments);
router.get('/', auth, commentCtrl.getAllComments);

module.exports = router;
