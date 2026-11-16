CREATE TABLE IF NOT EXISTS `users` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `first_name` VARCHAR(256) NOT NULL,
    `last_name` VARCHAR(256) NOT NULL,
    `username` VARCHAR(24) NOT NULL UNIQUE,
    `password` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `schools_unis` (
    `id` MEDIUMINT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(128) NOT NULL,
    `type` ENUM('Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University', 'Technical School', 'Research Centre', 'Institute', 'Academy', 'Other')  NOT NULL,
    `location` VARCHAR(128) NOT NULL,
    `year` YEAR NOT NULL DEFAULT CURRENT_YEAR,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `companies` (
    `id` MEDIUMINT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(128) NOT NULL,
    `industry` SET('Education', 'Technology', 'Finance', 'Transport', 'Sports', 'Consultory', 'Law', 'Biotechnology', 'Health', 'Animals', 'Nature', 'Other') NOT NULL,
    `location` VARCHAR(128) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `connections_user` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT,
    `user1_id` INT UNSIGNED NOT NULL CHECK(`user1_id` < `user2_id`),
    `user2_id` INT UNSIGNED NOT NULL,
    UNIQUE(`user1_id`, `user2_id`),
    PRIMARY KEY (`id`),
    FOREIGN KEY(`user1_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`user2_id`) REFERENCES `users`(`id`)
);

CREATE TABLE IF NOT EXISTS `connections_school` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT,
    `user_id` INT UNSIGNED NOT NULL,
    `school_id` MEDIUMINT UNSIGNED, NOT NULL,
    `start_date` DATE NOT NULL DEFAULT CURRENT_YEAR,
    `end_date` DATE,
    `degree` ENUM('HS', 'BA', 'MA', 'PhD', 'Diploma', 'Course', 'Other') NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`school_id`) REFERENCES `schools_unis`(`id`)
);

CREATE TABLE IF NOT EXISTS `connections_company` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT,
    `user_id` INT UNSIGNED NOT NULL,
    `company_id` MEDIUMINT UNSIGNED, NOT NULL,
    `start_date` NUMERIC NOT NULL DEFAULT CURRENT_YEAR,
    `end_date` NUMERIC,
    `title` VARCHAR(128) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`company_id`) REFERENCES `companies`(`id`)
)
