CREATE OR REPLACE FUNCTION get_anomaly_from_operative(oper_name text) 
RETURNS TABLE(anomaly_name anomaly_, anomaly_size size_, longitude numeric, widht numeric) AS
$$
BEGIN
    IF (SELECT COUNT(*) FROM operative JOIN human ON human.id=id_human WHERE name=oper_name) = 0 then
        RAISE EXCEPTION 'Cant find operative with this name';
    ELSIF (SELECT COUNT(*) FROM operative JOIN human ON human.id=id_human WHERE name=oper_name) > 1 then
        RAISE NOTICE 'Attention! There is a person with the same name, please use id';
		RETURN;
    END IF;
    RETURN query SELECT anomaly.name, anomaly.size, anomaly.longitude, anomaly.widht FROM Anomaly
        JOIN Operative ON operative.id=anomaly.id_operative
        JOIN Human ON human.id=operative.id_human WHERE human.name=oper_name;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION get_anomaly_from_operative(oper_id integer) 
RETURNS TABLE(anomaly_name anomaly_, anomaly_size size_, longitude numeric, widht numeric) AS
$$
BEGIN
    IF (SELECT COUNT(*) FROM operative WHERE operative.id=oper_id) = 0 then
        RAISE EXCEPTION 'Cant find operative with this id';
		RETURN;
    END IF;
    RETURN query SELECT anomaly.name, anomaly.size, anomaly.longitude, anomaly.widht FROM Anomaly
        JOIN Operative ON operative.id=anomaly.id_operative WHERE operative.id=oper_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_mets_from_operative(oper_id integer) 
RETURNS TABLE(metamorphite_name mets_) AS
$$
BEGIN
    IF (SELECT COUNT(*) FROM operative WHERE operative.id=oper_id) = 0 then
        RAISE EXCEPTION 'Cant find operative with this id';
		RETURN;
    END IF;
    RETURN query SELECT metamorphite.name FROM operative 
		JOIN owners_met ON operative.id=owners_met.id_operative 
		JOIN metamorphite ON owners_met.id_metamorphite=metamorphite.id WHERE operative.id=oper_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_eqp_from_operative(oper_name text) 
RETURNS TABLE(eqp_name text, eqp_desc text) AS
$$
BEGIN
    IF (SELECT COUNT(*) FROM operative JOIN human ON human.id=id_human WHERE name=oper_name) = 0 then
        RAISE EXCEPTION 'Cant find operative with this name';
    ELSIF (SELECT COUNT(*) FROM operative JOIN human ON human.id=id_human WHERE name=oper_name) > 1 then
        RAISE NOTICE 'Attention! There is a person with the same name, please use id';
		RETURN;
    END IF;
    RETURN query SELECT equipment.name, equipment.description FROM Human
		JOIN operative ON human.id=operative.id_human
		JOIN owners_eqp ON operative.id=owners_eqp.id_operative 
		JOIN equipment ON owners_eqp.id_equipment=equipment.id WHERE human.name=oper_name;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_kills_from_operative(oper_name text) 
RETURNS TABLE(name_killed text, surname_killed text) AS
$$
BEGIN
    IF (SELECT COUNT(*) FROM operative JOIN human ON human.id=id_human WHERE name=oper_name) = 0 then
        RAISE EXCEPTION 'Cant find operative with this name';
    ELSIF (SELECT COUNT(*) FROM operative JOIN human ON human.id=id_human WHERE name=oper_name) > 1 then
        RAISE NOTICE 'Attention! There is a person with the same name, please use id';
		RETURN;
    END IF;
    RETURN query SELECT human.name, human.surname FROM Operative
		JOIN Kill ON operative.id=kill.id_operative
		JOIN Citizen ON kill.id_citizen=citizen.id
		JOIN Human ON citizen.id_human=human.id
		WHERE Kill.name='t' AND human.name=oper_name;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_kills_from_operative(oper_id integer) 
RETURNS TABLE(name_killed text, surname_killed text) AS
$$
BEGIN
    IF (SELECT COUNT(*) FROM operative JOIN human ON human.id=id_human WHERE name=oper_name) = 0 then
        RAISE EXCEPTION 'Cant find operative with this name';
    ELSIF (SELECT COUNT(*) FROM operative JOIN human ON human.id=id_human WHERE name=oper_name) > 1 then
        RAISE NOTICE 'Attention! There is a person with the same name, please use id';
		RETURN;
    END IF;
    RETURN query SELECT human.name, human.surname FROM Operative
		JOIN Kill ON operative.id=kill.id_operative
		JOIN Citizen ON kill.id_citizen=citizen.id
		JOIN Human ON citizen.id_human=human.id
		WHERE Kill.name='t' AND operative.id=oper_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION check_coordinates(longitude_check_left numeric, 
											longitude_check_right numeric,
											widht_check_left numeric,
											widht_check_right numeric) 
RETURNS TABLE(name_anomaly anomaly_, longitude_anomaly numeric, widht_anomaly numeric) AS 
$$
BEGIN
    RETURN query SELECT anomaly.name, anomaly.longitude, anomaly.widht FROM Anomaly
		WHERE anomaly.longitude > longitude_check_left 
		AND anomaly.longitude < longitude_check_right
		AND anomaly.widht > widht_check_left
		AND anomaly.widht < widht_check_right;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE update_rank_operative(oper_id integer, new_rank rank_) as
$$
BEGIN
   UPDATE Operative SET grade=new_rank WHERE id=oper_id;
   RAISE NOTICE 'Rank of Operative was updated';
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE update_brigade_citizen(citizen_id integer, new_brigade integer) as
$$
BEGIN
   UPDATE Citizen SET id_brigade=new_brigade WHERE id=citizen_id;
   RAISE NOTICE 'Brigade of Citizen was updated';
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE update_zone_location(location_id integer, new_zone zone_) as
$$
BEGIN
   UPDATE Location SET zone=new_zone WHERE id=location_id;
   RAISE NOTICE 'Zone of Location was updated';
END;
$$ LANGUAGE plpgsql;