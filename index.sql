CREATE INDEX longitude_index_location ON Location USING btree(longitude);
CREATE INDEX widht_index_location ON Location USING btree(widht);
CREATE INDEX longitude_index_anomaly ON Anomaly USING btree(longitude);
CREATE INDEX widht_index_anomaly ON Anomaly USING btree(widht);
CREATE INDEX name_index_human ON Human USING hash(name);
CREATE INDEX surname_index_human ON Human USING hash(surname);
CREATE INDEX name_index_eqp ON Equipment USING hash(name);
