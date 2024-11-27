class AddAuditTriggersToReports < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TABLE audit_logs (
        id SERIAL PRIMARY KEY,
        table_name TEXT NOT NULL,
        operation TEXT NOT NULL,
        old_data JSONB,
        new_data JSONB,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );

      CREATE OR REPLACE FUNCTION audit_reports() RETURNS TRIGGER AS $$
      BEGIN
        IF (TG_OP = 'INSERT') THEN
          INSERT INTO audit_logs (table_name, operation, new_data, created_at)
          VALUES ('reports', 'INSERT', row_to_json(NEW), current_timestamp);
          RETURN NEW;
        ELSIF (TG_OP = 'UPDATE') THEN
          INSERT INTO audit_logs (table_name, operation, old_data, new_data, created_at)
          VALUES ('reports', 'UPDATE', row_to_json(OLD), row_to_json(NEW), current_timestamp);
          RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
          INSERT INTO audit_logs (table_name, operation, old_data, created_at)
          VALUES ('reports', 'DELETE', row_to_json(OLD), current_timestamp);
          RETURN OLD;
        END IF;
        RETURN NULL;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER audit_reports_trigger
      AFTER INSERT OR UPDATE OR DELETE ON reports
      FOR EACH ROW EXECUTE FUNCTION audit_reports();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS audit_reports_trigger ON reports;
      DROP FUNCTION IF EXISTS audit_reports();
      DROP TABLE IF EXISTS audit_logs;
    SQL
  end
end
