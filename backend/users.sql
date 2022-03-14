-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 14 mars 2022 à 15:48
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
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
