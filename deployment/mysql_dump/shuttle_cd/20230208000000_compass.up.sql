CREATE TABLE `ab_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `ab_permission_view` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission_id` int DEFAULT NULL,
  `view_menu_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_id` (`permission_id`,`view_menu_id`),
  KEY `view_menu_id` (`view_menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `ab_permission_view_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permission_view_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_view_id` (`permission_view_id`,`role_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `ab_register_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `username` varchar(64) NOT NULL,
  `password` varchar(256) DEFAULT NULL,
  `email` varchar(64) NOT NULL,
  `registration_date` datetime DEFAULT NULL,
  `registration_hash` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `ab_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `ab_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `username` varchar(64) NOT NULL,
  `password` varchar(256) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `email` varchar(64) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `login_count` int DEFAULT NULL,
  `fail_login_count` int DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `ab_user_chk_1` CHECK ((`active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;


CREATE TABLE `ab_user_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`role_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `ab_view_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `access_request` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `datasource_type` varchar(200) DEFAULT NULL,
  `datasource_id` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `alert_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scheduled_dttm` datetime DEFAULT NULL,
  `dttm_start` datetime DEFAULT NULL,
  `dttm_end` datetime DEFAULT NULL,
  `alert_id` int DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `alert_owner` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `alert_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alert_id` (`alert_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `alerts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(150) NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `crontab` varchar(50) NOT NULL,
  `alert_type` varchar(50) DEFAULT NULL,
  `log_retention` int NOT NULL,
  `grace_period` int NOT NULL,
  `recipients` text,
  `slice_id` int DEFAULT NULL,
  `dashboard_id` int DEFAULT NULL,
  `last_eval_dttm` datetime DEFAULT NULL,
  `last_state` varchar(10) DEFAULT NULL,
  `slack_channel` text,
  `changed_by_fk` int DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `validator_config` text,
  `database_id` int NOT NULL,
  `sql` text NOT NULL,
  `validator_type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_id` (`dashboard_id`),
  KEY `slice_id` (`slice_id`),
  KEY `ix_alerts_active` (`active`),
  KEY `alerts_ibfk_3` (`changed_by_fk`),
  KEY `alerts_ibfk_4` (`created_by_fk`),
  KEY `database_id` (`database_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `annotation` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `start_dttm` datetime DEFAULT NULL,
  `end_dttm` datetime DEFAULT NULL,
  `layer_id` int DEFAULT NULL,
  `short_descr` varchar(500) DEFAULT NULL,
  `long_descr` text,
  `changed_by_fk` int DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `json_metadata` text,
  PRIMARY KEY (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `ti_dag_state` (`layer_id`,`start_dttm`,`end_dttm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `annotation_layer` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `descr` text,
  `changed_by_fk` int DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `cache_keys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cache_key` varchar(256) NOT NULL,
  `cache_timeout` int DEFAULT NULL,
  `datasource_uid` varchar(64) NOT NULL,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_cache_keys_datasource_uid` (`datasource_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `clusters` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `cluster_name` varchar(250) NOT NULL,
  `broker_host` varchar(255) DEFAULT NULL,
  `broker_port` int DEFAULT NULL,
  `broker_endpoint` varchar(255) DEFAULT NULL,
  `metadata_last_refreshed` datetime DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `cache_timeout` int DEFAULT NULL,
  `verbose_name` varchar(250) DEFAULT NULL,
  `broker_pass` blob,
  `broker_user` varchar(255) DEFAULT NULL,
  `uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cluster_name` (`cluster_name`),
  UNIQUE KEY `verbose_name` (`verbose_name`),
  UNIQUE KEY `uq_clusters_uuid` (`uuid`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `columns` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `column_name` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `groupby` tinyint(1) DEFAULT NULL,
  `filterable` tinyint(1) DEFAULT NULL,
  `description` text,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `dimension_spec_json` text,
  `verbose_name` varchar(1024) DEFAULT NULL,
  `datasource_id` int DEFAULT NULL,
  `uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_columns_column_name` (`column_name`,`datasource_id`),
  UNIQUE KEY `uq_columns_uuid` (`uuid`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `fk_columns_datasource_id_datasources` (`datasource_id`),
  CONSTRAINT `columns_chk_1` CHECK ((`is_active` in (0,1))),
  CONSTRAINT `columns_chk_2` CHECK ((`groupby` in (0,1))),
  CONSTRAINT `columns_chk_7` CHECK ((`filterable` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `css_templates` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `template_name` varchar(250) DEFAULT NULL,
  `css` text,
  `changed_by_fk` int DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `dashboard_email_schedules` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) DEFAULT NULL,
  `crontab` varchar(50) DEFAULT NULL,
  `recipients` text,
  `deliver_as_group` tinyint(1) DEFAULT NULL,
  `delivery_type` enum('attachment','inline') DEFAULT NULL,
  `dashboard_id` int DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `slack_channel` text,
  `uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_dashboard_email_schedules_uuid` (`uuid`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `dashboard_id` (`dashboard_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_dashboard_email_schedules_active` (`active`),
  CONSTRAINT `dashboard_email_schedules_chk_1` CHECK ((`active` in (0,1))),
  CONSTRAINT `dashboard_email_schedules_chk_2` CHECK ((`deliver_as_group` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `dashboard_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `dashboard_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_id` (`dashboard_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `dashboard_slices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dashboard_id` int DEFAULT NULL,
  `slice_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_dashboard_slice` (`dashboard_id`,`slice_id`),
  KEY `slice_id` (`slice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `dashboard_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `dashboard_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_id` (`dashboard_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `dashboards` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `dashboard_title` varchar(500) DEFAULT NULL,
  `position_json` mediumtext,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `css` text,
  `description` text,
  `slug` varchar(255) DEFAULT NULL,
  `json_metadata` text,
  `published` tinyint(1) DEFAULT NULL,
  `uuid` binary(16) DEFAULT NULL,
  `certified_by` text,
  `certification_details` text,
  `is_managed_externally` tinyint(1) NOT NULL DEFAULT '0',
  `external_url` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_slug` (`slug`),
  UNIQUE KEY `uq_dashboards_uuid` (`uuid`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `dashboards_chk_1` CHECK ((`published` in (0,1))),
  CONSTRAINT `dashboards_chk_2` CHECK ((`is_managed_externally` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `datasources` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `datasource_name` varchar(255) NOT NULL,
  `is_featured` tinyint(1) DEFAULT NULL,
  `is_hidden` tinyint(1) DEFAULT NULL,
  `description` text,
  `default_endpoint` text,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `offset` int DEFAULT NULL,
  `cache_timeout` int DEFAULT NULL,
  `perm` varchar(1000) DEFAULT NULL,
  `filter_select_enabled` tinyint(1) DEFAULT NULL,
  `params` varchar(1000) DEFAULT NULL,
  `fetch_values_from` varchar(100) DEFAULT NULL,
  `schema_perm` varchar(1000) DEFAULT NULL,
  `cluster_id` int NOT NULL,
  `uuid` binary(16) DEFAULT NULL,
  `is_managed_externally` tinyint(1) NOT NULL DEFAULT '0',
  `external_url` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_datasources_cluster_id` (`cluster_id`,`datasource_name`),
  UNIQUE KEY `uq_datasources_uuid` (`uuid`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `datasources_chk_1` CHECK ((`is_featured` in (0,1))),
  CONSTRAINT `datasources_chk_2` CHECK ((`is_hidden` in (0,1))),
  CONSTRAINT `datasources_chk_3` CHECK ((`filter_select_enabled` in (0,1))),
  CONSTRAINT `datasources_chk_4` CHECK ((`is_managed_externally` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `dbs` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `database_name` varchar(250) NOT NULL,
  `sqlalchemy_uri` varchar(1024) NOT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `password` blob,
  `cache_timeout` int DEFAULT NULL,
  `extra` text,
  `select_as_create_table_as` tinyint(1) DEFAULT NULL,
  `allow_ctas` tinyint(1) DEFAULT NULL,
  `expose_in_sqllab` tinyint(1) DEFAULT NULL,
  `force_ctas_schema` varchar(250) DEFAULT NULL,
  `allow_run_async` tinyint(1) DEFAULT NULL,
  `allow_dml` tinyint(1) DEFAULT NULL,
  `verbose_name` varchar(250) DEFAULT NULL,
  `impersonate_user` tinyint(1) DEFAULT NULL,
  `allow_multi_schema_metadata_fetch` tinyint(1) DEFAULT NULL,
  `allow_file_upload` tinyint(1) DEFAULT NULL,
  `encrypted_extra` blob,
  `server_cert` blob,
  `allow_cvas` tinyint(1) DEFAULT NULL,
  `uuid` binary(16) DEFAULT NULL,
  `configuration_method` varchar(255) DEFAULT 'sqlalchemy_form',
  `is_managed_externally` tinyint(1) NOT NULL DEFAULT '0',
  `external_url` text,
  `allow_csv_upload` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `database_name` (`database_name`),
  UNIQUE KEY `verbose_name` (`verbose_name`),
  UNIQUE KEY `uq_dbs_uuid` (`uuid`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `dbs_chk_1` CHECK ((`select_as_create_table_as` in (0,1))),
  CONSTRAINT `dbs_chk_10` CHECK ((`allow_cvas` in (0,1))),
  CONSTRAINT `dbs_chk_11` CHECK ((`is_managed_externally` in (0,1))),
  CONSTRAINT `dbs_chk_2` CHECK ((`allow_ctas` in (0,1))),
  CONSTRAINT `dbs_chk_3` CHECK ((`expose_in_sqllab` in (0,1))),
  CONSTRAINT `dbs_chk_4` CHECK ((`allow_run_async` in (0,1))),
  CONSTRAINT `dbs_chk_6` CHECK ((`allow_dml` in (0,1))),
  CONSTRAINT `dbs_chk_7` CHECK ((`impersonate_user` in (0,1))),
  CONSTRAINT `dbs_chk_8` CHECK ((`allow_multi_schema_metadata_fetch` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `druiddatasource_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `datasource_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datasource_id` (`datasource_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `dynamic_plugin` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `key` varchar(50) NOT NULL,
  `bundle_url` varchar(1000) NOT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  UNIQUE KEY `name` (`name`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `embedded_dashboards` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `allow_domain_list` text,
  `uuid` binary(16) DEFAULT NULL,
  `dashboard_id` int NOT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  KEY `dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `favstar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `class_name` varchar(50) DEFAULT NULL,
  `obj_id` int DEFAULT NULL,
  `dttm` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `filter_sets` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `description` text,
  `json_metadata` text NOT NULL,
  `owner_id` int NOT NULL,
  `owner_type` varchar(255) NOT NULL,
  `dashboard_id` int NOT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `key_value` (
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

CREATE TABLE `keyvalue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action` varchar(512) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `json` text,
  `dttm` datetime DEFAULT NULL,
  `dashboard_id` int DEFAULT NULL,
  `slice_id` int DEFAULT NULL,
  `duration_ms` int DEFAULT NULL,
  `referrer` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `metrics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `metric_name` varchar(255) NOT NULL,
  `verbose_name` varchar(1024) DEFAULT NULL,
  `metric_type` varchar(32) DEFAULT NULL,
  `json` text NOT NULL,
  `description` text,
  `changed_by_fk` int DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `d3format` varchar(128) DEFAULT NULL,
  `warning_text` text,
  `datasource_id` int DEFAULT NULL,
  `uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_metrics_metric_name` (`metric_name`,`datasource_id`),
  UNIQUE KEY `uq_metrics_uuid` (`uuid`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `fk_metrics_datasource_id_datasources` (`datasource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `query` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` varchar(11) NOT NULL,
  `database_id` int NOT NULL,
  `tmp_table_name` varchar(256) DEFAULT NULL,
  `tab_name` varchar(256) DEFAULT NULL,
  `sql_editor_id` varchar(256) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `schema` varchar(256) DEFAULT NULL,
  `sql` longtext,
  `select_sql` longtext,
  `executed_sql` longtext,
  `limit` int DEFAULT NULL,
  `select_as_cta` tinyint(1) DEFAULT NULL,
  `select_as_cta_used` tinyint(1) DEFAULT NULL,
  `progress` int DEFAULT NULL,
  `rows` int DEFAULT NULL,
  `error_message` text,
  `start_time` decimal(20,6) DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `end_time` decimal(20,6) DEFAULT NULL,
  `results_key` varchar(64) DEFAULT NULL,
  `start_running_time` decimal(20,6) DEFAULT NULL,
  `end_result_backend_time` decimal(20,6) DEFAULT NULL,
  `tracking_url` text,
  `extra_json` text,
  `tmp_schema_name` varchar(256) DEFAULT NULL,
  `ctas_method` varchar(16) DEFAULT NULL,
  `limiting_factor` varchar(255) DEFAULT 'UNKNOWN',
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `database_id` (`database_id`),
  KEY `ti_user_id_changed_on` (`user_id`,`changed_on`),
  KEY `ix_query_results_key` (`results_key`),
  CONSTRAINT `query_chk_2` CHECK ((`select_as_cta` in (0,1))),
  CONSTRAINT `query_chk_3` CHECK ((`select_as_cta_used` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `report_execution_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scheduled_dttm` datetime NOT NULL,
  `start_dttm` datetime DEFAULT NULL,
  `end_dttm` datetime DEFAULT NULL,
  `value` float DEFAULT NULL,
  `value_row_json` text,
  `state` varchar(50) NOT NULL,
  `error_message` text,
  `report_schedule_id` int NOT NULL,
  `uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_schedule_id` (`report_schedule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `report_recipient` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `recipient_config_json` text,
  `report_schedule_id` int NOT NULL,
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_schedule_id` (`report_schedule_id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `report_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text,
  `context_markdown` text,
  `active` tinyint(1) DEFAULT NULL,
  `crontab` varchar(1000) NOT NULL,
  `sql` text,
  `chart_id` int DEFAULT NULL,
  `dashboard_id` int DEFAULT NULL,
  `database_id` int DEFAULT NULL,
  `last_eval_dttm` datetime DEFAULT NULL,
  `last_state` varchar(50) DEFAULT NULL,
  `last_value` float DEFAULT NULL,
  `last_value_row_json` text,
  `validator_type` varchar(100) DEFAULT NULL,
  `validator_config_json` text,
  `log_retention` int DEFAULT NULL,
  `grace_period` int DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `working_timeout` int DEFAULT NULL,
  `report_format` varchar(50) DEFAULT 'PNG',
  `creation_method` varchar(255) DEFAULT 'alerts_reports',
  `timezone` varchar(100) NOT NULL DEFAULT 'UTC',
  `force_screenshot` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_report_schedule_name_type` (`name`,`type`),
  KEY `chart_id` (`chart_id`),
  KEY `dashboard_id` (`dashboard_id`),
  KEY `database_id` (`database_id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `ix_report_schedule_active` (`active`),
  KEY `ix_creation_method` (`creation_method`),
  CONSTRAINT `report_schedule_chk_1` CHECK ((`active` in (0,1))),
  CONSTRAINT `report_schedule_chk_2` CHECK ((`force_screenshot` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `report_schedule_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `report_schedule_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `report_schedule_id` (`report_schedule_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `rls_filter_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `rls_filter_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rls_filter_id` (`rls_filter_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `rls_filter_tables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_id` int DEFAULT NULL,
  `rls_filter_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rls_filter_id` (`rls_filter_id`),
  KEY `table_id` (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `row_level_security_filters` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `clause` text NOT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `filter_type` varchar(255) DEFAULT NULL,
  `group_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `ix_row_level_security_filters_filter_type` (`filter_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `saved_query` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `db_id` int DEFAULT NULL,
  `label` varchar(256) DEFAULT NULL,
  `schema` varchar(128) DEFAULT NULL,
  `sql` text,
  `description` text,
  `changed_by_fk` int DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `extra_json` text,
  `last_run` datetime DEFAULT NULL,
  `rows` int DEFAULT NULL,
  `uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_saved_query_uuid` (`uuid`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `user_id` (`user_id`),
  KEY `db_id` (`db_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `slice_email_schedules` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) DEFAULT NULL,
  `crontab` varchar(50) DEFAULT NULL,
  `recipients` text,
  `deliver_as_group` tinyint(1) DEFAULT NULL,
  `delivery_type` enum('attachment','inline') DEFAULT NULL,
  `slice_id` int DEFAULT NULL,
  `email_format` enum('visualization','data') DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `slack_channel` text,
  `uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_slice_email_schedules_uuid` (`uuid`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `slice_id` (`slice_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_slice_email_schedules_active` (`active`),
  CONSTRAINT `slice_email_schedules_chk_1` CHECK ((`active` in (0,1))),
  CONSTRAINT `slice_email_schedules_chk_2` CHECK ((`deliver_as_group` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `slice_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `slice_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `slice_id` (`slice_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `slices` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `slice_name` varchar(250) DEFAULT NULL,
  `druid_datasource_id` int DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `datasource_type` varchar(200) DEFAULT NULL,
  `datasource_name` varchar(2000) DEFAULT NULL,
  `viz_type` varchar(250) DEFAULT NULL,
  `params` text,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `description` text,
  `cache_timeout` int DEFAULT NULL,
  `perm` varchar(2000) DEFAULT NULL,
  `datasource_id` int DEFAULT NULL,
  `schema_perm` varchar(1000) DEFAULT NULL,
  `uuid` binary(16) DEFAULT NULL,
  `query_context` text,
  `last_saved_at` datetime DEFAULT NULL,
  `last_saved_by_fk` int DEFAULT NULL,
  `certified_by` text,
  `certification_details` text,
  `is_managed_externally` tinyint(1) NOT NULL DEFAULT '0',
  `external_url` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_slices_uuid` (`uuid`),
  KEY `druid_datasource_id` (`druid_datasource_id`),
  KEY `table_id` (`table_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `slices_last_saved_by_fk` (`last_saved_by_fk`),
  CONSTRAINT `slices_chk_1` CHECK ((`is_managed_externally` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `sql_metrics` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `metric_name` varchar(255) NOT NULL,
  `verbose_name` varchar(1024) DEFAULT NULL,
  `metric_type` varchar(32) DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `expression` text NOT NULL,
  `description` text,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `d3format` varchar(128) DEFAULT NULL,
  `warning_text` text,
  `extra` text,
  `uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_sql_metrics_metric_name` (`metric_name`,`table_id`),
  UNIQUE KEY `uq_sql_metrics_uuid` (`uuid`),
  KEY `table_id` (`table_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `sql_observations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dttm` datetime DEFAULT NULL,
  `alert_id` int DEFAULT NULL,
  `value` float DEFAULT NULL,
  `error_msg` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `sqlatable_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `table_id` (`table_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `tab_state` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `extra_json` text,
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `label` varchar(256) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `database_id` int DEFAULT NULL,
  `schema` varchar(256) DEFAULT NULL,
  `sql` text,
  `query_limit` int DEFAULT NULL,
  `latest_query_id` varchar(11) DEFAULT NULL,
  `autorun` tinyint(1) NOT NULL,
  `template_params` text,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `hide_left_bar` tinyint(1) NOT NULL DEFAULT '0',
  `saved_query_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_tab_state_id` (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `database_id` (`database_id`),
  KEY `latest_query_id` (`latest_query_id`),
  KEY `user_id` (`user_id`),
  KEY `saved_query_id` (`saved_query_id`),
  CONSTRAINT `tab_state_chk_1` CHECK ((`active` in (0,1))),
  CONSTRAINT `tab_state_chk_2` CHECK ((`autorun` in (0,1))),
  CONSTRAINT `tab_state_chk_3` CHECK ((`hide_left_bar` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `table_columns` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `table_id` int DEFAULT NULL,
  `column_name` varchar(255) NOT NULL,
  `is_dttm` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `type` text,
  `groupby` tinyint(1) DEFAULT NULL,
  `filterable` tinyint(1) DEFAULT NULL,
  `description` text,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `expression` text,
  `verbose_name` varchar(1024) DEFAULT NULL,
  `python_date_format` varchar(255) DEFAULT NULL,
  `uuid` binary(16) DEFAULT NULL,
  `extra` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_table_columns_column_name` (`column_name`,`table_id`),
  UNIQUE KEY `uq_table_columns_uuid` (`uuid`),
  KEY `table_id` (`table_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `table_columns_chk_1` CHECK ((`is_dttm` in (0,1))),
  CONSTRAINT `table_columns_chk_2` CHECK ((`is_active` in (0,1))),
  CONSTRAINT `table_columns_chk_3` CHECK ((`groupby` in (0,1))),
  CONSTRAINT `table_columns_chk_8` CHECK ((`filterable` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `table_schema` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `extra_json` text,
  `id` int NOT NULL AUTO_INCREMENT,
  `tab_state_id` int DEFAULT NULL,
  `database_id` int NOT NULL,
  `schema` varchar(256) DEFAULT NULL,
  `table` varchar(256) DEFAULT NULL,
  `description` longtext,
  `expanded` tinyint(1) DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_table_schema_id` (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `database_id` (`database_id`),
  KEY `tab_state_id` (`tab_state_id`),
  CONSTRAINT `table_schema_chk_1` CHECK ((`expanded` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `tables` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(250) NOT NULL,
  `main_dttm_col` varchar(250) DEFAULT NULL,
  `default_endpoint` text,
  `database_id` int NOT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  `offset` int DEFAULT NULL,
  `description` text,
  `is_featured` tinyint(1) DEFAULT NULL,
  `cache_timeout` int DEFAULT NULL,
  `schema` varchar(255) DEFAULT NULL,
  `sql` text,
  `params` text,
  `perm` varchar(1000) DEFAULT NULL,
  `filter_select_enabled` tinyint(1) DEFAULT NULL,
  `fetch_values_predicate` text,
  `is_sqllab_view` tinyint(1) DEFAULT '0',
  `template_params` text,
  `schema_perm` varchar(1000) DEFAULT NULL,
  `extra` text,
  `uuid` binary(16) DEFAULT NULL,
  `is_managed_externally` tinyint(1) NOT NULL DEFAULT '0',
  `external_url` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tables_uuid` (`uuid`),
  KEY `database_id` (`database_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `tables_chk_1` CHECK ((`is_featured` in (0,1))),
  CONSTRAINT `tables_chk_2` CHECK ((`filter_select_enabled` in (0,1))),
  CONSTRAINT `tables_chk_3` CHECK ((`is_sqllab_view` in (0,1))),
  CONSTRAINT `tables_chk_4` CHECK ((`is_managed_externally` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ;

CREATE TABLE `tag` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `type` enum('custom','type','owner','favorited_by') DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tagged_object` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `tag_id` int DEFAULT NULL,
  `object_id` int DEFAULT NULL,
  `object_type` enum('query','chart','dashboard') DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_id` (`tag_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `ix_tagged_object_object_id` (`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `url` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_attribute` (
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `welcome_dashboard_id` int DEFAULT NULL,
  `created_by_fk` int DEFAULT NULL,
  `changed_by_fk` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changed_by_fk` (`changed_by_fk`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `user_id` (`user_id`),
  KEY `welcome_dashboard_id` (`welcome_dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `ab_permission` VALUES (91,'all_database_access'),(90,'all_datasource_access'),(92,'all_query_access'),(82,'can_activate'),(8,'can_add'),(66,'can_add_slices'),(73,'can_annotation_json'),(76,'can_approve'),(29,'can_available_domains'),(33,'can_copy_dash'),(77,'can_created_dashboards'),(48,'can_created_slices'),(72,'can_csrf_token'),(58,'can_csv'),(62,'can_dashboard'),(104,'can_dashboard_permalink'),(52,'can_datasources'),(7,'can_delete'),(102,'can_delete_embedded'),(81,'can_delete_query'),(17,'can_download'),(5,'can_edit'),(32,'can_estimate_query_cost'),(79,'can_expanded'),(59,'can_explore'),(34,'can_explore_json'),(99,'can_export'),(23,'can_external_metadata'),(24,'can_external_metadata_by_name'),(49,'can_extra_table_metadata'),(41,'can_fave_dashboards'),(46,'can_fave_dashboards_by_username'),(53,'can_fave_slices'),(36,'can_favstar'),(37,'can_fetch_datasource_metadata'),(42,'can_filter'),(15,'can_get'),(100,'can_get_embedded'),(25,'can_get_value'),(105,'can_grant_guest_token'),(103,'can_import_'),(35,'can_import_dashboards'),(16,'can_invalidate'),(9,'can_list'),(65,'can_log'),(80,'can_migrate_query'),(28,'can_my_queries'),(63,'can_override_role_permissions'),(78,'can_post'),(61,'can_profile'),(38,'can_publish'),(83,'can_put'),(56,'can_queries'),(20,'can_query'),(19,'can_query_form_data'),(1,'can_read'),(57,'can_recent_activity'),(88,'can_refresh_datasources'),(69,'can_request_access'),(30,'can_results'),(22,'can_save'),(75,'can_save_dash'),(87,'can_scan_new_datasources'),(50,'can_schemas'),(64,'can_schemas_access_for_csv_upload'),(98,'can_schemas_access_for_file_upload'),(54,'can_search_queries'),(39,'can_select_star'),(101,'can_set_embedded'),(94,'can_share_chart'),(93,'can_share_dashboard'),(27,'can_shortner'),(6,'can_show'),(67,'can_slice'),(55,'can_slice_json'),(74,'can_sql_json'),(60,'can_sqllab'),(68,'can_sqllab_history'),(51,'can_sqllab_table_viz'),(70,'can_sqllab_viz'),(43,'can_stop_query'),(26,'can_store'),(84,'can_suggestions'),(71,'can_sync_druid_source'),(45,'can_tables'),(85,'can_tagged_objects'),(40,'can_testconn'),(3,'can_this_form_get'),(4,'can_this_form_post'),(21,'can_time_range'),(31,'can_user_slices'),(10,'can_userinfo'),(47,'can_validate_sql_json'),(44,'can_warm_up_cache'),(2,'can_write'),(14,'copyrole'),(95,'database_access'),(97,'datasource_access'),(89,'menu_access'),(18,'muldelete'),(11,'resetmypassword'),(12,'resetpasswords'),(96,'schema_access'),(13,'userinfoedit'),(86,'yaml_export');

INSERT INTO `ab_permission_view` VALUES (1,1,1),(3,1,2),(5,1,3),(7,1,4),(9,1,5),(11,1,6),(13,1,7),(15,1,8),(17,1,9),(19,1,10),(142,1,41),(271,1,119),(273,1,120),(281,1,121),(283,1,122),(2,2,1),(4,2,2),(6,2,3),(8,2,4),(10,2,5),(12,2,6),(14,2,7),(16,2,8),(18,2,9),(55,2,28),(272,2,119),(274,2,120),(282,2,121),(284,2,122),(20,3,16),(22,3,17),(24,3,18),(66,3,31),(68,3,32),(267,3,116),(21,4,16),(23,4,17),(25,4,18),(67,4,31),(69,4,32),(266,4,116),(26,5,20),(35,5,21),(49,5,28),(56,5,29),(143,5,42),(149,5,43),(155,5,44),(164,5,47),(170,5,48),(177,5,49),(187,5,50),(191,5,51),(232,5,90),(265,5,115),(27,6,20),(36,6,21),(42,6,22),(45,6,24),(50,6,28),(57,6,29),(144,6,42),(150,6,43),(156,6,44),(161,6,45),(163,6,46),(165,6,47),(171,6,48),(178,6,49),(236,6,90),(28,7,20),(37,7,21),(43,7,22),(51,7,28),(58,7,29),(128,7,38),(133,7,39),(139,7,40),(145,7,42),(151,7,43),(157,7,44),(166,7,47),(172,7,48),(179,7,49),(185,7,50),(189,7,51),(231,7,90),(264,7,115),(29,8,20),(38,8,21),(52,8,28),(59,8,29),(146,8,42),(152,8,43),(158,8,44),(167,8,47),(173,8,48),(180,8,49),(186,8,50),(190,8,51),(235,8,90),(263,8,115),(30,9,20),(39,9,21),(41,9,22),(47,9,26),(53,9,28),(60,9,29),(147,9,42),(153,9,43),(159,9,44),(160,9,45),(162,9,46),(168,9,47),(174,9,48),(181,9,49),(184,9,50),(188,9,51),(233,9,90),(262,9,115),(31,10,20),(234,10,90),(32,11,20),(33,12,20),(34,13,20),(237,13,90),(40,14,21),(44,15,23),(46,15,25),(72,15,33),(132,15,39),(138,15,40),(48,16,27),(54,17,28),(61,17,29),(62,18,29),(148,18,42),(154,18,43),(169,18,47),(175,18,48),(182,18,49),(63,19,30),(64,20,30),(65,21,30),(70,22,33),(71,23,33),(73,24,33),(74,25,34),(75,26,34),(76,27,35),(77,28,36),(78,29,37),(79,30,37),(80,31,37),(81,32,37),(82,33,37),(83,34,37),(84,35,37),(85,36,37),(86,37,37),(87,38,37),(88,39,37),(89,40,37),(90,41,37),(91,42,37),(92,43,37),(93,44,37),(94,45,37),(95,46,37),(96,47,37),(97,48,37),(98,49,37),(99,50,37),(100,51,37),(101,52,37),(102,53,37),(103,54,37),(104,55,37),(105,56,37),(106,57,37),(107,58,37),(108,59,37),(109,60,37),(110,61,37),(111,62,37),(112,63,37),(113,64,37),(114,65,37),(115,66,37),(116,67,37),(117,68,37),(118,69,37),(119,70,37),(120,71,37),(121,72,37),(122,73,37),(123,74,37),(124,75,37),(125,76,37),(126,77,37),(127,78,38),(134,78,39),(140,78,40),(129,79,38),(130,80,39),(131,81,39),(135,82,39),(136,83,39),(137,84,40),(141,85,40),(176,86,48),(183,86,49),(192,87,52),(193,88,52),(194,89,53),(195,89,54),(196,89,55),(197,89,56),(198,89,57),(199,89,58),(200,89,59),(201,89,60),(202,89,61),(203,89,62),(204,89,63),(205,89,64),(206,89,65),(207,89,66),(208,89,67),(209,89,68),(210,89,69),(211,89,70),(212,89,71),(213,89,72),(214,89,73),(215,89,74),(216,89,75),(217,89,76),(218,89,77),(219,89,78),(220,89,79),(221,89,80),(222,89,81),(223,89,82),(224,89,83),(225,89,84),(269,89,117),(226,90,85),(227,91,86),(228,92,87),(229,93,37),(230,94,37),(268,98,37),(287,99,1),(270,99,4),(280,99,6),(277,99,8),(279,99,9),(286,99,123),(275,100,8),(276,101,8),(278,102,8),(285,103,123),(288,104,37),(289,105,41);

INSERT INTO `ab_permission_view_role` VALUES (43,1,1),(231,1,3),(411,1,4),(573,1,6),(44,2,1),(241,2,3),(421,2,4),(34,3,1),(232,3,3),(412,3,4),(35,4,1),(242,4,3),(422,4,4),(45,5,1),(233,5,3),(413,5,4),(46,6,1),(243,6,3),(423,6,4),(32,7,1),(234,7,3),(414,7,4),(33,8,1),(244,8,3),(424,8,4),(28,9,1),(235,9,3),(415,9,4),(29,10,1),(245,10,3),(425,10,4),(40,11,1),(236,11,3),(416,11,4),(41,12,1),(246,12,3),(140,13,1),(141,14,1),(36,15,1),(237,15,3),(417,15,4),(37,16,1),(247,16,3),(426,16,4),(38,17,1),(238,17,3),(418,17,4),(574,17,6),(39,18,1),(42,19,1),(239,19,3),(419,19,4),(1,20,1),(2,21,1),(3,22,1),(248,22,3),(427,22,4),(4,23,1),(252,23,3),(431,23,4),(5,24,1),(249,24,3),(428,24,4),(6,25,1),(253,25,3),(432,25,4),(7,26,1),(8,27,1),(9,28,1),(10,29,1),(11,30,1),(12,31,1),(300,31,3),(470,31,4),(13,32,1),(301,32,3),(471,32,4),(14,33,1),(15,34,1),(16,35,1),(17,36,1),(18,37,1),(19,38,1),(20,39,1),(21,40,1),(22,41,1),(288,41,3),(458,41,4),(23,42,1),(262,42,3),(438,42,4),(24,43,1),(272,43,3),(448,43,4),(25,44,1),(302,44,3),(472,44,4),(26,45,1),(263,45,3),(439,45,4),(27,46,1),(303,46,3),(473,46,4),(30,47,1),(289,47,3),(459,47,4),(31,48,1),(307,48,3),(477,48,4),(47,49,1),(48,50,1),(264,50,3),(440,50,4),(49,51,1),(50,52,1),(51,53,1),(290,53,3),(460,53,4),(52,54,1),(53,55,1),(54,56,1),(55,57,1),(56,58,1),(57,59,1),(58,60,1),(59,61,1),(60,62,1),(61,63,1),(311,63,3),(478,63,4),(62,64,1),(312,64,3),(479,64,4),(63,65,1),(313,65,3),(480,65,4),(64,66,1),(250,66,3),(429,66,4),(65,67,1),(254,67,3),(433,67,4),(66,68,1),(251,68,3),(430,68,4),(67,69,1),(255,69,3),(434,69,4),(68,70,1),(314,70,3),(69,71,1),(315,71,3),(481,71,4),(70,72,1),(304,72,3),(474,72,4),(71,73,1),(316,73,3),(482,73,4),(72,74,1),(317,74,3),(483,74,4),(73,75,1),(318,75,3),(484,75,4),(74,76,1),(319,76,3),(485,76,4),(75,77,1),(320,77,3),(486,77,4),(76,78,1),(321,78,3),(487,78,4),(77,79,1),(322,79,3),(488,79,4),(78,80,1),(323,80,3),(489,80,4),(79,81,1),(324,81,3),(490,81,4),(80,82,1),(325,82,3),(491,82,4),(81,83,1),(326,83,3),(492,83,4),(82,84,1),(327,84,3),(493,84,4),(83,85,1),(328,85,3),(494,85,4),(84,86,1),(329,86,3),(495,86,4),(85,87,1),(330,87,3),(496,87,4),(86,88,1),(331,88,3),(497,88,4),(87,89,1),(332,89,3),(498,89,4),(88,90,1),(333,90,3),(499,90,4),(89,91,1),(334,91,3),(500,91,4),(90,92,1),(335,92,3),(501,92,4),(91,93,1),(336,93,3),(502,93,4),(92,94,1),(337,94,3),(503,94,4),(93,95,1),(338,95,3),(504,95,4),(94,96,1),(339,96,3),(505,96,4),(95,97,1),(340,97,3),(506,97,4),(96,98,1),(341,98,3),(507,98,4),(97,99,1),(342,99,3),(508,99,4),(98,100,1),(343,100,3),(509,100,4),(575,100,6),(99,101,1),(344,101,3),(510,101,4),(100,102,1),(345,102,3),(511,102,4),(101,103,1),(346,103,3),(512,103,4),(102,104,1),(347,104,3),(513,104,4),(103,105,1),(348,105,3),(514,105,4),(104,106,1),(349,106,3),(515,106,4),(105,107,1),(350,107,3),(516,107,4),(576,107,6),(106,108,1),(351,108,3),(517,108,4),(107,109,1),(352,109,3),(518,109,4),(577,109,6),(108,110,1),(353,110,3),(519,110,4),(109,111,1),(354,111,3),(520,111,4),(110,112,1),(571,112,5),(111,113,1),(355,113,3),(521,113,4),(112,114,1),(356,114,3),(522,114,4),(113,115,1),(357,115,3),(523,115,4),(114,116,1),(358,116,3),(524,116,4),(115,117,1),(359,117,3),(525,117,4),(116,118,1),(360,118,3),(526,118,4),(117,119,1),(361,119,3),(527,119,4),(578,119,6),(118,120,1),(119,121,1),(362,121,3),(528,121,4),(120,122,1),(363,122,3),(529,122,4),(121,123,1),(579,123,6),(122,124,1),(364,124,3),(530,124,4),(123,125,1),(572,125,5),(124,126,1),(365,126,3),(531,126,4),(125,127,1),(366,127,3),(532,127,4),(126,128,1),(273,128,3),(449,128,4),(127,129,1),(369,129,3),(535,129,4),(128,130,1),(370,130,3),(536,130,4),(129,131,1),(371,131,3),(537,131,4),(130,132,1),(305,132,3),(475,132,4),(131,133,1),(274,133,3),(450,133,4),(132,134,1),(367,134,3),(533,134,4),(133,135,1),(372,135,3),(538,135,4),(134,136,1),(373,136,3),(539,136,4),(135,137,1),(374,137,3),(540,137,4),(136,138,1),(306,138,3),(476,138,4),(137,139,1),(275,139,3),(451,139,4),(138,140,1),(368,140,3),(534,140,4),(139,141,1),(375,141,3),(541,141,4),(142,142,1),(240,142,3),(420,142,4),(143,143,1),(256,143,3),(435,143,4),(144,144,1),(265,144,3),(441,144,4),(145,145,1),(276,145,3),(452,145,4),(146,146,1),(282,146,3),(455,146,4),(147,147,1),(291,147,3),(461,147,4),(148,148,1),(308,148,3),(149,149,1),(257,149,3),(436,149,4),(150,150,1),(266,150,3),(442,150,4),(151,151,1),(277,151,3),(453,151,4),(152,152,1),(283,152,3),(456,152,4),(153,153,1),(292,153,3),(462,153,4),(154,154,1),(309,154,3),(155,155,1),(258,155,3),(437,155,4),(156,156,1),(267,156,3),(443,156,4),(157,157,1),(278,157,3),(454,157,4),(158,158,1),(284,158,3),(457,158,4),(159,159,1),(293,159,3),(463,159,4),(160,160,1),(294,160,3),(464,160,4),(161,161,1),(268,161,3),(444,161,4),(162,162,1),(295,162,3),(465,162,4),(163,163,1),(269,163,3),(445,163,4),(164,164,1),(165,165,1),(166,166,1),(167,167,1),(168,168,1),(169,169,1),(170,170,1),(259,170,3),(171,171,1),(270,171,3),(446,171,4),(172,172,1),(279,172,3),(173,173,1),(285,173,3),(174,174,1),(296,174,3),(466,174,4),(175,175,1),(310,175,3),(176,176,1),(376,176,3),(177,177,1),(178,178,1),(271,178,3),(447,178,4),(179,179,1),(180,180,1),(181,181,1),(297,181,3),(467,181,4),(182,182,1),(183,183,1),(184,184,1),(298,184,3),(468,184,4),(185,185,1),(280,185,3),(186,186,1),(286,186,3),(187,187,1),(260,187,3),(188,188,1),(299,188,3),(469,188,4),(189,189,1),(281,189,3),(190,190,1),(287,190,3),(191,191,1),(261,191,3),(192,192,1),(377,192,3),(542,192,4),(193,193,1),(378,193,3),(543,193,4),(194,194,1),(195,195,1),(379,195,3),(544,195,4),(196,196,1),(380,196,3),(545,196,4),(197,197,1),(381,197,3),(546,197,4),(198,198,1),(199,199,1),(382,199,3),(547,199,4),(200,200,1),(383,200,3),(548,200,4),(201,201,1),(384,201,3),(549,201,4),(202,202,1),(385,202,3),(203,203,1),(386,203,3),(550,203,4),(204,204,1),(387,204,3),(551,204,4),(205,205,1),(388,205,3),(206,206,1),(389,206,3),(552,206,4),(207,207,1),(390,207,3),(553,207,4),(208,208,1),(391,208,3),(554,208,4),(209,209,1),(392,209,3),(555,209,4),(210,210,1),(393,210,3),(556,210,4),(211,211,1),(394,211,3),(557,211,4),(212,212,1),(395,212,3),(558,212,4),(213,213,1),(580,213,6),(214,214,1),(396,214,3),(559,214,4),(581,214,6),(215,215,1),(397,215,3),(560,215,4),(582,215,6),(216,216,1),(398,216,3),(561,216,4),(583,216,6),(217,217,1),(399,217,3),(562,217,4),(218,218,1),(400,218,3),(563,218,4),(219,219,1),(401,219,3),(564,219,4),(220,220,1),(402,220,3),(221,221,1),(403,221,3),(565,221,4),(222,222,1),(404,222,3),(566,222,4),(223,223,1),(405,223,3),(567,223,4),(224,224,1),(406,224,3),(568,224,4),(225,225,1),(226,226,1),(407,226,3),(227,227,1),(408,227,3),(228,228,1),(229,229,1),(409,229,3),(569,229,4),(230,230,1),(410,230,3),(570,230,4),(584,231,1),(585,232,1),(586,233,1),(587,234,1),(591,234,3),(592,234,4),(588,235,1),(589,236,1),(590,237,1),(593,262,1),(606,262,3),(614,262,4),(594,263,1),(605,263,3),(613,263,4),(595,264,1),(604,264,3),(612,264,4),(596,265,1),(603,265,3),(611,265,4),(597,266,1),(602,266,3),(610,266,4),(598,267,1),(601,267,3),(609,267,4),(599,268,1),(608,268,3),(616,268,4),(600,269,1),(607,269,3),(615,269,4),(617,270,1),(646,270,3),(663,270,4),(618,271,1),(637,271,3),(654,271,4),(619,272,1),(641,272,3),(658,272,4),(620,273,1),(638,273,3),(655,273,4),(621,274,1),(642,274,3),(659,274,4),(622,275,1),(650,275,3),(666,275,4),(623,276,1),(624,277,1),(648,277,3),(664,277,4),(625,278,1),(651,278,3),(667,278,4),(626,279,1),(627,280,1),(647,280,3),(628,281,1),(639,281,3),(656,281,4),(629,282,1),(643,282,3),(660,282,4),(630,283,1),(640,283,3),(657,283,4),(631,284,1),(644,284,3),(661,284,4),(632,285,1),(652,285,3),(668,285,4),(633,286,1),(649,286,3),(665,286,4),(634,287,1),(645,287,3),(662,287,4),(635,288,1),(653,288,3),(669,288,4),(636,289,1);

INSERT INTO `ab_role` VALUES (1,'Admin'),(3,'Alpha'),(4,'Gamma'),(5,'granter'),(2,'Public'),(6,'sql_lab');

INSERT INTO `ab_user` VALUES (1,'Superset','Admin','admin','pbkdf2:sha256:150000$5Zck7zoE$a1d0234904ab81780c06e0e67e50797ed3c69f934b9cef535ea608d7fcf6a69b',1,'admin@superset.com','2022-11-17 11:37:37',4,0,'2022-06-27 04:22:07','2022-06-27 04:22:07',NULL,NULL);

INSERT INTO `ab_user_role` VALUES (1,1,1);

INSERT INTO `ab_view_menu` VALUES (59,'Access requests'),(47,'AccessRequestsModelView'),(58,'Action Log'),(45,'AlertLogModelView'),(44,'AlertModelView'),(46,'AlertObservationModelView'),(68,'Alerts'),(69,'Alerts & Report'),(86,'all_database_access'),(85,'all_datasource_access'),(87,'all_query_access'),(5,'Annotation'),(62,'Annotation Layers'),(30,'Api'),(26,'AsyncEventsRestApi'),(19,'AuthDBView'),(89,'AuthOAuthView'),(27,'CacheRestApi'),(4,'Chart'),(67,'Chart Emails'),(71,'Charts'),(116,'ColumnarToDatabaseView'),(64,'CSS Templates'),(2,'CssTemplate'),(31,'CsvToDatabaseView'),(118,'CurrentUserRestApi'),(8,'Dashboard'),(66,'Dashboard Email Schedules'),(42,'DashboardEmailScheduleView'),(119,'DashboardFilterStateRestApi'),(120,'DashboardPermalinkRestApi'),(70,'Dashboards'),(76,'Data'),(9,'Database'),(77,'Databases'),(6,'Dataset'),(78,'Datasets'),(33,'Datasource'),(52,'Druid'),(82,'Druid Clusters'),(81,'Druid Datasources'),(49,'DruidClusterModelView'),(51,'DruidColumnInlineView'),(48,'DruidDatasourceModelView'),(50,'DruidMetricInlineView'),(28,'DynamicPlugin'),(124,'EmbeddedView'),(32,'ExcelToDatabaseView'),(121,'ExploreFormDataRestApi'),(122,'ExplorePermalinkRestApi'),(115,'FilterSets'),(60,'Home'),(65,'Import Dashboards'),(123,'ImportExportRestApi'),(34,'KV'),(55,'List Roles'),(54,'List Users'),(13,'LocaleView'),(7,'Log'),(61,'Manage'),(25,'MenuApi'),(23,'OpenApi'),(63,'Plugins'),(10,'Query'),(75,'Query Search'),(35,'R'),(84,'Refresh Druid Metadata'),(15,'RegisterUserDBView'),(22,'RegisterUserModelView'),(88,'RegisterUserOAuthView'),(3,'ReportSchedule'),(17,'ResetMyPasswordView'),(16,'ResetPasswordView'),(21,'RoleModelView'),(57,'Row Level Security'),(29,'RowLevelSecurityFiltersModelView'),(74,'Saved Queries'),(1,'SavedQuery'),(83,'Scan New Datasources'),(53,'Security'),(14,'SecurityApi'),(41,'SecurityRestApi'),(43,'SliceEmailScheduleView'),(73,'SQL Editor'),(72,'SQL Lab'),(36,'SqlLab'),(37,'Superset'),(11,'SupersetIndexView'),(24,'SwaggerView'),(38,'TableSchemaView'),(39,'TabStateView'),(40,'TagView'),(117,'Upload a Columnar file'),(79,'Upload a CSV'),(80,'Upload Excel'),(56,"User's Statistics"),(20,'UserDBModelView'),(18,'UserInfoEditView'),(90,'UserOAuthModelView'),(12,'UtilView');
