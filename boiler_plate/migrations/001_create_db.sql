CREATE SCHEMA `boiler_plate` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE USER 'boiler_plate'@'localhost' IDENTIFIED BY 'pP2017pP30174fad';

GRANT DELETE,INSERT,SELECT,UPDATE ON boiler_plate.* TO 'boiler_plate'@'localhost';


CREATE SCHEMA `minion_jobs` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON minion_jobs.* TO 'boiler_plate'@'localhost';

-- DUMMY DATA

-- CREATE TABLE `boiler_plate`.`mp_users` (
--   `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
--   `email` VARCHAR(100) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE INDEX `email_UNIQUE` (`email` ASC));


-- INSERT INTO `boiler_plate`.`mp_users` (`email`) VALUES ('');
