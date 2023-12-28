-- -- column modification in new superset version
-- -- dashboards table
-- -- alter table dashboards add certified_by text null;
-- -- alter table dashboards add certification_details text null;
-- alter table dashboards add is_managed_externally tinyint(1) default 0 not null;
-- alter table dashboards add external_url text null;

-- -- datasources table
-- alter table datasources add is_managed_externally tinyint(1) default 0 not null;
-- alter table datasources add external_url text null;

-- -- dbs table
-- alter table dbs add allow_file_upload tinyint(1) null;
-- alter table dbs add is_managed_externally tinyint(1) default 0 not null;
-- alter table dbs add external_url text null;

-- -- report_schedule table
-- alter table report_schedule add extra text not null;
-- alter table report_schedule add force_screenshot tinyint(1) null;

-- -- slices table
-- -- alter table slices add certified_by text null;
-- -- alter table slices add certification_details text null;
-- alter table slices add is_managed_externally tinyint(1) default 0 not null;
-- alter table slices add external_url text null;

-- -- tab_state table
-- alter table tab_state add saved_query_id int null;

-- -- table_columns table
-- alter table table_columns MODIFY `type` text null;
-- -- alter table table_columns add extra text null;

-- -- tables table
-- alter table tables add is_managed_externally tinyint(1) default 0 not null;
-- alter table tables add external_url text null;
