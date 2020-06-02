/*
cd /usr/local/src/ikono/database-trunk/
svn update
*/

ALTER TABLE jos_agents_shift ADD COLUMN repeat_agents TINYINT(1) UNSIGNED NOT NULL DEFAULT 1;
UPDATE jos_agents_shift SET repeat_agents = 0 WHERE id = 1;
ALTER TABLE jos_cm_device MODIFY ip VARCHAR(255);
ALTER TABLE jos_cm_queue ADD COLUMN vars TEXT DEFAULT NULL COMMENT 'Parámetros adicionales de asterisk';

source /usr/local/src/ikono/database-trunk/agents/prevent_repeated_shifts.sql
source /usr/local/src/ikono/database-trunk/agents/replicate_agents.sql
source /usr/local/src/ikono/database-trunk/operation_time/operation_time.sql

/* ======================= */

CREATE TABLE `jos_tally_custom_detail` (
    `id` int(11) NOT NULL COMMENT 'Custom Tally ID',
    `label` varchar(255) NOT NULL COMMENT 'Label of the tally',
    `deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT 'Indicates 1 if this tally must be deleted',
    `checked_out` int(11) DEFAULT NULL COMMENT 'ID of the user that has the record checked out. 0 if not checked out',
    `checked_out_time` datetime DEFAULT NULL COMMENT 'Date and time that the user checked out the record. NULL if not checked_out',
    CONSTRAINT pk_custom_tally PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Custom Tallies to grade calls';

ALTER TABLE jos_customer_survey ADD COLUMN answer4 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer5 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer6 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer7 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer8 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer9 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer10 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer11 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer12 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer13 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer14 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer15 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer16 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer17 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer18 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer19 TEXT;
ALTER TABLE jos_customer_survey ADD COLUMN answer20 TEXT;

ALTER TABLE jos_dialer_contacts ADD COLUMN send_at DATETIME DEFAULT NULL COMMENT 'Fecha de envío del mensaje de texto';

source /usr/local/src/ikono/database-trunk/holidays_2019_2033.sql
source /usr/local/src/ikono/database-trunk/text_messages/tables.sql

/* ======================= */

CREATE TABLE `jos_cm_role` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(255) NOT NULL,
  `checked_out` INT(11) DEFAULT NULL COMMENT 'ID of the user that has the record checked out. 0 if not checked out',
  `checked_out_time` DATETIME DEFAULT NULL COMMENT 'Date and time that the user checked out the record. NULL if not checked_out',
  CONSTRAINT pk_role PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE jos_cm_role ADD UNIQUE `UQ_cm_role` (`role`);
INSERT INTO jos_cm_role(role) SELECT DISTINCT role FROM jos_queuelog_call WHERE role IS NOT NULL;

/* ======================= */

ALTER TABLE jos_cm_device MODIFY tmpl_keys_buttons MEDIUMTEXT;
ALTER TABLE jos_setup_blacklist_contact DROP INDEX UQ_number_blacklist_contact;
ALTER TABLE jos_setup_blacklist_contact ADD CONSTRAINT UQ_number_list_contact UNIQUE (`number`,`blacklist_id`);
ALTER TABLE jos_queuelog_recordings ADD COLUMN tags TEXT;
ALTER TABLE jos_agents_agent_shifts ADD COLUMN `rule_id` INT(11) UNSIGNED DEFAULT NULL;
ALTER TABLE jos_agents_agent_shifts ADD CONSTRAINT `fk_agents_shift_rule` FOREIGN KEY (`rule_id`) REFERENCES `jos_agents_shift_rules`(`id`) ON UPDATE CASCADE ON DELETE CASCADE;

/* ======================= */

INSERT INTO jos_cm_oui (mac, organization) values ('00-A2-89', 'Cisco');
INSERT INTO jos_cm_oui (mac, organization) values ('00-59-DC', 'Cisco');
INSERT INTO jos_cm_oui (mac, organization) values ('64-16-7F', 'Polycom');
INSERT INTO jos_cm_oui (mac, organization) values ('C0-74-AD', 'Grandstream Networks, Inc.');
