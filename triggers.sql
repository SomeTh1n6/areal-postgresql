CREATE OR REPLACE FUNCTION validate_operative()
RETURNS TRIGGER
AS $$
DECLARE
   operative_age integer;
BEGIN
	SELECT age into operative_age FROM human WHERE id = new.id_human;
	IF operative_age < 21 THEN
		RAISE NOTICE 'Age of the Operative must be at least 21 years old';
		RETURN NULL;
	END IF;
	RETURN NEW;	
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_age_operative
	BEFORE INSERT ON Operative
	FOR EACH ROW
	EXECUTE PROCEDURE validate_operative();
	
	
CREATE OR REPLACE FUNCTION validate_captive()	
RETURNS TRIGGER
AS $$
DECLARE
   citizen_age integer;
BEGIN
	SELECT age into citizen_age FROM human
	JOIN citizen ON human.id=citizen.id_human
	JOIN captive ON captive.id_citizen=citizen.id 
	WHERE citizen.id = NEW.citizen_id;
	IF citizen_age < 16 AND NEW.name = 0 THEN
		RAISE NOTICE 'The captive citizen is less than 16 years old, he must be released';
		RETURN NULL;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_age_captive
	BEFORE INSERT ON Captive
	FOR EACH ROW
	EXECUTE PROCEDURE validate_captive();
	

CREATE OR REPLACE FUNCTION validate_anomaly()	
RETURNS TRIGGER
AS $$
BEGIN
	IF (NEW.width > 65 OR NEW.width < 55) AND (NEW.longitude > 60 OR NEW.longitude < 40) THEN
		RAISE NOTICE 'The anomaly cannot be located outside the AREAL';
		RETURN NULL;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_anomaly_location
	BEFORE INSERT ON Anomaly
	FOR EACH ROW
	EXECUTE PROCEDURE validate_anomaly();


CREATE OR REPLACE FUNCTION validate_location()	
RETURNS TRIGGER
AS $$
BEGIN
	IF (NEW.width > 65 OR NEW.width < 55) AND (NEW.longitude > 60 OR NEW.longitude < 40) THEN
		RAISE NOTICE 'The areal location cannot be located outside the AREAL';
		RETURN NULL;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_location_coordinates
	BEFORE INSERT ON Location
	FOR EACH ROW
	EXECUTE PROCEDURE validate_location();


CREATE OR REPLACE FUNCTION validate_squad()	
RETURNS TRIGGER
AS $$
DECLARE
   operative_rank text;
BEGIN
	SELECT grade into operative_rank FROM operative
	WHERE NEW.id_operative = id;
	IF operative_rank = 'рядовой' OR operative_rank = 'ефрейтор' THEN
		RAISE NOTICE 'grade of an operative is too low for admission to the operation';
		RETURN NULL;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_squad
	BEFORE INSERT ON Squad
	FOR EACH ROW
	EXECUTE PROCEDURE validate_squad();



