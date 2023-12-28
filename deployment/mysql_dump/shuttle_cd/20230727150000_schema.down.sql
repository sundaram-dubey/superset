-- Reversal Script for Dropping Columns

-- dashboards table
-- alter table dashboards drop column certified_by;
-- alter table dashboards drop column certification_details;
alter table dashboards drop column is_managed_externally;
alter table dashboards drop column external_url;

-- datasources table
alter table datasources drop column is_managed_externally;
alter table datasources drop column external_url;

-- dbs table
alter table dbs drop column allow_file_upload;
alter table dbs drop column is_managed_externally;
alter table dbs drop column external_url;

-- report_schedule table
alter table report_schedule drop column extra;
alter table report_schedule drop column force_screenshot;

-- slices table
-- alter table slices drop column certified_by;
-- alter table slices drop column certification_details;
alter table slices drop column is_managed_externally;
alter table slices drop column external_url;

-- tab_state table
alter table tab_state drop column saved_query_id;

-- table_columns table
alter table `table_columns` drop column extra;
-- alter table `table_columns` MODIFY `type` text;

-- tables table
alter table tables drop column is_managed_externally;
alter table tables drop column external_url;
