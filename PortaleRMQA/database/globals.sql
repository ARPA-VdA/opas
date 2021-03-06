SELECT rolname FROM pg_roles;
CREATE ROLE lily_admin NOINHERIT VALID UNTIL 'infinity';
CREATE USER lily WITH PASSWORD '$lily!' IN ROLE lily_admin NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
ALTER ROLE lily PASSWORD '$lily!';

GRANT read_only_sdms TO lily;
GRANT USAGE ON SCHEMA public TO GROUP lily_admin;
GRANT ALL ON TABLE public._users TO GROUP lily_admin;
GRANT SELECT ON TABLE metadata.station_typology TO GROUP lily_admin;
GRANT SELECT ON TABLE metadata.station_networktype TO GROUP lily_admin;
GRANT USAGE ON SCHEMA tool_builder TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_builder.stations_polling TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_builder.stations_alarms TO GROUP lily_admin;
GRANT USAGE ON SCHEMA tool_netcom TO GROUP lily_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE tool_netcom.data_operations TO GROUP lily_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE tool_netcom.data_spare_parts TO GROUP lily_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE tool_netcom.data_maintenances TO GROUP lily_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE tool_netcom.data_calibrations TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.network_users TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.view_stations_instruments TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.calibration_reasons TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.calibration_methods TO GROUP lily_admin;
GRANT SELECT, INSERT, UPDATE ON TABLE tool_netcom.cylinders TO GROUP lily_admin;
GRANT SELECT, INSERT, UPDATE ON TABLE tool_netcom.instruments TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.operations TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.instrument_categories TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.view_instruments TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.instrument_categories TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.stations_cylinders TO GROUP lily_admin;
GRANT SELECT, DELETE, INSERT, UPDATE ON TABLE tool_netcom.stations_cylinders TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.operation_frequency TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.spare_parts TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.instruments_operations TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.instruments_spare_parts TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.view_station_and_instruments TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.view_cylinders_stations TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_netcom.instruments_types TO GROUP lily_admin;
GRANT SELECT ON TABLE view_laboratories_roaming TO GROUP lily_admin;
GRANT SELECT ON TABLE _station_roaming_type TO GROUP lily_admin;
GRANT SELECT, DELETE, INSERT, UPDATE ON TABLE tool_netcom.stations_instruments TO GROUP lily_admin;
GRANT SELECT, UPDATE ON TABLE _stations TO GROUP lily_admin;
GRANT SELECT, DELETE, INSERT, UPDATE ON TABLE _stations_override TO GROUP lily_admin;
GRANT USAGE ON SCHEMA labanalysis TO GROUP lily_admin;
GRANT SELECT ON TABLE labanalysis._laboratory_filter TO GROUP lily_admin;
GRANT SELECT ON TABLE labanalysis._laboratory_analysis TO GROUP lily_admin;
GRANT SELECT ON TABLE labanalysis._laboratory_analysis_parameters TO GROUP lily_admin;
GRANT SELECT ON TABLE labanalysis.view_analysis_samples_by_user TO GROUP lily_admin;
GRANT SELECT, DELETE, INSERT, UPDATE ON TABLE labanalysis.laboratory_data TO GROUP lily_admin;
GRANT SELECT, DELETE, INSERT, UPDATE ON TABLE labanalysis.laboratory_samples TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE labanalysis.laboratory_samples_id_seq  TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE tool_netcom.data_calibrations_id_seq TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE tool_netcom.data_maintenances_ma_id_seq TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE tool_netcom.data_operations_id_seq TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE tool_netcom.data_spare_parts_id_seq TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE tool_netcom.cylinders_cy_id_seq TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE tool_netcom.stations_cylinders_st_cy_id_seq TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE tool_netcom.instruments_in_id_seq TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE tool_netcom.stations_instruments_st_in_id_seq TO GROUP lily_admin;
GRANT USAGE ON SEQUENCE _stations_override_id_seq  TO GROUP lily_admin;
GRANT USAGE ON SCHEMA warnings TO GROUP lily_admin;
GRANT SELECT ON TABLE warnings.view_warnings TO GROUP lily_admin;
GRANT SELECT ON TABLE warnings.warnings_list TO GROUP lily_admin;
GRANT SELECT ON TABLE warnings.warnings_type TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_builder.stations_alarms TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_builder.station_alarm_types TO GROUP lily_admin;
GRANT USAGE ON SCHEMA tool_visualizer TO GROUP lily_admin;
GRANT SELECT ON TABLE tool_visualizer.page_integration TO GROUP lily_admin;
GRANT USAGE ON SCHEMA tables_ar TO lily_admin;
GRANT UPDATE ON ALL TABLES IN SCHEMA tables_ar TO lily_admin;
GRANT USAGE ON SCHEMA stats TO lily_admin;
GRANT SELECT, UPDATE ON ALL TABLES IN SCHEMA stats TO lily_admin;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA stats TO lily;
GRANT EXECUTE ON FUNCTION stats.update_stat_status() TO lily_admin;
GRANT USAGE ON SEQUENCE labanalysis.laboratory_data_id_seq TO lily_admin;
GRANT INSERT ON TABLE history_changes TO lily_admin;

add SECURITY DEFINER to functions that manipulate data;
    labanalysis.delete_sample(integer)
    labanalysis.laboratory_calc()

GRANT EXECUTE ON FUNCTION stats.calculate_stats(smallint, timestamp without time zone, timestamp without time zone, character varying) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.calculate_stats_dayly(smallint, timestamp without time zone, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.create_month_table_query(integer) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.create_month_table_query_sql(integer) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.create_validation_daily_sql(integer, date, date) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.create_validation_monthly_sql(integer, date, date) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.create_validation_yearly_sql(integer, date, date) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_day(timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_day_stid(smallint, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_day_stid_prid(smallint, smallint, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_dayly(timestamp without time zone, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_dayly_stid(smallint, timestamp without time zone, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_month(timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_month_stid(smallint, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_month_stid_prid(smallint, smallint, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_monthly(timestamp without time zone, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_monthly_stid(smallint, timestamp without time zone, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_year(timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_year_stid(smallint, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_calculate_stats_year_stid_prid(smallint, smallint, timestamp without time zone) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_recalculate_stats_day() TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_recalculate_stats_day_stid(smallint) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_stats_day_to_recalc() TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_stats_month_to_recalc() TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.f_stats_year_to_recalc() TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.fill_status_monthly() TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.fill_status_monthly_maggio(character varying) TO lily_admin;
GRANT EXECUTE ON FUNCTION stats.recalc_stats_dd() TO lily_admin;

SET ROLE lily;
RESET ROLE;
CREATE EXTENSION IF NOT EXISTS plperl;
CREATE EXTENSION IF NOT EXISTS hstore;
