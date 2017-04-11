DROP PROCEDURE IF EXISTS clear_DB;

CREATE PROCEDURE clear_DB( 
        DB_NAME varchar(50)  # 数据库名称
  )
BEGIN
  DECLARE done INT DEFAULT 0;  #游标的标志位
  DECLARE name varchar(250);
  DECLARE cmd varchar(550);
  DECLARE tb_name CURSOR FOR SELECT table_name FROM information_schema.TABLES WHERE table_schema=DB_NAME;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
  SET FOREIGN_KEY_CHECKS = 0;
  OPEN tb_name;
  REPEAT
    FETCH tb_name INTO name;
    IF NOT done THEN 
       #set cmd=concat('Delete from ',DB_NAME,'.','`',`name`,'`'); 
       set cmd=concat('drop table ',DB_NAME,'.',`name`);  # 拼删除命令 
       SET @E=cmd; 
       PREPARE stmt FROM @E; 
          EXECUTE stmt;  
          DEALLOCATE PREPARE stmt;  
    END IF;
  UNTIL done END REPEAT;
  CLOSE tb_name;
  SET FOREIGN_KEY_CHECKS = 1;
END;

call clear_DB('rpms');
DROP PROCEDURE IF EXISTS clear_DB;