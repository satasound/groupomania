const Post = require('../models/post-models');
const Comment = require('../models/comment-models');
const User = require('../models/user-models');
const fs = require('fs');
const { DATE } = require('sequelize/dist');
const jwt = require('jsonwebtoken');

/*************************************************
 ************  CREATE POST        **********
 *************************************************/
exports.createPost = (req, res, next) => {
  /////////////////////////////////////////
  if (req.file) {
    Post.create({
      title: req.body.title,
      content: req.body.content,
      image: `${req.protocol}://${req.get('host')}/images/${req.file.filename}`,
      user_id: req.body.user_id,
    })
      .then(() => res.status(201).json({ message: 'Post créé !' }))
      .catch((error) => res.status(400).json({ error }));
  } else {
    Post.create({
      title: req.body.title,
      content: req.body.content,
      user_id: req.body.user_id,
    })
      .then(() => res.status(201).json({ message: 'Post créé !' }))
      .catch((error) => res.status(400).json({ error }));
  }
};

/*************************************************
 ************  GET ALL POSTS        **********
 *************************************************/
exports.getAllPosts = (req, res, next) => {
  /////////////////////////////////////////
  Post.findAll({
    include: [
      {
        model: User,
      },
      {
        model: Comment,
      },
    ],
    order: [['id', 'DESC']],
  })

    .then((post) => res.status(200).json(post))
    .catch((error) => res.status(400).json({ error }));
};

/*************************************************
 ************  GET ONE POST        **********
 *************************************************/
exports.getOnePost = (req, res, nest) => {
  /////////////////////////////////////////
  Post.findOne({
    include: [
      {
        model: User,
      },
    ],
    where: { id: req.params.id },
  })
    .then((post) => res.status(200).json(post))
    .catch((error) => res.status(400).json({ error }));
};

/*************************************************
 ************  GET POST USER       **********
 *************************************************/
exports.getPostsUser = (req, res, next) => {
  /////////////////////////////////////////
  Post.findAll({
    where: {
      user_id: req.params.user_id,
    },
    include: [
      {
        model: User,
      },
    ],
    order: [['created_date', 'ASC']],
  })

    .then((posts) => res.status(200).json(posts))
    .catch((error) => res.status(400).json({ error }));
};

/*************************************************
 ************  DELETE POST        **********
 *************************************************/
exports.deletePost = (req, res, next) => {
  /////////////////////////////////////////
  const token = req.headers.authorization.split(' ')[1];
  const decodedToken = jwt.verify(token, process.env.TOKEN);
  const userId = decodedToken.userId;
  const role = decodedToken.role;

  Post.findOne({ where: { id: req.params.id } })
    .then((post) => {
      if (userId === post.user_id || role === 1) {
        if (post.image != null) {
          const filename = post.image.split('/images/')[1];
          fs.unlink(`images/${filename}`, () => {
            Post.destroy({ where: { id: req.params.id } })

              .then(() => res.status(200).json({ message: 'Post supprimé !' }))
              .catch((error) => res.status(400).json({ error }));
          });
        } else {
          Post.destroy({ where: { id: req.params.id } })

            .then(() => res.status(200).json({ message: 'Post supprimé !' }))
            .catch((error) => res.status(400).json({ error }));
        }
      } else {
        res.status(401).json({
          message: 'Requête non autorisée !',
        });
      }
    })
    .catch((error) => res.status(400).json({ error }));
};
