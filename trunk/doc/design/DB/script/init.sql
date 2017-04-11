/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : rpms_using

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2014-11-16 12:57:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for adr
-- ----------------------------
DROP TABLE IF EXISTS `adr`;
CREATE TABLE `adr` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ANIMAL` bigint(20) DEFAULT NULL COMMENT '过敏的动物',
  `TYPE` tinyint(4) DEFAULT NULL COMMENT '食物过敏/药物过敏',
  `NAME` varchar(50) DEFAULT NULL COMMENT '引发不良反应的物品名称',
  `DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '过敏反应说明',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '最后修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `FK_adr_animal` (`ANIMAL`),
  KEY `FK_adr_create_user` (`CREATE_USER`),
  KEY `FK_adr_update_user` (`UPDATE_USER`),
  CONSTRAINT `adr_ibfk_1` FOREIGN KEY (`ANIMAL`) REFERENCES `animal` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `adr_ibfk_2` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `adr_ibfk_3` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='不良反应记录';

-- ----------------------------
-- Records of adr
-- ----------------------------

-- ----------------------------
-- Table structure for anatomy
-- ----------------------------
DROP TABLE IF EXISTS `anatomy`;
CREATE TABLE `anatomy` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ANIMAL` bigint(20) DEFAULT NULL COMMENT '被剖检的动物',
  `VETERINARIAN` varchar(50) DEFAULT NULL COMMENT '医生',
  `REASON` varchar(300) DEFAULT NULL COMMENT '原因',
  `PROCESS` varchar(500) DEFAULT NULL COMMENT '过程描述',
  `RESULT` varchar(300) DEFAULT NULL COMMENT '结果情况描述',
  `DO_TIME` datetime DEFAULT NULL COMMENT '剖检日期',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `FK_anatomy_animal` (`ANIMAL`),
  KEY `FK_anatomy_create_user` (`CREATE_USER`),
  KEY `FK_anatomy_update_user` (`UPDATE_USER`),
  CONSTRAINT `anatomy_ibfk_1` FOREIGN KEY (`ANIMAL`) REFERENCES `animal` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `anatomy_ibfk_2` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `anatomy_ibfk_3` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='剖检信息';

-- ----------------------------
-- Records of anatomy
-- ----------------------------

-- ----------------------------
-- Table structure for anatomy_atta
-- ----------------------------
DROP TABLE IF EXISTS `anatomy_atta`;
CREATE TABLE `anatomy_atta` (
  `ANATOMY` bigint(20) NOT NULL COMMENT '剖检记录id',
  `ATTA` bigint(20) NOT NULL COMMENT '附件id',
  PRIMARY KEY (`ANATOMY`,`ATTA`),
  KEY `FK_anatomy_atta_attachment` (`ATTA`),
  CONSTRAINT `anatomy_atta_ibfk_1` FOREIGN KEY (`ANATOMY`) REFERENCES `anatomy` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `anatomy_atta_ibfk_2` FOREIGN KEY (`ATTA`) REFERENCES `atta` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='剖检信息附带的附件信息，一次剖检记录可对应多个附件';

-- ----------------------------
-- Records of anatomy_atta
-- ----------------------------

-- ----------------------------
-- Table structure for animal
-- ----------------------------
DROP TABLE IF EXISTS `animal`;
CREATE TABLE `animal` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `MICROCHIP_CODE` varchar(50) DEFAULT NULL COMMENT '电子芯片号（非空）',
  `TATOO_CODE` varchar(50) DEFAULT NULL COMMENT '刺青编号',
  `STUDBOOK_CODE` varchar(50) DEFAULT NULL COMMENT '谱系号',
  `EAR_CODE` varchar(50) DEFAULT NULL COMMENT '耳号',
  `LIP_CODE` varchar(50) DEFAULT NULL COMMENT '唇号',
  `NAME` varchar(50) DEFAULT NULL COMMENT '呼名',
  `SEX` bit(1) DEFAULT NULL COMMENT '0：女，1：男',
  `AGE` int(11) DEFAULT NULL COMMENT '年龄',
  `FATHER` bigint(20) DEFAULT NULL COMMENT '父亲',
  `MOTHER` bigint(20) DEFAULT NULL COMMENT '母亲',
  `BIRTH_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '出生日期',
  `COME_FROM` varchar(100) DEFAULT NULL COMMENT '从哪儿来（从外部园区来的需要记录）',
  `HOUSE` bigint(20) DEFAULT NULL COMMENT '当前所在的圈舍',
  `PHOTO` bigint(20) DEFAULT NULL COMMENT '最近的一张照片或指定照片',
  `STATUS` tinyint(4) DEFAULT NULL COMMENT '状态（是否在养、死亡、删除、转出等）',
  `TYPE` bigint(20) DEFAULT NULL COMMENT '动物类型',
  `CHIP_TIME` datetime DEFAULT NULL COMMENT '电子芯片植入日期',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '记录人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间（入库时间）',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '最后修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `REMARK` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_animal_create_user` (`CREATE_USER`),
  KEY `FK_animal_cureent_house` (`HOUSE`),
  KEY `FK_animal_current_photo` (`PHOTO`),
  KEY `FK_animal_father` (`FATHER`),
  KEY `FK_animal_mother` (`MOTHER`),
  KEY `FK_animal_type` (`TYPE`),
  KEY `FK_animal_update_user` (`UPDATE_USER`),
  CONSTRAINT `animal_ibfk_1` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `animal_ibfk_2` FOREIGN KEY (`HOUSE`) REFERENCES `house` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `animal_ibfk_3` FOREIGN KEY (`PHOTO`) REFERENCES `atta` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `animal_ibfk_4` FOREIGN KEY (`FATHER`) REFERENCES `animal` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `animal_ibfk_5` FOREIGN KEY (`MOTHER`) REFERENCES `animal` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `animal_ibfk_6` FOREIGN KEY (`TYPE`) REFERENCES `animal_type` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `animal_ibfk_7` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='动物';

-- ----------------------------
-- Records of animal
-- ----------------------------

-- ----------------------------
-- Table structure for animal_atta
-- ----------------------------
DROP TABLE IF EXISTS `animal_atta`;
CREATE TABLE `animal_atta` (
  `ANIMAL` bigint(20) NOT NULL COMMENT '动物id',
  `ATTA` bigint(20) NOT NULL COMMENT '附件id',
  PRIMARY KEY (`ANIMAL`,`ATTA`),
  KEY `FK_animal_atta_attachment` (`ATTA`),
  CONSTRAINT `animal_atta_ibfk_1` FOREIGN KEY (`ATTA`) REFERENCES `atta` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `animal_atta_ibfk_2` FOREIGN KEY (`ANIMAL`) REFERENCES `animal` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='动物附件';

-- ----------------------------
-- Records of animal_atta
-- ----------------------------

-- ----------------------------
-- Table structure for animal_feed
-- ----------------------------
DROP TABLE IF EXISTS `animal_feed`;
CREATE TABLE `animal_feed` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ANIMAL` bigint(20) DEFAULT NULL COMMENT '动物',
  `FEED` bigint(20) DEFAULT NULL COMMENT '食料',
  `COUNT` int(11) DEFAULT NULL COMMENT '喂养数量',
  `FEED_TIME` datetime DEFAULT NULL COMMENT '喂养时间',
  `FEED_USER` bigint(20) DEFAULT NULL COMMENT '喂养人',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '记录人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '记录时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '最后修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`ID`),
  KEY `FK_rel_animal_feed_animal` (`ANIMAL`),
  KEY `FK_rel_animal_feed_create_user` (`CREATE_USER`),
  KEY `FK_rel_animal_feed_feed` (`FEED`),
  KEY `FK_rel_animal_feed_feed_user` (`FEED_USER`),
  KEY `FK_rel_animal_feed_update_user` (`UPDATE_USER`),
  CONSTRAINT `animal_feed_ibfk_1` FOREIGN KEY (`ANIMAL`) REFERENCES `animal` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `animal_feed_ibfk_2` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `animal_feed_ibfk_3` FOREIGN KEY (`FEED`) REFERENCES `feed` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `animal_feed_ibfk_4` FOREIGN KEY (`FEED_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `animal_feed_ibfk_5` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='喂养记录';

-- ----------------------------
-- Records of animal_feed
-- ----------------------------

-- ----------------------------
-- Table structure for animal_genotype
-- ----------------------------
DROP TABLE IF EXISTS `animal_genotype`;
CREATE TABLE `animal_genotype` (
  `ANIMAL` bigint(20) NOT NULL COMMENT '动物',
  `GENOTYPE_A` bigint(20) NOT NULL DEFAULT '0' COMMENT '基因型',
  `GENOTYPE_B` bigint(20) NOT NULL DEFAULT '0',
  `PRIMER` bigint(20) NOT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ANIMAL`,`GENOTYPE_A`,`GENOTYPE_B`,`PRIMER`),
  KEY `GENOTYPE_A` (`GENOTYPE_A`),
  KEY `GENOTYPE_B` (`GENOTYPE_B`),
  KEY `PRIMER` (`PRIMER`),
  CONSTRAINT `animal_genotype_ibfk_1` FOREIGN KEY (`ANIMAL`) REFERENCES `animal` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `animal_genotype_ibfk_2` FOREIGN KEY (`GENOTYPE_A`) REFERENCES `genotype` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `animal_genotype_ibfk_3` FOREIGN KEY (`GENOTYPE_B`) REFERENCES `genotype` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `animal_genotype_ibfk_4` FOREIGN KEY (`PRIMER`) REFERENCES `primer` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='动物基因型';

-- ----------------------------
-- Records of animal_genotype
-- ----------------------------

-- ----------------------------
-- Table structure for animal_type
-- ----------------------------
DROP TABLE IF EXISTS `animal_type`;
CREATE TABLE `animal_type` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) DEFAULT NULL COMMENT '类型名称',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `FK_animal_type_create_user` (`CREATE_USER`),
  KEY `FK_animal_type_update_user` (`UPDATE_USER`),
  CONSTRAINT `animal_type_ibfk_1` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`),
  CONSTRAINT `animal_type_ibfk_2` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='动物类型';

-- ----------------------------
-- Records of animal_type
-- ----------------------------
INSERT INTO `animal_type` VALUES ('1', '小熊猫', '1', '2014-11-16 10:42:48', null, null, null);
INSERT INTO `animal_type` VALUES ('2', '丹顶鹤', '1', '2014-11-16 12:54:29', null, null, null);

-- ----------------------------
-- Table structure for anti_epidemic
-- ----------------------------
DROP TABLE IF EXISTS `anti_epidemic`;
CREATE TABLE `anti_epidemic` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ANIMAL` bigint(20) DEFAULT NULL COMMENT '动物',
  `HOSPITAL` varchar(50) DEFAULT NULL COMMENT '医院',
  `VETERINARIAN` varchar(50) DEFAULT NULL COMMENT '医生',
  `DRUG` varchar(100) DEFAULT NULL COMMENT '药片',
  `DOSAGE` varchar(50) DEFAULT NULL COMMENT '剂量',
  `DO_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '接种日期',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '记录人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '记录时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '最后修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '补充说明',
  PRIMARY KEY (`ID`),
  KEY `FK_anti_epidemic_animal` (`ANIMAL`),
  KEY `FK_anti_epidemic_create_user` (`CREATE_USER`),
  KEY `FK_anti_epidemic_update_user` (`UPDATE_USER`),
  CONSTRAINT `anti_epidemic_ibfk_1` FOREIGN KEY (`ANIMAL`) REFERENCES `animal` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `anti_epidemic_ibfk_2` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `anti_epidemic_ibfk_3` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='防疫信息';

-- ----------------------------
-- Records of anti_epidemic
-- ----------------------------

-- ----------------------------
-- Table structure for atta
-- ----------------------------
DROP TABLE IF EXISTS `atta`;
CREATE TABLE `atta` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) DEFAULT NULL COMMENT '附件显示名称',
  `FILE_NAME` varchar(100) DEFAULT NULL COMMENT '附件存储的名称',
  `PATH` varchar(300) DEFAULT NULL COMMENT '附件存储相对路径',
  `SIZE` bigint(20) DEFAULT NULL COMMENT '附件大小',
  `TYPE` tinyint(4) DEFAULT NULL COMMENT '附件类型：0-图片，1-视频，2-音频，3-文档',
  `DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '附件说明及描述',
  `UPLOAD_USER` bigint(20) DEFAULT NULL COMMENT '上传人',
  `UPLOAD_TIME` datetime DEFAULT NULL COMMENT '上传时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '最后修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `FK_atta_update_user` (`UPDATE_USER`),
  KEY `FK_atta_upload_user` (`UPLOAD_USER`),
  CONSTRAINT `atta_ibfk_1` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `atta_ibfk_2` FOREIGN KEY (`UPLOAD_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件管理';

-- ----------------------------
-- Records of atta
-- ----------------------------

-- ----------------------------
-- Table structure for examination
-- ----------------------------
DROP TABLE IF EXISTS `examination`;
CREATE TABLE `examination` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ANIMAL` bigint(20) DEFAULT NULL COMMENT '动物',
  `WEIGHT` float(10,2) DEFAULT NULL COMMENT '体重',
  `COUTOUR_LENGTH` float(10,2) DEFAULT NULL COMMENT '吻长（从鼻尖到头顶）',
  `BODY_LENGTH` float(10,2) DEFAULT NULL COMMENT '体长（从头顶到尾跟）',
  `EAR_LENGTH` float(10,2) DEFAULT NULL COMMENT '耳长',
  `TAIL_LENGTH` float(10,2) DEFAULT NULL COMMENT '尾长',
  `NECK_GIRTH` float(10,2) DEFAULT NULL COMMENT '颈围',
  `CHEST_GIRTH` float(10,2) DEFAULT NULL COMMENT '胸围',
  `ABDOMINAL_GIRTH` float(10,2) DEFAULT NULL COMMENT '腹围',
  `LEFT_FRONT_LEG_LENGTH` float(10,2) DEFAULT NULL COMMENT '左前肢（从大腿根到脚踝）',
  `LEFT_BACK_LEG_LENGTH` float(10,2) DEFAULT NULL COMMENT '左后肢长度（从大腿根到脚踝）',
  `TEMPERATURE` float(10,2) DEFAULT NULL COMMENT '体温',
  `EXAM_USER` varchar(50) DEFAULT NULL COMMENT '体检医生',
  `EXAM_TIME` datetime DEFAULT NULL COMMENT '体检时间',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '记录人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '记录时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '最后修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `FK_examination_animal` (`ANIMAL`),
  KEY `FK_examination_create_user` (`CREATE_USER`),
  KEY `FK_examination_update_user` (`UPDATE_USER`),
  CONSTRAINT `examination_ibfk_1` FOREIGN KEY (`ANIMAL`) REFERENCES `animal` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `examination_ibfk_2` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `examination_ibfk_3` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='体检信息';

-- ----------------------------
-- Records of examination
-- ----------------------------

-- ----------------------------
-- Table structure for examination_atta
-- ----------------------------
DROP TABLE IF EXISTS `examination_atta`;
CREATE TABLE `examination_atta` (
  `EXAMINATION` bigint(20) NOT NULL COMMENT '体检记录id',
  `ATTA` bigint(20) NOT NULL COMMENT '附件id',
  `TYPE` tinyint(4) DEFAULT NULL COMMENT '附件类型：0-外观情况，1-受伤情况',
  PRIMARY KEY (`EXAMINATION`,`ATTA`),
  KEY `FK_examination_atta_attachment` (`ATTA`),
  CONSTRAINT `examination_atta_ibfk_1` FOREIGN KEY (`ATTA`) REFERENCES `atta` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `examination_atta_ibfk_2` FOREIGN KEY (`EXAMINATION`) REFERENCES `examination` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='体检信息附带的附件信息，一次体检记录可对应多个附件';

-- ----------------------------
-- Records of examination_atta
-- ----------------------------

-- ----------------------------
-- Table structure for feed
-- ----------------------------
DROP TABLE IF EXISTS `feed`;
CREATE TABLE `feed` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL COMMENT '食物名称',
  `UNIT` varchar(50) DEFAULT NULL COMMENT '食物单位',
  `TYPE` bigint(20) DEFAULT NULL COMMENT '种类',
  `SOURCE` varchar(300) DEFAULT NULL COMMENT '来源',
  `COUNT` int(11) DEFAULT NULL COMMENT '库存数量',
  `DESCRIPTION` varchar(1000) DEFAULT NULL COMMENT '食物描述',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '备注',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '最后修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`ID`),
  KEY `FK_feed_create_user` (`CREATE_USER`),
  KEY `FK_feed_type` (`TYPE`),
  KEY `FK_feed_update_user` (`UPDATE_USER`),
  CONSTRAINT `feed_ibfk_1` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `feed_ibfk_2` FOREIGN KEY (`TYPE`) REFERENCES `feed_type` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `feed_ibfk_3` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='食料表';

-- ----------------------------
-- Records of feed
-- ----------------------------

-- ----------------------------
-- Table structure for feed_atta
-- ----------------------------
DROP TABLE IF EXISTS `feed_atta`;
CREATE TABLE `feed_atta` (
  `FEED` bigint(20) NOT NULL COMMENT '食料',
  `ATTA` bigint(20) NOT NULL COMMENT '附件',
  PRIMARY KEY (`FEED`,`ATTA`),
  KEY `FK_feed_atta_attachment` (`ATTA`),
  CONSTRAINT `feed_atta_ibfk_1` FOREIGN KEY (`ATTA`) REFERENCES `atta` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `feed_atta_ibfk_2` FOREIGN KEY (`FEED`) REFERENCES `feed` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='食料附件';

-- ----------------------------
-- Records of feed_atta
-- ----------------------------

-- ----------------------------
-- Table structure for feed_type
-- ----------------------------
DROP TABLE IF EXISTS `feed_type`;
CREATE TABLE `feed_type` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL,
  `DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '种类描述',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='食料种类';

-- ----------------------------
-- Records of feed_type
-- ----------------------------

-- ----------------------------
-- Table structure for genotype
-- ----------------------------
DROP TABLE IF EXISTS `genotype`;
CREATE TABLE `genotype` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PRIMER` bigint(20) NOT NULL COMMENT '引物id',
  `CODE_A` int(11) DEFAULT NULL COMMENT 'a引物号',
  `CODE_B` int(11) DEFAULT NULL COMMENT 'b引物号',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `FK_genotype_create_user` (`CREATE_USER`),
  KEY `FK_genotype_primer` (`PRIMER`),
  KEY `FK_genotype_update_user` (`UPDATE_USER`),
  CONSTRAINT `genotype_ibfk_1` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `genotype_ibfk_2` FOREIGN KEY (`PRIMER`) REFERENCES `primer` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `genotype_ibfk_3` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='基因型';

-- ----------------------------
-- Records of genotype
-- ----------------------------

-- ----------------------------
-- Table structure for house
-- ----------------------------
DROP TABLE IF EXISTS `house`;
CREATE TABLE `house` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NUMER` varchar(50) DEFAULT NULL COMMENT '圈舍编号',
  `NAME` varchar(50) DEFAULT NULL COMMENT '圈舍名称',
  `LOCATION` varchar(200) DEFAULT NULL COMMENT '圈舍位置',
  `ZOO` varchar(100) DEFAULT NULL COMMENT '所属动物园',
  `DESCRIPTION` varchar(500) DEFAULT NULL COMMENT '说明',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '最后修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `FK_house_create_user` (`CREATE_USER`),
  KEY `FK_house_update_user` (`UPDATE_USER`),
  CONSTRAINT `house_ibfk_1` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `house_ibfk_2` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圈舍';

-- ----------------------------
-- Records of house
-- ----------------------------

-- ----------------------------
-- Table structure for house_transfer
-- ----------------------------
DROP TABLE IF EXISTS `house_transfer`;
CREATE TABLE `house_transfer` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ANIMAL` bigint(20) DEFAULT NULL COMMENT '动物',
  `ZOO` varchar(200) DEFAULT NULL COMMENT '来源或去向（从其他动物园园区转入或转到其他动物园园区）',
  `DEST_HOUSE` bigint(20) DEFAULT NULL COMMENT '去向圈舍',
  `SRC_HOUSE` bigint(20) DEFAULT NULL COMMENT '来源圈舍',
  `TRANS_TARGET` tinyint(4) DEFAULT NULL COMMENT '转移目标：0-本园区，1-其他园区',
  `TRANS_TYPE` int(11) DEFAULT NULL COMMENT '转移类型：0-转出，1-转入',
  `TRANS_TIME` datetime DEFAULT NULL COMMENT '转入或转出时间',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '记录人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '记录时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `REMARK` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_house_transfer_animal` (`ANIMAL`),
  KEY `FK_house_transfer_create_user` (`CREATE_USER`),
  KEY `FK_house_transfer_dest_house` (`DEST_HOUSE`),
  KEY `FK_house_transfer_src_house` (`SRC_HOUSE`),
  KEY `FK_house_transfer_update_user` (`UPDATE_USER`),
  CONSTRAINT `house_transfer_ibfk_1` FOREIGN KEY (`ANIMAL`) REFERENCES `animal` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `house_transfer_ibfk_2` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `house_transfer_ibfk_3` FOREIGN KEY (`DEST_HOUSE`) REFERENCES `house` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `house_transfer_ibfk_4` FOREIGN KEY (`SRC_HOUSE`) REFERENCES `house` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `house_transfer_ibfk_5` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圈舍转移信息，转出转入的去向和来源手动录入';

-- ----------------------------
-- Records of house_transfer
-- ----------------------------

-- ----------------------------
-- Table structure for medical
-- ----------------------------
DROP TABLE IF EXISTS `medical`;
CREATE TABLE `medical` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ANIMAL` bigint(20) DEFAULT NULL COMMENT '动物',
  `HOSPITAL` varchar(50) DEFAULT NULL COMMENT '医院',
  `VETERINARIAN` varchar(50) DEFAULT NULL COMMENT '医生',
  `DIAGNOSIS` varchar(500) DEFAULT NULL COMMENT '诊断说明',
  `MEDICINE` varchar(500) DEFAULT NULL COMMENT '用药说明',
  `DO_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '诊断日期',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '记录人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '记录时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `REMARK` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_medical_animal` (`ANIMAL`),
  CONSTRAINT `medical_ibfk_1` FOREIGN KEY (`ANIMAL`) REFERENCES `animal` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='医疗记录';

-- ----------------------------
-- Records of medical
-- ----------------------------

-- ----------------------------
-- Table structure for primer
-- ----------------------------
DROP TABLE IF EXISTS `primer`;
CREATE TABLE `primer` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NO` varchar(100) NOT NULL COMMENT '编号',
  `CREATE_USER` bigint(20) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_USER` bigint(20) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `REMARK` varchar(300) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`),
  KEY `FK_primer_create_user` (`CREATE_USER`),
  KEY `FK_primer_update_user` (`UPDATE_USER`),
  CONSTRAINT `primer_ibfk_1` FOREIGN KEY (`CREATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL,
  CONSTRAINT `primer_ibfk_2` FOREIGN KEY (`UPDATE_USER`) REFERENCES `user` (`ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='引物表';

-- ----------------------------
-- Records of primer
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(50) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'ROLE_SUPER_MANAGER', '超级管理员');
INSERT INTO `role` VALUES ('2', 'ROLE_MANAGER', '系统管理员');
INSERT INTO `role` VALUES ('3', 'ROLE_FEEDER', '饲养员');
INSERT INTO `role` VALUES ('4', 'ROLE_CODE_CARE_USER', '医护人员');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `TRUE_NAME` varchar(50) DEFAULT NULL,
  `SEX` bit(1) DEFAULT NULL,
  `AGE` int(11) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `REMARK` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  UNIQUE KEY `NAME` (`NAME`),
  UNIQUE KEY `NAME_2` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', '', null, '2014-11-16 12:55:02', '1', '');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `ROLE` bigint(20) NOT NULL,
  `USER` bigint(20) NOT NULL,
  PRIMARY KEY (`ROLE`,`USER`),
  KEY `FK_rel_user_role_user` (`USER`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`USER`) REFERENCES `user` (`ID`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`ROLE`) REFERENCES `role` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关系表';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1');
