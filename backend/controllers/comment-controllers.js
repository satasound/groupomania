const Comment = require('../models/comment-models');
const Post = require('../models/post-models');
const User = require('../models/user-models');
const jwt = require('jsonwebtoken');

/*************************************************
 ************  CREATE COMMENT        **********
 *************************************************/
exports.createComment = (req, res, next) => {
  /////////////////////////////////////////////
  Comment.create({
    content: req.body.content,
    user_id: req.body.user_id,
    post_id: req.body.post_id,
  })
    .then(() => res.status(201).json({ message: 'Commentaire créé !' }))
    .catch((error) => res.status(400).json({ error }));
};

/*************************************************
 ************  GET POST COMMENTS       **********
 *************************************************/
exports.getPostComments = (req, res, next) => {
  /////////////////////////////////////////////
  Comment.findAll({
    where: {
      post_id: req.params.post_id,
    },
    include: [
      {
        model: User,
      },
    ],
    order: [['date', 'ASC']],
  })

    .then((comments) => res.status(200).json(comments))
    .catch((error) => res.status(400).json({ error }));
};

/*************************************************
 ************  GET ALL COMMENTS        **********
 *************************************************/
exports.getAllComments = (req, res, next) => {
  /////////////////////////////////////////////
  Comment.findAll({
    include: [
      {
        model: User,
      },
      {
        model: Post,
      },
    ],
    order: [['date', 'ASC']],
  })

    .then((comments) => res.status(200).json(comments))
    .catch((error) => res.status(400).json({ error }));
};

/*************************************************
 ************  DELETE POST        **********
 *************************************************/
exports.deleteComment = (req, res, next) => {
  /////////////////////////////////////////////
  const token = req.headers.authorization.split(' ')[1];
  const decodedToken = jwt.verify(token, process.env.TOKEN);
  const userId = decodedToken.userId;
  const role = decodedToken.role;

  Comment.destroy({ where: { id: req.params.id } })

    .then((comment) => {
      if (userId === comment.user_id || role === 1) {
        res.status(200).json({ message: 'Commentaire supprimé !' });
      } else {
        res.status(401).json({
          message: 'Requête non autorisée !',
        });
      }
    })
    .catch((error) => res.status(400).json({ error }));
};
