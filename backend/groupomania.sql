-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 14 mars 2022 à 15:59
-- Version du serveur :  10.4.10-MariaDB
-- Version de PHP : 7.4.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `groupomania`
--

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

CREATE TABLE `comments` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL,
  `post_id` smallint(5) UNSIGNED NOT NULL,
  `user_id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id`, `content`, `date`, `post_id`, `user_id`) VALUES
(5, 'Hey Denzel, are you talking to me?', '2022-03-13 13:45:08', 10, 2),
(6, 'I\'am talking to beatiful Keira', '2022-03-13 13:46:01', 9, 2),
(7, 'ça, c\'est un grand rôle!', '2022-03-13 13:48:09', 11, 11),
(8, 'Grande actresse, et belle avec ça !', '2022-03-13 13:48:55', 9, 11),
(10, 'tjrstyksyrllxx', '2022-03-14 15:41:23', 16, 2);

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

CREATE TABLE `posts` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(50) NOT NULL,
  `image` varchar(250) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  `content` text NOT NULL,
  `user_id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `posts`
--

INSERT INTO `posts` (`id`, `title`, `image`, `created_date`, `updated_date`, `content`, `user_id`) VALUES
(9, 'The Duchess', 'http://localhost:3000/images/duchess1647178494096.jpg', '2022-03-13 13:34:54', '2022-03-13 13:34:54', 'Un film en costumes...', 12),
(10, 'Training Day', 'http://localhost:3000/images/training-day1647178647002.jpg', '2022-03-13 13:37:27', '2022-03-13 13:37:27', 'J\'au eu un oscar pour ce rôle !', 11),
(11, 'Taxi Driver', 'http://localhost:3000/images/taxi-driver1647178856179.jpg', '2022-03-13 13:40:56', '2022-03-13 13:40:56', 'Are you talking to me ? Are you talking to me ?', 2),
(16, 'Un autre post', 'http://localhost:3000/images/giphy1647272412507.gif', '2022-03-14 15:40:12', '2022-03-14 15:40:12', 'blabla', 2);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `image` varchar(250) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `prenom`, `image`, `email`, `password`, `role`) VALUES
(2, 'TOTO', 'Robert', 'http://localhost:3000/images/Robert-De-Niro1647176576334.jpg', 'deniro@deniro.de', '$2b$10$b7Mj3X.cIhksj.0wrcYpguiF8SHtaQekZo4XgTGazQkcf97jRqXo.', 0),
(5, 'ADMIN', 'Admin', 'http://localhost:3000/images/photo-profile-openclass1647195325304.jpg', 'admin@admin.ad', '$2b$10$ML7NmoETv7dPu3UyBfg4o.gO8qUzOcFrBfXen9iZoci5SN.h/l9Du', 1),
(11, 'Washington', 'Denzel', 'http://localhost:3000/images/denzel-washington1647178987744.jpg', 'washington@washington.wa', '$2b$10$74sRxRNks6USzyAhGHNzauqNmk2y7lHQCblZPbsiaSJg1JcNZ2R2q', 0),
(12, 'Knightley', 'Keira', 'http://localhost:3000/images/Keira-Knightley1647178937418.jpg', 'knightley@knightley.kn', '$2b$10$0hjYFKCN4cIZZW5Q3AmdjeGCf5xdh6bAqeXUb3RQkFKJ.8U.33l3K', 0),
(16, 'TATA', 'Tata', 'http://localhost:3000/images/etudiant 5 euros1647264150570.jpg', 'tata@tata.ta', '$2b$10$QjODS49tBetz4iKsUDDAfeKNhBxParzBF2zC1lW7Y9we53xg5MZU6', 0);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_post_id` (`post_id`),
  ADD KEY `fk_user_id_comments` (`user_id`);

--
-- Index pour la table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_id_posts` (`user_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_id_comments` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_user_id_posts` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
