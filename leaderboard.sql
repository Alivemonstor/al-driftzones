CREATE TABLE IF NOT EXISTS `drift_leaderboard`(
    `id` INT(255) NOT NULL AUTO_INCREMENT,
    `citizenid` VARCHAR(50) DEFAULT NULL,
    `driftpoints` INT(255) DEFAULT 0,
    KEY(`id`),
    PRIMARY KEY `citizenid`(`citizenid`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;