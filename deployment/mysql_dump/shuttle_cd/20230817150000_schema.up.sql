CREATE TABLE IF NOT EXISTS `embedded_dashboards` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `allow_domain_list` text,
  `uuid` binary(16) DEFAULT NULL,
  `dashboard_id` int NOT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  KEY `dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;


CREATE TABLE IF NOT EXISTS `key_value` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resource` varchar(32) NOT NULL,
  `value` longblob NOT NULL,
  `uuid` binary(16) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `expires_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_key_value_uuid` (`uuid`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `ix_key_value_expires_on` (`expires_on`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;
