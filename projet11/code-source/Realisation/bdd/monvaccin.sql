-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 26 juil. 2021 à 03:20
-- Version du serveur :  10.4.19-MariaDB
-- Version de PHP : 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `monvaccin`
--

-- --------------------------------------------------------

--
-- Structure de la table `enfant`
--

CREATE TABLE `enfant` (
  `id_enfant` int(11) NOT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `nom_enfant` varchar(50) DEFAULT NULL,
  `date_naissance` varchar(10) DEFAULT NULL,
  `poids_naissance` varchar(10) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `enfant`
--

INSERT INTO `enfant` (`id_enfant`, `id_parent`, `nom_enfant`, `date_naissance`, `poids_naissance`, `genre`) VALUES
(38, NULL, 'Soujoud', '2020-01-13', '2.8 kg', 'Fille'),
(40, NULL, 'jad', '2021-02-23', '3', 'Garçon');

--
-- Déclencheurs `enfant`
--
DELIMITER $$
CREATE TRIGGER `after_insert_enfant` AFTER INSERT ON `enfant` FOR EACH ROW INSERT INTO vaccination ( `id_enfant`,`id_vaccin`)
SELECT new.id_enfant, id_vaccin from enfant, vaccin
GROUP BY id_vaccin
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `parent`
--

CREATE TABLE `parent` (
  `id_parent` int(11) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(45) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `photo_profile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `parent`
--

INSERT INTO `parent` (`id_parent`, `firstname`, `lastname`, `gender`, `email`, `password`, `phone`, `photo_profile`) VALUES
(1, 'Dahri', 'Fatima', 'femme', 'dahri.fatima.dev@gmail.com', '123456', '0643905996', '');

-- --------------------------------------------------------

--
-- Structure de la table `vaccin`
--

CREATE TABLE `vaccin` (
  `id_vaccin` int(11) NOT NULL,
  `nom_vaccin` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `vaccin`
--

INSERT INTO `vaccin` (`id_vaccin`, `nom_vaccin`, `description`) VALUES
(1, 'BCG  + VPO ( zéro ) + HB1', 'A la naissance'),
(2, 'DTC1  + VPO1+HB2', '6 semaines'),
(3, 'DTC2  + VPO2', '10 semaines'),
(4, 'DTC3  + VPO3', '14 semaines'),
(5, 'VAR  + HB3', '9 mois'),
(6, 'Premier rappel DTCP', '18 mois'),
(7, 'RR', '6 ans ( Entrée scolaire )');

-- --------------------------------------------------------

--
-- Structure de la table `vaccination`
--

CREATE TABLE `vaccination` (
  `id_vaccination` int(11) NOT NULL,
  `id_vaccin` int(11) DEFAULT NULL,
  `id_enfant` int(11) DEFAULT NULL,
  `date_vaccination` varchar(11) DEFAULT NULL,
  `poids` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `vaccination`
--

INSERT INTO `vaccination` (`id_vaccination`, `id_vaccin`, `id_enfant`, `date_vaccination`, `poids`) VALUES
(637, 1, 38, '', ''),
(638, 2, 38, '2021-06-29', '5'),
(639, 3, 38, NULL, NULL),
(640, 4, 38, NULL, NULL),
(641, 5, 38, NULL, NULL),
(642, 6, 38, NULL, NULL),
(643, 7, 38, NULL, NULL),
(651, 1, 40, NULL, NULL),
(652, 2, 40, NULL, NULL),
(653, 3, 40, '2021-07-08', '5'),
(654, 4, 40, NULL, NULL),
(655, 5, 40, NULL, NULL),
(656, 6, 40, NULL, NULL),
(657, 7, 40, NULL, NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `enfant`
--
ALTER TABLE `enfant`
  ADD PRIMARY KEY (`id_enfant`),
  ADD KEY `FK_id_parent` (`id_parent`);

--
-- Index pour la table `parent`
--
ALTER TABLE `parent`
  ADD PRIMARY KEY (`id_parent`),
  ADD UNIQUE KEY `id_parent_UNIQUE` (`id_parent`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `telephone_UNIQUE` (`phone`);

--
-- Index pour la table `vaccin`
--
ALTER TABLE `vaccin`
  ADD PRIMARY KEY (`id_vaccin`);

--
-- Index pour la table `vaccination`
--
ALTER TABLE `vaccination`
  ADD PRIMARY KEY (`id_vaccination`),
  ADD KEY `FK_id_enfant` (`id_enfant`),
  ADD KEY `FK_id_vaccin` (`id_vaccin`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `enfant`
--
ALTER TABLE `enfant`
  MODIFY `id_enfant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT pour la table `parent`
--
ALTER TABLE `parent`
  MODIFY `id_parent` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `vaccin`
--
ALTER TABLE `vaccin`
  MODIFY `id_vaccin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `vaccination`
--
ALTER TABLE `vaccination`
  MODIFY `id_vaccination` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=658;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `enfant`
--
ALTER TABLE `enfant`
  ADD CONSTRAINT `FK_id_parent` FOREIGN KEY (`id_parent`) REFERENCES `parent` (`id_parent`);

--
-- Contraintes pour la table `vaccination`
--
ALTER TABLE `vaccination`
  ADD CONSTRAINT `FK_id_enfant` FOREIGN KEY (`id_enfant`) REFERENCES `enfant` (`id_enfant`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_id_vaccin` FOREIGN KEY (`id_vaccin`) REFERENCES `vaccin` (`id_vaccin`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
