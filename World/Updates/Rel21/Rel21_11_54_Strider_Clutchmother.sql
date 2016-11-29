-- ----------------------------------------
-- Added to prevent timeout's while loading
-- ----------------------------------------
SET GLOBAL net_read_timeout=30;
SET GLOBAL net_write_timeout=60;
SET GLOBAL net_buffer_length=1000000; 
SET GLOBAL max_allowed_packet=1000000000;
SET GLOBAL connect_timeout=10000000;

-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update (v1.3)
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT structure FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurContent := (SELECT content FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '11'; 
    SET @cOldContent = '53';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '11';
    SET @cNewContent = '54';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Strider Clutchmother';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Strider Clutchmother';

    -- Evaluate all settings
    SET @cCurResult := (SELECT description FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cOldResult := (SELECT description FROM db_version WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;

        -- UPDATE THE DB VERSION
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
        SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

-- Cmangos Update 
-- Strider Clutchmother
UPDATE creature SET Spawndist = 0, MovementType = 2 WHERE id = 2172;
DELETE FROM creature_movement WHERE id = 37385;
UPDATE creature_template SET MovementType = 2 WHERE entry = 2172;
DELETE FROM creature_movement_template WHERE entry = 2172;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(2172,1,4516.77,607.805,31.7845, 0, 0,4.53384, 0, 0),
(2172,2,4519.16,571.186,32.5817, 0, 0,4.43565, 0, 0),
(2172,3,4506.04,545.204,39.1878, 0, 0,3.97226, 0, 0),
(2172,4,4484.27,524.398,43.4054, 0, 0,4.18667, 0, 0),
(2172,5,4475.53,496.37,48.935, 0, 0,3.81125, 0, 0),
(2172,6,4462.23,486.497,50.0938, 0, 0,3.42248, 0, 0),
(2172,7,4448,483.935,50.4496, 0, 0,3.34001, 0, 0),
(2172,8,4414.98,478.825,57.0827, 0, 0,3.29681, 0, 0),
(2172,9,4375.29,464.64,61.9022, 0, 0,3.87801, 0, 0),
(2172,10,4351.72,441.123,60.2804, 0, 0,4.14897, 0, 0),
(2172,11,4346.24,420.217,60.9888, 0, 0,4.48276, 0, 0),
(2172,12,4339.67,403.893,61.593, 0, 0,3.97697, 0, 0),
(2172,13,4322.4,397.517,62.6931, 0, 0,3.16958, 0, 0),
(2172,14,4300.05,404.118,62.2459, 0, 0,2.77688, 0, 0),
(2172,15,4283.83,413.06,60.7891, 0, 0,2.32528, 0, 0),
(2172,16,4276.19,431.525,61.5429, 0, 0,1.65376, 0, 0),
(2172,17,4278.02,448.285,60.9137, 0, 0,1.10006, 0, 0),
(2172,18,4299.49,481.952,60.6362, 0, 0,0.797677, 0, 0),
(2172,19,4369.62,540.487,59.3641, 0, 0,0.648449, 0, 0),
(2172,20,4404.23,564.665,48.7928, 0, 0,0.664157, 0, 0),
(2172,21,4425.79,586.472,42.1827, 0, 0,0.986171, 0, 0),
(2172,22,4430.26,606.587,39.6061, 0, 0,1.40636, 0, 0),
(2172,23,4437.38,624.615,36.918, 0, 0,0.852653, 0, 0),
(2172,24,4455.5,639.752,31.2693, 0, 0,0.825164, 0, 0),
(2172,25,4474.88,666.869,26.2529, 0, 0,0.855009, 0, 0),
(2172,26,4500.03,694.421,24.5656, 0, 0,0.595828, 0, 0),
(2172,27,4513.71,706.448,23.2624, 0, 0,0.0970998, 0, 0),
(2172,28,4528.3,704.51,24.6299, 0, 0,6.03864, 0, 0),
(2172,29,4535.2,690.152,25.2516, 4000, 0,4.69955, 0, 0), -- let sync. with links
(2172,30,4520.51,660.629,24.7118, 0, 0,4.51498, 0, 0);

DELETE FROM creature_loot_template WHERE  entry = 2172;
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, condition_id) VALUES
(2172,3312,0.2,0,1,1,0),
(2172,4681,0.04,0,1,1,0),
(2172,4687,0.04,0,1,1,0),
(2172,5469,56,0,1,2,0),
(2172,6266,4,0,1,1,0),
(2172,6268,5,0,1,1,0),
(2172,6336,4,0,1,1,0),
(2172,6512,5,0,1,1,0),
(2172,6537,0.8,0,1,1,0),
(2172,6539,1.8,0,1,1,0),
(2172,6541,2,0,1,1,0),
(2172,6542,2,0,1,1,0),
(2172,6543,1.4,0,1,1,0),
(2172,6546,1,0,1,1,0),
(2172,6547,1.3,0,1,1,0),
(2172,6548,2,0,1,1,0),
(2172,6549,4,0,1,1,0),
(2172,6550,1.8,0,1,1,0),
(2172,6551,1.2,0,1,1,0),
(2172,6554,0.8,0,1,1,0),
(2172,6555,3,0,1,1,0),
(2172,6556,1.4,0,1,1,0),
(2172,6557,3,0,1,1,0),
(2172,6558,1.7,0,1,1,0),
(2172,6564,0.19,0,1,1,0),
(2172,6565,0.2,0,1,1,0),
(2172,6575,0.2,0,1,1,0),
(2172,9746,0.8,0,1,1,0),
(2172,9747,12,0,1,1,0),
(2172,9748,2,0,1,1,0),
(2172,9749,2,0,1,1,0),
(2172,9755,0.7,0,1,1,0),
(2172,9756,12,0,1,1,0),
(2172,9757,1.2,0,1,1,0),
(2172,9759,0.6,0,1,1,0),
(2172,9762,0.8,0,1,1,0),
(2172,9763,11,0,1,1,0),
(2172,9765,1.4,0,1,1,0),
(2172,9785,1.5,0,1,1,0),
(2172,9786,3,0,1,1,0),
(2172,15013,0.6,0,1,1,0),
(2172,15303,0.3,0,1,1,0),
(2172,15485,0.4,0,1,1,0),
(2172,15491,0.3,0,1,1,0),
(2172,17056,11,0,1,1,0);

-- Foreststrider Fledgling
-- few duplicates removed Moonstalker Runt x2
DELETE FROM creature WHERE guid IN (60816,36938,36942);
DELETE FROM creature_addon WHERE guid IN (60816,36938,36942);
DELETE FROM creature_movement WHERE id IN (60816,36938,36942);
DELETE FROM game_event_creature WHERE guid IN (60816,36938,36942);
DELETE FROM game_event_creature_data WHERE guid IN (60816,36938,36942);
DELETE FROM creature_battleground WHERE guid IN (60816,36938,36942);
DELETE FROM creature_linking WHERE guid IN (60816,36938,36942) OR master_guid IN (60816,36938,36942);
INSERT INTO creature (guid, id, map, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
(60816,2321,1,0,0,4519.65,662.168,24.5682,4.7561,275,0,0,222,0,0,0);
UPDATE creature_template SET SpeedWalk = 0.94 WHERE Entry = 2321;

-- links
DELETE FROM creature_linking WHERE guid IN (36692,60816);
INSERT INTO creature_linking (guid, master_guid, flag) VALUES
(36692, 37385, 1+2+128+512),
(60816, 37385, 1+2+128+512);

    

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL ABOVE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

        -- If we get here ok, commit the changes
        IF bRollback = TRUE THEN
            ROLLBACK;
            SHOW ERRORS;
            SELECT '* UPDATE FAILED *' AS `===== Status =====`,@cCurResult AS `===== DB is on Version: =====`;



        ELSE
            COMMIT;
            SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,@cNewResult AS `===== DB is now on Version =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cCurResult AS `===== DB is already on Version =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
		IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
		ELSE
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                END IF;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;

