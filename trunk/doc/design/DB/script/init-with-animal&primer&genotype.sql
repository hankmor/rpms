/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50610
Source Host           : localhost:3306
Source Database       : rpms

Target Server Type    : MYSQL
Target Server Version : 50610
File Encoding         : 65001

Date: 2014-11-20 15:15:32
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
  `BIRTH_DATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '出生日期',
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
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8 COMMENT='动物';

-- ----------------------------
-- Records of animal
-- ----------------------------
INSERT INTO `animal` VALUES ('1', 'AVID-076-597-018', '001', '', '0611', '', '', '', null, null, null, '2002-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('2', 'AVID-076-618-891', '002', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('3', 'AVID-076-563-341', '003', '', '', '', '', '\0', null, null, null, NULL, null, null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('4', 'AVID-076-565-516', '004', '', '', '', '', '', null, null, null, '2002-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('5', 'AVID-076-612-375', '005', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('6', 'AVID-076-597-793', '006', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('7', 'AVID-076-587-001', '007', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('8', 'AVID-076-572-818', '008', '', '', '', '', '', null, null, null, '2008-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('9', 'AVID-076-563-260', '009', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('10', 'AVID-076-600-873', '010', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('11', 'AVID-076-619-564', '011', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('12', 'AVID-076-580-107', '012', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('13', 'AVID-078-596-305', '013', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('14', 'AVID-076-585-521', '014', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('15', 'AVID-076-582-030', '015', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('16', 'AVID-076-587-889', '016', '', '', '', '', '', null, null, null, '2008-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('17', 'AVID-076-564-287', '017', '', '', '', '', '', null, null, null, '2008-01-01 00:00:00', '', null, null, '-2', '1', null, '1', '2014-11-20 11:15:03', null, null, '于2013年2月25日晚死亡，死亡原因：疾病，具体不明，肾脏出血水肿。');
INSERT INTO `animal` VALUES ('18', 'AVID-076-601-597', '018', '', '', '', '', '', null, null, null, '2009-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('19', 'AVID-076-567-348', '019', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('20', 'AVID-076-564-590', '020', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('21', 'AVID-076-602-077', '021', '', '', '', '', '', null, null, null, '2007-01-01 00:00:00', '西昌', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('22', 'AVID-076-572-014', '022', '', '', '', '一号大公子', '', null, null, null, '2004-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('23', 'AVID-076-564-810', '023', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '-2', '1', null, '1', '2014-11-20 11:15:03', null, null, '尾巴中间用刺青染料染了一圈；耳朵出血受伤；于2013年12月23日死亡，死亡原因：严重营养不良引起器官衰竭，左侧膀胱处有一个2*1.5cm的坏死组织，左肾已病变坏死');
INSERT INTO `animal` VALUES ('24', 'AVID-076-602-591', '024', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('25', 'AVID-076-786-309', '025', '', '', '', '花鼻子', '', null, null, null, '2005-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('26', 'AVID-076-566-596', '026', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('27', 'AVID-076-606-846', '027', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('28', 'AVID-076-600-354', '028', '', '', '', '', '', null, null, null, '2004-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('29', 'AVID-076-579-315', '029', '', '', '', '', '', null, null, null, '2006-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('30', 'AVID-076-572-307', '030', '', '', '', '', '', null, null, null, '2011-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('31', 'AVID-076-592-037', '031', '', '', '', '', '', null, null, null, '2011-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('32', 'AVID-076-582-846', '032', '', '', '', '', '', null, null, null, '2005-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('33', 'AVID-076-613-012', '033', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('34', 'AVID-076-567-289', '034', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('35', 'AVID-076-589-818', '035', '', '', '', '', '', null, null, null, '2003-01-01 00:00:00', '南充', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('36', 'AVID-076-602-777', '036', '', '', '', '', '', null, null, null, '2005-01-01 00:00:00', '南充', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('37', 'AVID-076-591-797', '037', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('38', 'AVID-076-611-343', '038', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('39', 'AVID-076-609-548', '039', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('40', 'AVID-076-616-368', '040', '', '', '', '', '', null, null, null, '2011-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('41', 'AVID-076-585-043', '041', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('42', 'AVID-076-619-780', '042', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('43', 'AVID-076-580-530', '043', '', '', '', '', '', null, null, null, '2011-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('44', 'AVID-076-618-895', '044', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('45', 'AVID-076-612-601', '045', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('46', 'AVID-076-595-541', '046', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('47', 'AVID-076-582-531', '047', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('48', 'AVID-076-596-630', '048', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('49', 'AVID-076-587-093', '049', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('50', 'AVID-076-585-114', '050', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('51', 'AVID-076-585-109', '051', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('52', 'AVID-076-606-520', '052', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('53', 'AVID-076-563-622', '053', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('54', '', '054', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '-2', '1', null, '1', '2014-11-20 11:15:03', null, null, '于2013年3月6号死亡，死亡原因：老死。');
INSERT INTO `animal` VALUES ('55', 'AVID-076-609-116', '055', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('56', 'AVID-076-599-633', '056', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('57', 'AVID-076-564-880', '057', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('58', 'AVID-076-596-300', '058', '', '', '', '', '', null, null, null, '2012-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('59', 'AVID-076-617-824', '059', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('60', 'AVID-076-618-023', '060', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('61', 'AVID-076-580-115', '061', '', '', '', '', '', null, null, null, '2012-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('62', 'AVID-076-589-074', '062', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('63', 'AVID-076-608-028', '063', '', '', '', '', '', null, null, null, '2012-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('64', 'AVID-076-612-345', '064', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('65', 'AVID-076-581-265', '065', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('66', 'AVID-076-574-369', '066', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('67', 'AVID-076-611-788', '067', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('68', 'AVID-076-588-049', '068', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('69', 'AVID-076-615-572', '069', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('70', 'AVID-076-595-875', '070', '', '', '', '', '', null, null, null, '2012-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('71', 'AVID-076-569-877', '071', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('72', 'AVID-076-606-576', '072', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('73', '', '073', '', '', '', '', '', null, null, null, '2012-01-01 00:00:00', '', null, null, '-2', '1', null, '1', '2014-11-20 11:15:03', null, null, '已死亡，死亡原因：生病，胃里有很多毛。');
INSERT INTO `animal` VALUES ('74', '', '074', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('75', '', '075', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('76', 'AVID-076-617-574', '076', '', '', '', '小红', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('77', 'AVID-076-606-258', '077', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('78', 'AVID-076-564-346', '078', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('79', 'AVID-076-567-595', '079', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('80', 'AVID-076-578-831', '080', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('81', 'AVID-076-617-784', '081', '', '', '', '小五', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('82', 'AVID-076-592-592', '082', '', '', '', '小四', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('83', 'AVID-076-579-023', '083', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('84', 'AVID-076-572-893', '084', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('85', 'AVID-076-614-076', '085', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('86', 'AVID-076-575-323', '086', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('87', 'AVID-076-569-829', '087', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('88', 'AVID-076-595-572', '088', '', '', '', '小野', '', null, null, null, '2013-01-01 00:00:00', '野外', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('89', 'AVID-076-601-570', '089', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('90', 'AVID-076-616-318', '090', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('91', 'AVID-076-596-594', '091', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('92', 'AVID-076-574-013', '092', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('93', 'AVID-076-591-072', '093', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('94', 'AVID-076-570-830', '094', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('95', 'AVID-076-586-789', '095', '', '', '', '小七', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('96', 'AVID-076-566-608', '096', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('97', 'AVID-076-594-085', '097', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('98', 'AVID-076-619-259', '098', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('99', 'AVID-076-601-070', '099', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('100', 'AVID-076-581-847', '100', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('101', 'AVID-076-615-779', '101', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('102', 'AVID-076-615-280', '102', '', '', '', '', '', null, null, null, '2013-01-01 00:00:00', '', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('103', 'AVID-076-584-004', '103', '', '', '', '', '', null, null, null, null, '冕宁野外', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('104', 'AVID-076-610-108', '104', '', '', '', '', '\0', null, null, null, NULL, '冕宁野外', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('105', 'AVID-076-608-588', '105', '', '', '', '', '\0', null, null, null, NULL, '冕宁野外', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('106', 'AVID-076-603-007', '106', '', '', '', '', '\0', null, null, null, NULL, '冕宁野外', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('107', 'AVID-076-563-581', '107', '', '', '', '', '\0', null, null, null, NULL, '冕宁野外', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('108', 'AVID-076-606-805', '108', '', '', '', '', '\0', null, null, null, NULL, '冕宁野外', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('109', 'AVID-076-617-880', '109', '', '', '', '', '\0', null, null, null, NULL, '冕宁野外', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('110', 'AVID-076-588-529', '110', '', '', '', '', '\0', null, null, null, NULL, '冕宁野外', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('111', '', '111', '', '', '', '', '\0', null, null, null, NULL, '', null, null, '-2', '1', null, '1', '2014-11-20 11:15:03', null, null, '2014.3.18死亡，死亡原因：严重营养不良，心脏病。死亡大概在17日晚，从关节钙化程度看，年龄大概1~2岁；体型消瘦，其心脏左心房异常小（发育不正常），心包有少量积液；其他脏器正常');
INSERT INTO `animal` VALUES ('112', 'AVID-076-616-833', '112', '', '', '', '', '', null, null, null, null, '简阳', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('113', 'AVID-076-592-865', '113', '', '', '', '', '', null, null, null, null, '简阳', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');
INSERT INTO `animal` VALUES ('114', 'AVID-076-589-573', '114', '', '', '', '', '\0', null, null, null, NULL, '简阳', null, null, '1', '1', null, '1', '2014-11-20 11:15:03', null, null, '');

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
INSERT INTO `animal_genotype` VALUES ('1', '1', '2', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '5', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '7', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '9', '9', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '13', '13', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '15', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '28', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '30', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '32', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '34', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '47', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '53', '53', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '56', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('1', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '27', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '32', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '40', '85', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '55', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '56', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '61', '134', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '108', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '112', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '123', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '131', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '132', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '159', '11', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '167', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '168', '180', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '169', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('2', '171', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '15', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '78', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '96', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '130', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '132', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '137', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '152', '66', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '155', '81', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '161', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('3', '169', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '23', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '28', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '55', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '56', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '63', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '75', '126', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '91', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '123', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '125', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '129', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '131', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '132', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('4', '134', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '2', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '6', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '7', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '15', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '78', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '96', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '120', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '130', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '132', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '153', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('5', '155', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '1', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '5', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '7', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '18', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '29', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '32', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '54', '93', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '60', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '61', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '107', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '115', '156', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '120', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '130', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '142', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '163', '13', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('6', '164', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '2', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '5', '123', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '7', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '9', '135', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '28', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '31', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '33', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '39', '39', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '45', '112', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '47', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '53', '169', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '93', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '94', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '130', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('7', '142', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '1', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '3', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '7', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '10', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '11', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '15', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '80', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '96', '157', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '130', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '132', '156', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '152', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '153', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('8', '155', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '6', '162', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '15', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '27', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '29', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '31', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '33', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '46', '165', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '53', '53', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '60', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '62', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '117', '117', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '146', '146', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '156', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '161', '2', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('9', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '3', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '9', '140', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '15', '74', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '24', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '43', '43', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '53', '53', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '59', '95', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '63', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '66', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '71', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '72', '72', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '80', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '96', '150', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '101', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '111', '145', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '112', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '141', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '144', '81', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '146', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '148', '148', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '149', '149', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('10', '151', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '25', '177', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '60', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '91', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '106', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '108', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '113', '165', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '123', '162', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '134', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '153', '9', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '159', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '161', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '163', '163', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('11', '179', '180', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '2', '99', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '6', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '7', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '9', '9', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '56', '56', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '96', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '130', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '131', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '132', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '134', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '155', '81', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('12', '181', '45', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '1', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '3', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '55', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '56', '56', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '123', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '129', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '132', '132', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '153', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '155', '81', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('13', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '2', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '6', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '12', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '18', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '25', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '32', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '45', '112', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '53', '169', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '56', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '62', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '78', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '80', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '81', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '88', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '115', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '124', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '130', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('14', '157', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '1', '2', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '9', '135', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '12', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '13', '13', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '15', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '28', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '30', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '33', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '47', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '51', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '53', '169', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '78', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '93', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '94', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '112', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '123', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '129', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('15', '142', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '1', '2', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '6', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '7', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '11', '11', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '25', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '29', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '33', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '47', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '53', '169', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '78', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '81', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '112', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '115', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '130', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('16', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '11', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '17', '126', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '61', '134', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '91', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '100', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '106', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '118', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '131', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '132', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '161', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('17', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '5', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '10', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '33', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '45', '45', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '51', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '53', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '54', '93', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '80', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '81', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '96', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '117', '117', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '122', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '130', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '134', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('18', '159', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '1', '2', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '6', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '7', '7', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '9', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '15', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '25', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '33', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '51', '116', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '56', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '80', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '108', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '112', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '118', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '130', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('19', '138', '138', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '2', '99', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '6', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '7', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '9', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '20', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '33', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '56', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '61', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '80', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '86', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '96', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '106', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '107', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '108', '81', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '112', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '115', '116', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '118', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('20', '120', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '2', '171', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '3', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '13', '72', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '16', '74', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '17', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '24', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '30', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '32', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '50', '175', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '66', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '80', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '85', '145', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '112', '112', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '134', '134', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '137', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '141', '141', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '146', '146', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '149', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '154', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '172', '173', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('21', '174', '174', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '24', '177', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '30', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '46', '165', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '86', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '97', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '121', '98', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '152', '162', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '153', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '156', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '161', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '178', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('22', '179', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '17', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '61', '134', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '80', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '81', '81', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '101', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '106', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '107', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '112', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '115', '132', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '118', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '123', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '130', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '131', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '161', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('23', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '2', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '6', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '7', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '9', '9', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '20', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '32', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '34', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '50', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '56', '56', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '78', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '88', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '130', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('24', '134', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '3', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '17', '126', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '28', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '55', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '56', '56', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '66', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '107', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '115', '132', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '124', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('25', '161', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '9', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '17', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '20', '20', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '33', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '61', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '63', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '80', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '86', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '91', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '94', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '96', '96', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '106', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '107', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '108', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '115', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '117', '117', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '118', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '123', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '159', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('26', '163', '72', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '2', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '3', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '9', '135', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '10', '158', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '17', '126', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '61', '134', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '91', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '106', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '118', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '123', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '129', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '131', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '132', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '159', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('27', '160', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '1', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '10', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '12', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '29', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '31', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '32', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '54', '93', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '62', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '117', '117', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '152', '5', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '156', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '157', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('28', '178', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '2', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '7', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '11', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '53', '53', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '65', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '66', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '80', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '107', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '115', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '130', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '137', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '155', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('29', '163', '13', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '14', '139', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '17', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '60', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '61', '134', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '80', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '101', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '107', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '112', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '115', '156', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '118', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '152', '123', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('30', '161', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '1', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '12', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '23', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '75', '126', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '80', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '103', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '123', '123', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '124', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '129', '129', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '131', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '132', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('31', '155', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '6', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '16', '74', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '25', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '30', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '32', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '62', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '79', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '96', '96', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '101', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '102', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '106', '106', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '112', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '117', '117', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '149', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '161', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '163', '72', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '175', '175', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '182', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '183', '158', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '184', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '185', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '186', '186', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '187', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('32', '188', '188', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '24', '177', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '43', '43', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '80', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '82', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '94', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '96', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '107', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '112', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '115', '156', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '121', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '124', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '152', '66', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '154', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '161', '2', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('33', '163', '72', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '1', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '10', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '32', '32', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '50', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '78', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '81', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '88', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '93', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '130', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '152', '123', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('34', '179', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '9', '190', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '12', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '13', '13', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '20', '191', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '25', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '30', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '33', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '38', '194', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '43', '186', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '50', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '66', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '79', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '86', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '90', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '92', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '131', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '149', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '176', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '183', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '189', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '192', '193', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('35', '195', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '2', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '6', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '25', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '54', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '73', '198', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '79', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '97', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '106', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '111', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '113', '165', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '120', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '131', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '137', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '138', '197', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '144', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '156', '116', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('36', '186', '186', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '2', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '5', '66', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '16', '74', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '40', '85', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '51', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '54', '93', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '58', '95', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '62', '98', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '64', '65', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '67', '68', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '69', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '71', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '72', '73', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '77', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '79', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '86', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '88', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '90', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('37', '96', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '2', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '9', '135', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '30', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '33', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '34', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '50', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '53', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '55', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '56', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '61', '61', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '78', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '106', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '112', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '123', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('38', '129', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '25', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '55', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '81', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '83', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '107', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '115', '132', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '122', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '123', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '129', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '137', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '167', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '169', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('39', '179', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '2', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '5', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '18', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '32', '32', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '46', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '47', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '51', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '78', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '80', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '120', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '130', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '155', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('40', '157', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '12', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '65', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '80', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '81', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '93', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '115', '132', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '122', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '129', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '152', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('41', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '24', '177', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '28', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '56', '56', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '83', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '113', '165', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '121', '98', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '130', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '152', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '153', '9', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '156', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '161', '2', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('42', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '1', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '3', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '5', '123', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '9', '135', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '23', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '25', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '28', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '30', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '32', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '40', '145', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '45', '112', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '51', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '53', '169', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '56', '56', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '93', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '129', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('43', '158', '158', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '14', '139', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '24', '177', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '27', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '30', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '54', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '63', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '83', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '91', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '106', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '112', '165', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '124', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '127', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '132', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '134', '98', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '152', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('44', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '1', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '7', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '73', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '123', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '124', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '129', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '131', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '132', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '155', '81', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('45', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '2', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '7', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '10', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '11', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '29', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '30', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '53', '53', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '66', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '93', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '94', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '96', '157', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '107', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '115', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('46', '130', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '1', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '7', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '11', '11', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '17', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '28', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '54', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '56', '56', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '73', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '96', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '123', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '124', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '129', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '131', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('47', '132', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '2', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '10', '138', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '17', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '30', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '32', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '56', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '67', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '88', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '112', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '118', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '123', '66', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '129', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('48', '167', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '2', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '20', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '56', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '61', '61', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '66', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '80', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '91', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '96', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '112', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '116', '116', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '118', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '131', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '159', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '167', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('49', '195', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '5', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '29', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '33', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '51', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '56', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '61', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '63', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '73', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '81', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '101', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '147', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('50', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '9', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '25', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '45', '45', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '47', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '51', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '53', '53', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '62', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '63', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '78', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '82', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '102', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '127', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '130', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '152', '66', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '155', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('51', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '10', '138', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '61', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '66', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '80', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '81', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '82', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '94', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '96', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '101', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '106', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '107', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '112', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '115', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '118', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '124', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '161', '2', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('52', '163', '72', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '2', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '7', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '10', '138', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '28', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '54', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '61', '134', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '81', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '88', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '123', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '124', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('53', '129', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '2', '99', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '6', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '10', '138', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '14', '139', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '71', '11', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '81', '81', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '86', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '94', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '101', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '106', '77', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '107', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '109', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '112', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '115', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '127', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('54', '137', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '12', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '30', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '50', '116', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '53', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '61', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '80', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '94', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '152', '66', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '161', '2', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('55', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '14', '139', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '17', '126', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '50', '116', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '53', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '55', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '61', '98', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '81', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '94', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '96', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '100', '162', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '106', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '113', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '122', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '124', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '159', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('56', '179', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '2', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '10', '138', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '17', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '24', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '29', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '33', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '38', '194', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '45', '112', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '66', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '77', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '86', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '90', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '149', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '190', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '193', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '195', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('57', '196', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '13', '72', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '14', '139', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '25', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '29', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '33', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '44', '186', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '66', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '71', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '86', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '115', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '149', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '189', '99', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '190', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '191', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '193', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('58', '195', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '1', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '9', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '17', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '28', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '30', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '50', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '66', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '78', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '86', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '92', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '101', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '131', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '149', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '183', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '193', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '195', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('59', '199', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '9', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '21', '191', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '25', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '28', '79', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '56', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '58', '58', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '63', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '66', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '78', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '90', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '92', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '101', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '131', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '132', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '133', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '146', '146', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '183', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '193', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '195', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('60', '199', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '7', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '11', '11', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '54', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '56', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '63', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '73', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '80', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '113', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '123', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '124', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '129', '129', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '131', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '132', '132', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('61', '134', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '24', '177', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '39', '39', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '46', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '60', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '80', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '82', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '91', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '106', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '117', '117', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '121', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '124', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '152', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '161', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '164', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('62', '199', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '2', '170', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '5', '123', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '10', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '20', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '28', '127', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '30', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '51', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '54', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '56', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '60', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '78', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '88', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '92', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '101', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '109', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '112', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('63', '124', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '5', '66', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '11', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '21', '191', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '25', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '27', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '29', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '38', '194', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '51', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '56', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '72', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '101', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '124', '124', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '131', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '149', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '157', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '161', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('64', '193', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '1', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '6', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '26', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '32', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '50', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '55', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '58', '59', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '73', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '113', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '124', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '126', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '130', '130', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '131', '131', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '155', '81', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('65', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '6', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '8', '8', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '9', '9', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '13', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '18', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '25', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '30', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '32', '33', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '38', '194', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '39', '39', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '44', '186', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '45', '45', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '65', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '79', '29', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '93', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '99', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '107', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '115', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '130', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '131', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '157', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '183', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '193', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '195', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('66', '199', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '13', '72', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '21', '191', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '25', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '27', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '29', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '30', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '38', '194', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '51', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '65', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '66', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '76', '76', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '99', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '102', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '130', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '131', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '149', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '157', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '190', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '193', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '195', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('67', '199', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '8', '67', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '11', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '17', '126', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '21', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '29', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '31', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '39', '39', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '43', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '54', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '73', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '82', '109', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '96', '157', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '124', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '152', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '156', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('68', '161', '63', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '1', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '10', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '12', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '13', '72', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '53', '169', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '78', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '93', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '94', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '104', '104', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '114', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '115', '115', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '117', '117', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '130', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '137', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '152', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '155', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('69', '179', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '1', '189', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '6', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '10', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '13', '13', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '18', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '21', '191', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '24', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '29', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '30', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '38', '194', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '44', '186', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '45', '46', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '50', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '62', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '86', '86', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '88', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '102', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '149', '55', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('70', '193', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '12', '12', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '13', '13', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '14', '14', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '24', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '29', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '44', '186', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '53', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '57', '94', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '66', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '88', '47', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '93', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '130', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '155', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '183', '10', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '189', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '190', '69', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '193', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '195', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('71', '196', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '3', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '8', '101', '4', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '9', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '12', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '13', '13', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '21', '191', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '25', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '29', '179', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '30', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '44', '186', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '45', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '57', '119', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '61', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '78', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '104', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '115', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '130', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '131', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '142', '142', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '149', '93', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '152', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '169', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '189', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('72', '193', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '2', '171', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '3', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '16', '74', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '30', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '33', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '41', '42', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '56', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '58', '95', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '66', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '71', '154', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '72', '73', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '76', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '80', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '83', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '91', '92', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '113', '113', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '114', '114', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '117', '90', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '130', '147', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '134', '121', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '150', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '153', '190', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '167', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '200', '200', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('73', '201', '201', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '19', '19', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '28', '80', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '31', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '46', '165', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '53', '91', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '59', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '63', '122', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '65', '3', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '69', '70', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '75', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '88', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '103', '198', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '117', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '123', '6', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '125', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '134', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '138', '197', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '147', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('74', '156', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '2', '171', '1', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '4', '4', '2', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '10', '138', '6', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '11', '102', '7', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '14', '125', '9', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '16', '16', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '32', '82', '19', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '35', '128', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '41', '41', '25', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '44', '44', '26', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '52', '52', '31', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '53', '136', '32', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '54', '133', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '57', '57', '34', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '58', '120', '35', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '79', '168', '17', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '87', '87', '24', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '100', '100', '3', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '106', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '114', '88', '28', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '124', '137', '5', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '134', '62', '37', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '144', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '156', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '163', '103', '8', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '165', '165', '27', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '195', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('75', '202', '202', '12', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('76', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('76', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('76', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('77', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('77', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('78', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('78', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('79', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('80', '31', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('81', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('81', '50', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('82', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('82', '51', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '22', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '31', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '39', '39', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '51', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '54', '54', '33', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '60', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '110', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('83', '203', '204', '10', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '20', '105', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '31', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '36', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '51', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '60', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('84', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '25', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '36', '36', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '75', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('85', '196', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('86', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('86', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('86', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('86', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('86', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('86', '50', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('86', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('86', '75', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('86', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '24', '25', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '40', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '50', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '78', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '96', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('87', '106', '22', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '40', '85', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '51', '205', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '81', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '96', '157', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('88', '187', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '20', '20', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '27', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '30', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '97', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '106', '106', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('89', '196', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '48', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '78', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '81', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '111', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '132', '156', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('90', '167', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '18', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '31', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '39', '111', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '97', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '107', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('91', '115', '156', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('92', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('92', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('92', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('92', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('92', '115', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('92', '157', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('93', '17', '75', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('93', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('93', '30', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('93', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('93', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('93', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('93', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('93', '157', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('94', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('94', '22', '167', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('94', '30', '31', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('94', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('94', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('94', '96', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('94', '115', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('95', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('95', '22', '23', '14', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('95', '35', '35', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('95', '36', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('95', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('95', '39', '40', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('95', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('95', '89', '116', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('95', '96', '157', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('96', '24', '24', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('96', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('96', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '24', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '48', '48', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '84', '173', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '107', '107', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '115', '175', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('97', '164', '206', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '25', '143', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '26', '26', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '30', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '35', '83', '20', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '40', '145', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '49', '49', '29', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '84', '173', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '132', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '157', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('98', '207', '207', '38', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('99', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('99', '25', '177', '15', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('99', '27', '27', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('99', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('99', '39', '85', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('99', '108', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('99', '132', '156', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('99', '157', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('100', '21', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('100', '38', '110', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('100', '39', '85', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('100', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('100', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('100', '84', '37', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('100', '97', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('100', '164', '164', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('100', '208', '208', '38', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '17', '18', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '40', '85', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '50', '89', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '60', '176', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '78', '78', '16', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '173', '209', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('101', '207', '207', '38', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('102', '17', '17', '11', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('102', '20', '21', '13', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('102', '36', '173', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('102', '38', '38', '22', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('102', '40', '85', '23', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('102', '60', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('102', '81', '30', '18', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('102', '132', '50', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('103', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('103', '97', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('103', '196', '210', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('104', '51', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('104', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('104', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('105', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('105', '96', '157', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('105', '132', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('106', '84', '173', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('106', '211', '196', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('108', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('108', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('108', '97', '150', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('109', '60', '97', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('109', '84', '84', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('110', '50', '51', '30', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('110', '96', '60', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('110', '173', '173', '21', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('111', '60', '166', '36', '2014-11-20 14:45:42');
INSERT INTO `animal_genotype` VALUES ('111', '84', '84', '21', '2014-11-20 14:45:42');

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
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8 COMMENT='基因型';

-- ----------------------------
-- Records of genotype
-- ----------------------------
INSERT INTO `genotype` VALUES ('1', '1', '140', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('2', '1', '152', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('3', '2', '138', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('4', '2', '142', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('5', '3', '238', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('6', '3', '250', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('7', '4', '334', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('8', '4', '338', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('9', '5', '218', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('10', '6', '225', null, '1', '2014-11-20 14:31:23', null, null, null);
INSERT INTO `genotype` VALUES ('11', '7', '333', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('12', '7', '337', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('13', '8', '131', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('14', '9', '232', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('15', '10', '331', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('16', '10', '339', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('17', '11', '263', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('18', '11', '272', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('19', '12', '256', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('20', '13', '329', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('21', '13', '333', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('22', '14', '166', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('23', '14', '174', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('24', '15', '225', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('25', '15', '229', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('26', '16', '331', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('27', '16', '337', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('28', '17', '214', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('29', '17', '230', null, '1', '2014-11-20 14:31:24', null, null, null);
INSERT INTO `genotype` VALUES ('30', '18', '387', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('31', '18', '391', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('32', '19', '230', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('33', '19', '235', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('34', '20', '381', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('35', '20', '387', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('36', '21', '312', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('37', '21', '330', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('38', '22', '263', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('39', '23', '254', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('40', '23', '262', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('41', '25', '445', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('42', '25', '453', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('43', '26', '380', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('44', '26', '384', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('45', '27', '277', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('46', '27', '286', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('47', '28', '189', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('48', '29', '226', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('49', '29', '230', null, '1', '2014-11-20 14:31:25', null, null, null);
INSERT INTO `genotype` VALUES ('50', '30', '408', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('51', '30', '412', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('52', '31', '272', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('53', '32', '203', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('54', '33', '304', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('55', '33', '312', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('56', '34', '383', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('57', '34', '387', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('58', '35', '370', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('59', '35', '374', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('60', '36', '392', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('61', '37', '370', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('62', '37', '378', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('63', '1', '164', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('64', '2', '122', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('65', '2', '130', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('66', '3', '246', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('67', '4', '346', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('68', '4', '350', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('69', '5', '238', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('70', '5', '242', null, '1', '2014-11-20 14:31:26', null, null, null);
INSERT INTO `genotype` VALUES ('71', '7', '325', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('72', '8', '135', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('73', '8', '139', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('74', '10', '343', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('75', '11', '266', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('76', '12', '252', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('77', '14', '162', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('78', '16', '322', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('79', '17', '222', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('80', '17', '226', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('81', '18', '383', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('82', '19', '240', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('83', '20', '390', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('84', '21', '318', null, '1', '2014-11-20 14:31:27', null, null, null);
INSERT INTO `genotype` VALUES ('85', '23', '266', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('86', '24', '393', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('87', '24', '401', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('88', '28', '185', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('89', '30', '428', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('90', '31', '268', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('91', '32', '211', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('92', '32', '219', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('93', '33', '308', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('94', '34', '391', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('95', '35', '382', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('96', '36', '384', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('97', '36', '396', null, '1', '2014-11-20 14:31:28', null, null, null);
INSERT INTO `genotype` VALUES ('98', '37', '394', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('99', '1', '160', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('100', '3', '254', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('101', '4', '342', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('102', '7', '341', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('103', '8', '143', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('104', '10', '335', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('105', '13', '349', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('106', '14', '158', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('107', '16', '328', null, '1', '2014-11-20 14:31:29', null, null, null);
INSERT INTO `genotype` VALUES ('108', '18', '363', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('109', '19', '245', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('110', '22', '267', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('111', '23', '258', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('112', '27', '280', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('113', '27', '289', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('114', '28', '181', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('115', '30', '392', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('116', '30', '432', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('117', '31', '264', null, '1', '2014-11-20 14:31:30', null, null, null);
INSERT INTO `genotype` VALUES ('118', '33', '292', null, '1', '2014-11-20 14:31:31', null, null, null);
INSERT INTO `genotype` VALUES ('119', '34', '395', null, '1', '2014-11-20 14:31:31', null, null, null);
INSERT INTO `genotype` VALUES ('120', '35', '378', null, '1', '2014-11-20 14:31:31', null, null, null);
INSERT INTO `genotype` VALUES ('121', '37', '382', null, '1', '2014-11-20 14:31:31', null, null, null);
INSERT INTO `genotype` VALUES ('122', '1', '168', null, '1', '2014-11-20 14:31:31', null, null, null);
INSERT INTO `genotype` VALUES ('123', '3', '242', null, '1', '2014-11-20 14:31:31', null, null, null);
INSERT INTO `genotype` VALUES ('124', '5', '230', null, '1', '2014-11-20 14:31:31', null, null, null);
INSERT INTO `genotype` VALUES ('125', '9', '236', null, '1', '2014-11-20 14:31:31', null, null, null);
INSERT INTO `genotype` VALUES ('126', '11', '269', null, '1', '2014-11-20 14:31:31', null, null, null);
INSERT INTO `genotype` VALUES ('127', '17', '238', null, '1', '2014-11-20 14:31:32', null, null, null);
INSERT INTO `genotype` VALUES ('128', '20', '393', null, '1', '2014-11-20 14:31:32', null, null, null);
INSERT INTO `genotype` VALUES ('129', '24', '381', null, '1', '2014-11-20 14:31:32', null, null, null);
INSERT INTO `genotype` VALUES ('130', '24', '385', null, '1', '2014-11-20 14:31:32', null, null, null);
INSERT INTO `genotype` VALUES ('131', '28', '169', null, '1', '2014-11-20 14:31:32', null, null, null);
INSERT INTO `genotype` VALUES ('132', '30', '400', null, '1', '2014-11-20 14:31:32', null, null, null);
INSERT INTO `genotype` VALUES ('133', '33', '316', null, '1', '2014-11-20 14:31:33', null, null, null);
INSERT INTO `genotype` VALUES ('134', '37', '374', null, '1', '2014-11-20 14:31:33', null, null, null);
INSERT INTO `genotype` VALUES ('135', '5', '246', null, '1', '2014-11-20 14:31:34', null, null, null);
INSERT INTO `genotype` VALUES ('136', '32', '223', null, '1', '2014-11-20 14:31:37', null, null, null);
INSERT INTO `genotype` VALUES ('137', '5', '234', null, '1', '2014-11-20 14:31:37', null, null, null);
INSERT INTO `genotype` VALUES ('138', '6', '245', null, '1', '2014-11-20 14:31:37', null, null, null);
INSERT INTO `genotype` VALUES ('139', '9', '244', null, '1', '2014-11-20 14:31:38', null, null, null);
INSERT INTO `genotype` VALUES ('140', '5', '222', null, '1', '2014-11-20 14:31:40', null, null, null);
INSERT INTO `genotype` VALUES ('141', '6', '229', null, '1', '2014-11-20 14:31:40', null, null, null);
INSERT INTO `genotype` VALUES ('142', '6', '233', null, '1', '2014-11-20 14:31:40', null, null, null);
INSERT INTO `genotype` VALUES ('143', '15', '237', null, '1', '2014-11-20 14:31:40', null, null, null);
INSERT INTO `genotype` VALUES ('144', '18', '379', null, '1', '2014-11-20 14:31:40', null, null, null);
INSERT INTO `genotype` VALUES ('145', '23', '270', null, '1', '2014-11-20 14:31:41', null, null, null);
INSERT INTO `genotype` VALUES ('146', '24', '389', null, '1', '2014-11-20 14:31:41', null, null, null);
INSERT INTO `genotype` VALUES ('147', '24', '397', null, '1', '2014-11-20 14:31:41', null, null, null);
INSERT INTO `genotype` VALUES ('148', '31', '256', null, '1', '2014-11-20 14:31:41', null, null, null);
INSERT INTO `genotype` VALUES ('149', '33', '300', null, '1', '2014-11-20 14:31:41', null, null, null);
INSERT INTO `genotype` VALUES ('150', '36', '400', null, '1', '2014-11-20 14:31:41', null, null, null);
INSERT INTO `genotype` VALUES ('151', '37', '366', null, '1', '2014-11-20 14:31:42', null, null, null);
INSERT INTO `genotype` VALUES ('152', '3', '234', null, '1', '2014-11-20 14:31:42', null, null, null);
INSERT INTO `genotype` VALUES ('153', '5', '214', null, '1', '2014-11-20 14:31:42', null, null, null);
INSERT INTO `genotype` VALUES ('154', '7', '345', null, '1', '2014-11-20 14:31:42', null, null, null);
INSERT INTO `genotype` VALUES ('155', '18', '375', null, '1', '2014-11-20 14:31:42', null, null, null);
INSERT INTO `genotype` VALUES ('156', '30', '404', null, '1', '2014-11-20 14:31:43', null, null, null);
INSERT INTO `genotype` VALUES ('157', '36', '388', null, '1', '2014-11-20 14:31:43', null, null, null);
INSERT INTO `genotype` VALUES ('158', '6', '237', null, '1', '2014-11-20 14:31:44', null, null, null);
INSERT INTO `genotype` VALUES ('159', '7', '329', null, '1', '2014-11-20 14:31:44', null, null, null);
INSERT INTO `genotype` VALUES ('160', '16', '332', null, '1', '2014-11-20 14:31:44', null, null, null);
INSERT INTO `genotype` VALUES ('161', '1', '144', null, '1', '2014-11-20 14:31:46', null, null, null);
INSERT INTO `genotype` VALUES ('162', '3', '258', null, '1', '2014-11-20 14:31:46', null, null, null);
INSERT INTO `genotype` VALUES ('163', '8', '127', null, '1', '2014-11-20 14:31:46', null, null, null);
INSERT INTO `genotype` VALUES ('164', '18', '395', null, '1', '2014-11-20 14:31:47', null, null, null);
INSERT INTO `genotype` VALUES ('165', '27', '292', null, '1', '2014-11-20 14:31:47', null, null, null);
INSERT INTO `genotype` VALUES ('166', '36', '412', null, '1', '2014-11-20 14:31:48', null, null, null);
INSERT INTO `genotype` VALUES ('167', '14', '170', null, '1', '2014-11-20 14:31:50', null, null, null);
INSERT INTO `genotype` VALUES ('168', '17', '242', null, '1', '2014-11-20 14:31:56', null, null, null);
INSERT INTO `genotype` VALUES ('169', '32', '207', null, '1', '2014-11-20 14:31:57', null, null, null);
INSERT INTO `genotype` VALUES ('170', '1', '172', null, '1', '2014-11-20 14:32:04', null, null, null);
INSERT INTO `genotype` VALUES ('171', '1', '156', null, '1', '2014-11-20 14:32:10', null, null, null);
INSERT INTO `genotype` VALUES ('172', '21', '306', null, '1', '2014-11-20 14:32:11', null, null, null);
INSERT INTO `genotype` VALUES ('173', '21', '324', null, '1', '2014-11-20 14:32:11', null, null, null);
INSERT INTO `genotype` VALUES ('174', '28', '177', null, '1', '2014-11-20 14:32:11', null, null, null);
INSERT INTO `genotype` VALUES ('175', '30', '420', null, '1', '2014-11-20 14:32:12', null, null, null);
INSERT INTO `genotype` VALUES ('176', '36', '404', null, '1', '2014-11-20 14:32:12', null, null, null);
INSERT INTO `genotype` VALUES ('177', '15', '233', null, '1', '2014-11-20 14:32:13', null, null, null);
INSERT INTO `genotype` VALUES ('178', '16', '313', null, '1', '2014-11-20 14:32:13', null, null, null);
INSERT INTO `genotype` VALUES ('179', '17', '234', null, '1', '2014-11-20 14:32:13', null, null, null);
INSERT INTO `genotype` VALUES ('180', '17', '246', null, '1', '2014-11-20 14:32:21', null, null, null);
INSERT INTO `genotype` VALUES ('181', '27', '274', null, '1', '2014-11-20 14:32:23', null, null, null);
INSERT INTO `genotype` VALUES ('182', '2', '126', null, '1', '2014-11-20 14:32:31', null, null, null);
INSERT INTO `genotype` VALUES ('183', '6', '221', null, '1', '2014-11-20 14:32:31', null, null, null);
INSERT INTO `genotype` VALUES ('184', '20', '378', null, '1', '2014-11-20 14:32:32', null, null, null);
INSERT INTO `genotype` VALUES ('185', '24', '377', null, '1', '2014-11-20 14:32:32', null, null, null);
INSERT INTO `genotype` VALUES ('186', '26', '388', null, '1', '2014-11-20 14:32:32', null, null, null);
INSERT INTO `genotype` VALUES ('187', '29', '214', null, '1', '2014-11-20 14:32:33', null, null, null);
INSERT INTO `genotype` VALUES ('188', '34', '379', null, '1', '2014-11-20 14:32:34', null, null, null);
INSERT INTO `genotype` VALUES ('189', '1', '148', null, '1', '2014-11-20 14:32:38', null, null, null);
INSERT INTO `genotype` VALUES ('190', '5', '226', null, '1', '2014-11-20 14:32:38', null, null, null);
INSERT INTO `genotype` VALUES ('191', '13', '337', null, '1', '2014-11-20 14:32:38', null, null, null);
INSERT INTO `genotype` VALUES ('192', '20', '372', null, '1', '2014-11-20 14:32:39', null, null, null);
INSERT INTO `genotype` VALUES ('193', '20', '384', null, '1', '2014-11-20 14:32:39', null, null, null);
INSERT INTO `genotype` VALUES ('194', '22', '271', null, '1', '2014-11-20 14:32:39', null, null, null);
INSERT INTO `genotype` VALUES ('195', '29', '222', null, '1', '2014-11-20 14:32:39', null, null, null);
INSERT INTO `genotype` VALUES ('196', '30', '416', null, '1', '2014-11-20 14:32:39', null, null, null);
INSERT INTO `genotype` VALUES ('197', '6', '253', null, '1', '2014-11-20 14:32:40', null, null, null);
INSERT INTO `genotype` VALUES ('198', '8', '151', null, '1', '2014-11-20 14:32:40', null, null, null);
INSERT INTO `genotype` VALUES ('199', '9', '228', null, '1', '2014-11-20 14:33:29', null, null, null);
INSERT INTO `genotype` VALUES ('200', '6', '241', null, '1', '2014-11-20 14:43:37', null, null, null);
INSERT INTO `genotype` VALUES ('201', '26', '392', null, '1', '2014-11-20 14:43:38', null, null, null);
INSERT INTO `genotype` VALUES ('202', '12', '248', null, '1', '2014-11-20 14:43:41', null, null, null);
INSERT INTO `genotype` VALUES ('203', '10', '334', null, '1', '2014-11-20 14:43:44', null, null, null);
INSERT INTO `genotype` VALUES ('204', '10', '338', null, '1', '2014-11-20 14:43:44', null, null, null);
INSERT INTO `genotype` VALUES ('205', '30', '424', null, '1', '2014-11-20 14:43:47', null, null, null);
INSERT INTO `genotype` VALUES ('206', '18', '399', null, '1', '2014-11-20 14:43:51', null, null, null);
INSERT INTO `genotype` VALUES ('207', '38', '404', null, '1', '2014-11-20 14:43:52', null, null, null);
INSERT INTO `genotype` VALUES ('208', '38', '416', null, '1', '2014-11-20 14:43:52', null, null, null);
INSERT INTO `genotype` VALUES ('209', '21', '336', null, '1', '2014-11-20 14:43:53', null, null, null);
INSERT INTO `genotype` VALUES ('210', '30', '436', null, '1', '2014-11-20 14:43:53', null, null, null);
INSERT INTO `genotype` VALUES ('211', '30', '396', null, '1', '2014-11-20 14:43:54', null, null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='引物表';

-- ----------------------------
-- Records of primer
-- ----------------------------
INSERT INTO `primer` VALUES ('1', 'Aifu-01', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('2', 'Aifu-02', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('3', 'Aifu-04', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('4', 'Aifu-05', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('5', 'Aifu-06', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('6', 'Aifu-07', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('7', 'Aifu-22', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('8', 'Aifu-23', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('9', 'Aifu-24', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('10', 'RP01', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('11', 'RP117', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('12', 'RP18', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('13', 'RP194', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('14', 'RP240', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('15', 'RP260', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('16', 'RP261', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('17', 'RP267', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('18', 'RP30', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('19', 'RP335', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('20', 'RP357', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('21', 'RP35', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('22', 'RP367', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('23', 'RP381', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('24', 'RP385', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('25', 'RP391', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('26', 'RP404', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('27', 'RP409', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('28', 'RP41', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('29', 'RP429', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('30', 'RP43', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('31', 'RP442', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('32', 'RP50', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('33', 'RP56', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('34', 'RP63', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('35', 'RP71', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('36', 'RP79', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('37', 'RP84', '1', '2014-11-20 11:35:42', null, null, null);
INSERT INTO `primer` VALUES ('38', 'RP400', '1', '2014-11-20 11:35:42', null, null, null);

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

-- ----------------------------
-- Procedure structure for clear_DB
-- ----------------------------
DROP PROCEDURE IF EXISTS `clear_DB`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clear_DB`( 
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
END
;;
DELIMITER ;
