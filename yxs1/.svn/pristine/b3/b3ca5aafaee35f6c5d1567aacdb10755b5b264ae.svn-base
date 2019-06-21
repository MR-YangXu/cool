/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50638
 Source Host           : localhost:3306
 Source Schema         : xyzk

 Target Server Type    : MySQL
 Target Server Version : 50638
 File Encoding         : 65001

 Date: 03/09/2018 17:56:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for patient_exam_result
-- ----------------------------
DROP TABLE IF EXISTS `patient_exam_result`;
CREATE TABLE `patient_exam_result`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NULL DEFAULT NULL COMMENT '患者信息表_Id',
  `examine_time` datetime(0) NULL DEFAULT NULL COMMENT '检查时间',
  `hgb` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血红蛋白',
  `hgb_time` datetime(0) NULL DEFAULT NULL COMMENT '血红蛋白记录时间',
  `alb` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血清白蛋白',
  `alb_time` datetime(0) NULL DEFAULT NULL COMMENT '血清白蛋白记录时间',
  `glu` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血糖',
  `glu_time` datetime(0) NULL DEFAULT NULL COMMENT '血糖记录时间',
  `wsc` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分泌物培养',
  `wsc_time` datetime(0) NULL DEFAULT NULL COMMENT '分泌物培养记录时间',
  `wbc` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '白细胞',
  `wbc_time` datetime(0) NULL DEFAULT NULL COMMENT '白细胞记录时间',
  `plt` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血小板',
  `plt_time` datetime(0) NULL DEFAULT NULL COMMENT '血小板记录时间',
  `esr` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血沉',
  `esr_time` datetime(0) NULL DEFAULT NULL COMMENT '血沉记录时间',
  `crp` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'C反应蛋白',
  `crp_time` datetime(0) NULL DEFAULT NULL COMMENT 'C反应蛋白记录时间',
  `disease_result` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '病理结果',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '记录创建时间',
  `systemic_detail` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '全身性疾病治疗情况与服用药物',
  `systemic_detail_time` datetime(0) NULL DEFAULT NULL COMMENT '全身性疾病治疗情况与服用药物,更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_Reference_6`(`patient_id`) USING BTREE,
  CONSTRAINT `patient_exam_result_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '实验室检查结果' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of patient_exam_result
-- ----------------------------
INSERT INTO `patient_exam_result` VALUES (1, 1, '2018-08-02 16:59:03', '12', '2018-08-27 16:59:09', '21', '2018-08-27 16:59:13', '21', '2018-08-27 16:59:17', '32', '2018-08-07 16:59:20', '45', '2018-08-10 16:59:25', '46', '2018-08-29 16:59:28', '23', '2018-08-25 16:59:32', '43', '2018-08-27 16:59:37', 'gg改好给黄', '2018-08-27 16:59:50', '发放地方', '2018-08-25 16:59:59');
INSERT INTO `patient_exam_result` VALUES (2, 1, '2018-08-08 16:59:03', '213', '2018-08-27 16:59:09', '532', '2018-08-27 16:59:13', '213', '2018-08-27 16:59:17', '323', '2018-08-07 16:59:20', '454', '2018-08-10 16:59:25', '463', '2018-08-29 16:59:28', '235', '2018-08-25 16:59:32', '436', '2018-08-27 16:59:37', 'gg改好给黄归属感', '2018-08-27 16:59:50', '发放地方噶尔', '2018-08-25 16:59:59');
INSERT INTO `patient_exam_result` VALUES (3, 1, '2018-08-31 16:59:03', '2134', '2018-08-27 16:59:09', '5324', '2018-08-27 16:59:13', '2134', '2018-08-27 16:59:17', '3244', '2018-08-07 16:59:20', '4544', '2018-08-10 16:59:25', '4644', '2018-08-29 16:59:28', '2354', '2018-08-25 16:59:32', '4364', '2018-08-27 16:59:37', 'gg改好给黄归属感dsf', '2018-08-27 16:59:50', '发放地方噶尔', '2018-08-25 16:59:59');

-- ----------------------------
-- Table structure for patient_info
-- ----------------------------
DROP TABLE IF EXISTS `patient_info`;
CREATE TABLE `patient_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '患者卡号',
  `ward` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '门诊/病室',
  `bed_no` int(11) NULL DEFAULT NULL COMMENT '床号',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `sex` tinyint(4) NULL DEFAULT NULL COMMENT '性别 1：男 ，2：女',
  `age` tinyint(4) NULL DEFAULT NULL COMMENT '年龄',
  `diagnosis` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '诊断',
  `surgery` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手术',
  `systemic_disease` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '全身性疾病信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `patient_info_un`(`card_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '患者信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of patient_info
-- ----------------------------
INSERT INTO `patient_info` VALUES (1, '123456', '骨科2033', 2, '水水', 1, 17, '古文化i', '事故后及', '刚而过', '2018-08-22 15:39:03');
INSERT INTO `patient_info` VALUES (2, '7894562', '门诊23', 11, '欢子', 2, 18, '打断点', '好好过', '搞破坏过个阿偶发挥法', '2018-08-28 14:37:14');
INSERT INTO `patient_info` VALUES (3, '1234536', '门诊23', 11, 'adfd', 2, 18, '打断点', '好好过', '搞破坏过个阿偶发挥法', '2018-08-28 14:48:18');
INSERT INTO `patient_info` VALUES (4, '45678916', 'string', 0, 'string', 0, 15, 'string', 'string', 'string', '2018-08-31 15:59:48');

-- ----------------------------
-- Table structure for patient_wound
-- ----------------------------
DROP TABLE IF EXISTS `patient_wound`;
CREATE TABLE `patient_wound`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NULL DEFAULT NULL COMMENT '患者_Id',
  `wound_type` int(11) NULL DEFAULT NULL COMMENT '伤口类型，外键关联wound_type的ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_Reference_1`(`patient_id`) USING BTREE,
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '患者伤口表，一名患者可以记录多个伤口' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of patient_wound
-- ----------------------------
INSERT INTO `patient_wound` VALUES (12, 1, 23, '2018-08-25 17:21:42');
INSERT INTO `patient_wound` VALUES (13, 1, 26, '2018-08-29 17:22:30');
INSERT INTO `patient_wound` VALUES (14, 1, 18, '2018-08-28 15:09:41');
INSERT INTO `patient_wound` VALUES (15, 2, 14, '2018-08-28 15:09:56');

-- ----------------------------
-- Table structure for pub_const_plane
-- ----------------------------
DROP TABLE IF EXISTS `pub_const_plane`;
CREATE TABLE `pub_const_plane`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  `value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '常量管理\n\n\n（1）渗液颜色(penetration_color)：黄色、绿色、黄褐色\n（2）渗透形状(penetration_shape)：粘稠、稀薄、其它（可输入）\n（3）渗液量(penetration_quantity) ：干燥、湿润(＜5mL/24h)、潮湿 (5-10mL/24h)、饱和 (＞10mL/24h)、漏出 (＞10mL/24h)\n（4）气味(smell)：无、移除敷料后可闻到、敷料存在时可闻到、与患者一个手臂距离可闻到、进入屋内可闻到、一进诊室就能闻到\n（5）创面疼痛频率(pain_frequency) : 无、只在换药、间断疼痛、持续疼痛\n（6）伤口边缘(wound_edge)：附着、非附着、卷边、上皮化\n（7）周围皮肤状态(skin_condition)：正常、水泡、干燥、苍白...\n（8）止疼药记录(painkillers)：肌肉注射、口服、局麻、表麻、特殊情况（可输入）\n（9）伤口形态(wound_shape)：单个开放性伤口、多个临近开放性伤口、密集临近开放性伤口、单个开放性伤口的缝线伤口、多个开放性伤口的缝线伤口\n（10）清创处理方式(debride_way)：保守锐器清创、自溶性清创、机械性清创、化学性清创、生物性清创、外科手术清创\n（11）清洗液(debride_liquid) ：生理盐水、双氧水\n（12）敷料种类(dressing_type)：泡沫类敷料、水胶体类、水凝胶类、液体敷料、藻酸盐敷料、薄膜类敷料。。。\n（13）后续处理(after_process)：患者病例完整、带敷料回当地、本院继续处理\n（14）全身性疾病（Systemic_disease）:神经系统疾病...' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_const_plane
-- ----------------------------
INSERT INTO `pub_const_plane` VALUES (1, 'penetrationColor', '黄色');
INSERT INTO `pub_const_plane` VALUES (2, 'penetrationColor', '绿色');
INSERT INTO `pub_const_plane` VALUES (3, 'penetrationColor', '黄褐色');
INSERT INTO `pub_const_plane` VALUES (4, 'penetrationShape', '粘稠');
INSERT INTO `pub_const_plane` VALUES (5, 'penetrationShape', '稀薄');
INSERT INTO `pub_const_plane` VALUES (6, 'penetrationShape', '其它');
INSERT INTO `pub_const_plane` VALUES (7, 'penetrationQuantity', '干燥');
INSERT INTO `pub_const_plane` VALUES (8, 'penetrationQuantity', '湿润(＜5mL/24h)');
INSERT INTO `pub_const_plane` VALUES (9, 'penetrationQuantity', '潮湿 (5-10mL/24h)');
INSERT INTO `pub_const_plane` VALUES (10, 'penetrationQuantity', '饱和 (＞10mL/24h)');
INSERT INTO `pub_const_plane` VALUES (11, 'penetrationQuantity', '漏出 (＞10mL/24h)');
INSERT INTO `pub_const_plane` VALUES (12, 'smell', '无');
INSERT INTO `pub_const_plane` VALUES (13, 'smell', '移除敷料后可闻到');
INSERT INTO `pub_const_plane` VALUES (14, 'smell', '敷料存在时可闻到');
INSERT INTO `pub_const_plane` VALUES (15, 'smell', '与患者一个手臂距离可闻到');
INSERT INTO `pub_const_plane` VALUES (16, 'smell', '进入屋内可闻到');
INSERT INTO `pub_const_plane` VALUES (21, 'dressingType', '泡沫类敷料');
INSERT INTO `pub_const_plane` VALUES (22, 'dressingType', '水胶体类');
INSERT INTO `pub_const_plane` VALUES (23, 'dressingType', '水凝胶类');
INSERT INTO `pub_const_plane` VALUES (24, 'dressingType', '液体敷料');
INSERT INTO `pub_const_plane` VALUES (25, 'dressingType', '藻酸盐敷料');
INSERT INTO `pub_const_plane` VALUES (26, 'dressingType', '薄膜类敷料');
INSERT INTO `pub_const_plane` VALUES (27, 'smell', '一进诊室就能闻到');
INSERT INTO `pub_const_plane` VALUES (28, 'woundEdge', '附着');
INSERT INTO `pub_const_plane` VALUES (29, 'woundEdge', '非附着');
INSERT INTO `pub_const_plane` VALUES (30, 'woundEdge', '卷边');
INSERT INTO `pub_const_plane` VALUES (31, 'woundEdge', '上皮化');
INSERT INTO `pub_const_plane` VALUES (32, 'skinVondition', '正常');
INSERT INTO `pub_const_plane` VALUES (33, 'skinVondition', '水泡');
INSERT INTO `pub_const_plane` VALUES (34, 'skinVondition', '干燥');
INSERT INTO `pub_const_plane` VALUES (35, 'skinVondition', '苍白');
INSERT INTO `pub_const_plane` VALUES (36, 'skinVondition', '皮炎');
INSERT INTO `pub_const_plane` VALUES (37, 'skinVondition', '水肿');
INSERT INTO `pub_const_plane` VALUES (38, 'skinVondition', '淤斑');
INSERT INTO `pub_const_plane` VALUES (39, 'skinVondition', '色素沉着');
INSERT INTO `pub_const_plane` VALUES (40, 'skinVondition', '红/热');
INSERT INTO `pub_const_plane` VALUES (41, 'skinVondition', '浸渍');
INSERT INTO `pub_const_plane` VALUES (42, 'painkillers', '肌肉注射');
INSERT INTO `pub_const_plane` VALUES (43, 'painkillers', '口服');
INSERT INTO `pub_const_plane` VALUES (44, 'painkillers', '局麻');
INSERT INTO `pub_const_plane` VALUES (45, 'painkillers', '表麻');
INSERT INTO `pub_const_plane` VALUES (46, 'painkillers', '特殊情况');
INSERT INTO `pub_const_plane` VALUES (47, 'woundShape', '单个开放性伤口');
INSERT INTO `pub_const_plane` VALUES (48, 'woundShape', '多个临近开放性伤口');
INSERT INTO `pub_const_plane` VALUES (49, 'woundShape', '密集临近开放性伤口');
INSERT INTO `pub_const_plane` VALUES (50, 'woundShape', '单个开放性伤口的缝线伤口');
INSERT INTO `pub_const_plane` VALUES (51, 'woundShape', '多个开放性伤口的缝线伤口');
INSERT INTO `pub_const_plane` VALUES (52, 'debrideWay', '保守锐器清创');
INSERT INTO `pub_const_plane` VALUES (53, 'debrideWay', '自溶性清创');
INSERT INTO `pub_const_plane` VALUES (54, 'debrideWay', '机械性清创');
INSERT INTO `pub_const_plane` VALUES (55, 'debrideWay', '化学性清创');
INSERT INTO `pub_const_plane` VALUES (56, 'debrideWay', '生物性清创');
INSERT INTO `pub_const_plane` VALUES (57, 'debrideWay', '外科手术清创');
INSERT INTO `pub_const_plane` VALUES (58, 'debrideLiquid', '生理盐水');
INSERT INTO `pub_const_plane` VALUES (59, 'debrideLiquid', '双氧水');
INSERT INTO `pub_const_plane` VALUES (60, 'dressingType', '银敷料');
INSERT INTO `pub_const_plane` VALUES (61, 'dressingType', '高渗盐敷料');
INSERT INTO `pub_const_plane` VALUES (62, 'dressingType', '皮肤伤口胶带');
INSERT INTO `pub_const_plane` VALUES (63, 'dressingType', '自粘性敷料');
INSERT INTO `pub_const_plane` VALUES (64, 'dressingType', '抗瘢痕敷料');
INSERT INTO `pub_const_plane` VALUES (65, 'afterProcess', '患者病例完整');
INSERT INTO `pub_const_plane` VALUES (66, 'afterProcess', '患者病例不完整');
INSERT INTO `pub_const_plane` VALUES (67, 'afterProcess', '本院继续处理');
INSERT INTO `pub_const_plane` VALUES (68, 'afterProcess', '带敷料回当地');
INSERT INTO `pub_const_plane` VALUES (69, 'afterProcess', '在家自行处理');
INSERT INTO `pub_const_plane` VALUES (70, 'afterProcess', '当地医疗机构继续处理');
INSERT INTO `pub_const_plane` VALUES (71, 'painFrequency', '无');
INSERT INTO `pub_const_plane` VALUES (72, 'painFrequency', '只在换药');
INSERT INTO `pub_const_plane` VALUES (73, 'painFrequency', '间断疼痛');
INSERT INTO `pub_const_plane` VALUES (74, 'painFrequency', '持续疼痛');

-- ----------------------------
-- Table structure for pub_dressing
-- ----------------------------
DROP TABLE IF EXISTS `pub_dressing`;
CREATE TABLE `pub_dressing`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `type_id` int(11) NULL DEFAULT NULL COMMENT '类型',
  `company` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司',
  `specification` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '敷料表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pub_dressing
-- ----------------------------
INSERT INTO `pub_dressing` VALUES (1, '透明贴', 21, NULL, NULL, NULL);
INSERT INTO `pub_dressing` VALUES (2, '多爱肤膏', 21, NULL, NULL, NULL);
INSERT INTO `pub_dressing` VALUES (3, '藻酸盐', 22, NULL, NULL, NULL);
INSERT INTO `pub_dressing` VALUES (4, '大iv3000', 26, NULL, NULL, NULL);
INSERT INTO `pub_dressing` VALUES (5, '皮肤伤口胶带', 25, NULL, NULL, NULL);
INSERT INTO `pub_dressing` VALUES (6, '小iv3000', 26, NULL, NULL, NULL);
INSERT INTO `pub_dressing` VALUES (7, '赛肤润', 24, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for wound_info
-- ----------------------------
DROP TABLE IF EXISTS `wound_info`;
CREATE TABLE `wound_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `record_id` int(11) NULL DEFAULT NULL COMMENT '伤口记录id',
  `record_flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评估情况是否一致，1：一致，0：不一致',
  `length` double NULL DEFAULT NULL COMMENT '长度',
  `width` double NULL DEFAULT NULL COMMENT '宽度',
  `depth` double NULL DEFAULT NULL COMMENT '深度',
  `volume` double NULL DEFAULT NULL COMMENT '体积',
  `area` double NULL DEFAULT NULL COMMENT '面积',
  `suture_length` double NULL DEFAULT NULL COMMENT '缝线长度',
  `black` double NULL DEFAULT NULL COMMENT '坏死（黑色）',
  `yellow` double NULL DEFAULT NULL COMMENT '腐肉（黄色）',
  `red` double NULL DEFAULT NULL COMMENT '肉芽（红色）',
  `pink` double NULL DEFAULT NULL COMMENT '上皮（粉红）',
  `penetration_color` int(11) NULL DEFAULT NULL COMMENT '渗液颜色，常量表',
  `penetration_shape` int(11) NULL DEFAULT NULL COMMENT '渗液形状，常量表',
  `penetration_quantity` int(11) NULL DEFAULT NULL COMMENT '渗液(量)，常量表',
  `smell` int(11) NULL DEFAULT NULL COMMENT '气味，常量表',
  `wound_edge` int(11) NULL DEFAULT NULL COMMENT '伤口边缘，常量表',
  `pain_level` int(11) NULL DEFAULT NULL COMMENT '疼痛程度',
  `pain_frequency` int(11) NULL DEFAULT NULL COMMENT '疼痛频率，常量表',
  `painkillers` int(11) NULL DEFAULT NULL COMMENT '止疼药，疼痛程度大于4时需要设置止疼药，常量表',
  `skin_condition` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '周围皮肤状态，常量表，多选',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of wound_info
-- ----------------------------
INSERT INTO `wound_info` VALUES (1, 1, NULL, 1, 2, 3, 5, 5, 5, NULL, 1, NULL, 4, 1, 4, 4, 4, NULL, 4, 1, 1, NULL, NULL);

-- ----------------------------
-- Table structure for wound_info_type
-- ----------------------------
DROP TABLE IF EXISTS `wound_info_type`;
CREATE TABLE `wound_info_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info_id` int(11) NULL DEFAULT NULL COMMENT '伤口记录信息id，关联wound_record_info表id',
  `type` int(11) NOT NULL COMMENT '类型:  1、潜行，2、窦道，3、瘘管',
  `length` decimal(10, 2) NULL DEFAULT NULL COMMENT '长度',
  `start_point` int(11) NULL DEFAULT NULL COMMENT '开始点',
  `end_point` int(11) NULL DEFAULT NULL COMMENT '结束点',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '一个伤口可以有多个潜行/窦道/瘘管\r\n潜行：开始点、长度\r\n窦道：开始点、结束点、长度\r\n瘘管：开始点、备注、长度' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of wound_info_type
-- ----------------------------
INSERT INTO `wound_info_type` VALUES (1, 1, 1, 3.00, 1, NULL, NULL);
INSERT INTO `wound_info_type` VALUES (2, 1, 2, 6.00, 3, 2, NULL);
INSERT INTO `wound_info_type` VALUES (3, 1, 3, 2.00, 3, NULL, 'hhtsrhg');
INSERT INTO `wound_info_type` VALUES (4, 2, 1, 3.00, 1, NULL, NULL);
INSERT INTO `wound_info_type` VALUES (5, 2, 2, 6.00, 3, 2, NULL);
INSERT INTO `wound_info_type` VALUES (6, 2, 3, 2.00, 3, NULL, 'hhtsrhg');
INSERT INTO `wound_info_type` VALUES (13, 9, 2, 0.00, 0, 0, 'string');
INSERT INTO `wound_info_type` VALUES (14, 10, 2, 0.00, 0, 0, 'string');
INSERT INTO `wound_info_type` VALUES (15, 11, 2, 0.00, 0, 0, 'string');

-- ----------------------------
-- Table structure for wound_record
-- ----------------------------
DROP TABLE IF EXISTS `wound_record`;
CREATE TABLE `wound_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wound_id` int(11) NULL DEFAULT NULL COMMENT '患者伤口表_id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '记录时间',
  `previous_exudate_pic` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拍摄前一次渗液情况',
  `before_debride_pic` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拍摄与测量清创前伤口',
  `after_debride_pic` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拍摄与测量清创后伤口',
  `reference_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拍摄参考备注图片',
  `site` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '伤口部位',
  `voice` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语音备注，保存到阿里云上',
  `wound_shape` int(11) NULL DEFAULT NULL COMMENT '伤口形态，常量表',
  `debride_way` int(11) NULL DEFAULT NULL COMMENT '处理方式，常量表',
  `debride_liquid` int(11) NULL DEFAULT NULL COMMENT '清洗液，常量表',
  `after_dressing_pic` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '敷药后伤口情形',
  `dressing_package_pic` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '敷药包装图片',
  `dressing_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '敷料，关联pub_dressing表',
  `after_process` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '后续处理，常量表，多选',
  `nurse_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '护士签名，图片',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_Reference_2`(`wound_id`) USING BTREE,
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`wound_id`) REFERENCES `patient_wound` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '伤口信息记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of wound_record
-- ----------------------------
INSERT INTO `wound_record` VALUES (1, 12, '2018-09-29 10:18:29', 'gpaiguhioa', 'gaophgpagh', 'gjaogijap', 'afgeageg', '大腿', 'gaogfauyo', 1, 21, 21, 'asdgagag', 'gagagga', NULL, '65,67', 'gagargaeh');
INSERT INTO `wound_record` VALUES (2, 14, '2018-08-24 10:21:49', 'agahrehr', 'kuykyk', 'gjaothhrhtrgijap', 'ahahtrd', '大腿', 'eriuhouei', 1, 12, 12, 'asdgagag', 'gagagga', NULL, '65,67,68', 'gagargaeh');
INSERT INTO `wound_record` VALUES (9, 13, '2018-08-31 09:56:15', 'string', 'string', 'string', 'string', 'string', 'string', 0, 0, 0, 'string', 'string', NULL, 'string', 'string');
INSERT INTO `wound_record` VALUES (10, 13, '2018-08-31 09:56:45', 'string', 'string', 'string', 'string', 'string', 'string', 0, 0, 0, 'string', 'string', NULL, 'string', 'string');
INSERT INTO `wound_record` VALUES (11, 13, '2018-08-31 09:57:05', 'string', 'string', 'string', 'string', 'string', 'string', 0, 0, 0, 'string', 'string', NULL, 'string', 'string');

-- ----------------------------
-- Table structure for wound_type
-- ----------------------------
DROP TABLE IF EXISTS `wound_type`;
CREATE TABLE `wound_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '伤口类型名称',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '上一级id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '伤口类型' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of wound_type
-- ----------------------------
INSERT INTO `wound_type` VALUES (1, '急性伤口', 0);
INSERT INTO `wound_type` VALUES (2, '慢性伤口', 0);
INSERT INTO `wound_type` VALUES (3, '其它伤口', 0);
INSERT INTO `wound_type` VALUES (9, '皮肤软组织缝线切口', 1);
INSERT INTO `wound_type` VALUES (10, '浅部组织化脓性感染', 1);
INSERT INTO `wound_type` VALUES (11, '开放性损伤伤口', 1);
INSERT INTO `wound_type` VALUES (12, '烧烫伤', 1);
INSERT INTO `wound_type` VALUES (13, '咬蛰伤', 1);
INSERT INTO `wound_type` VALUES (14, '拔甲', 1);
INSERT INTO `wound_type` VALUES (15, '手术后不愈伤口', 2);
INSERT INTO `wound_type` VALUES (16, '静脉溃疡', 2);
INSERT INTO `wound_type` VALUES (17, '动脉溃疡', 2);
INSERT INTO `wound_type` VALUES (18, '糖尿病伤口', 2);
INSERT INTO `wound_type` VALUES (19, '压疮', 2);
INSERT INTO `wound_type` VALUES (20, '输液外渗', 2);
INSERT INTO `wound_type` VALUES (21, '肿瘤伤口', 2);
INSERT INTO `wound_type` VALUES (22, '结核伤口', 2);
INSERT INTO `wound_type` VALUES (23, '肠瘘', 2);
INSERT INTO `wound_type` VALUES (24, '血管瘤注射后伤口感染', 2);
INSERT INTO `wound_type` VALUES (25, '其他皮肤相关疾病溃疡', 2);
INSERT INTO `wound_type` VALUES (26, '引流管护理', 3);
INSERT INTO `wound_type` VALUES (27, '引流管拔管', 3);
INSERT INTO `wound_type` VALUES (28, 'picc维护', 3);
INSERT INTO `wound_type` VALUES (29, 'picc拔管', 3);
INSERT INTO `wound_type` VALUES (30, '造口常规护理', 3);
INSERT INTO `wound_type` VALUES (31, '造口并发症处理', 3);
INSERT INTO `wound_type` VALUES (32, '乳腺化脓性感染', 10);
INSERT INTO `wound_type` VALUES (33, '肛周化脓性感染', 10);
INSERT INTO `wound_type` VALUES (34, '手部化脓性感染', 10);
INSERT INTO `wound_type` VALUES (35, '颈部化脓性感染', 10);
INSERT INTO `wound_type` VALUES (36, '背部化脓性感染', 10);
INSERT INTO `wound_type` VALUES (37, '腋下化脓性感染', 10);
INSERT INTO `wound_type` VALUES (38, '其他部位化脓性感染', 10);
INSERT INTO `wound_type` VALUES (39, '蛇咬伤', 13);
INSERT INTO `wound_type` VALUES (40, '狗咬伤', 13);
INSERT INTO `wound_type` VALUES (41, '虫咬伤', 13);
INSERT INTO `wound_type` VALUES (42, '糖尿病足', 18);
INSERT INTO `wound_type` VALUES (43, '其他伤口', 18);
INSERT INTO `wound_type` VALUES (44, '血管炎', 25);
INSERT INTO `wound_type` VALUES (45, '深部真菌病', 25);
INSERT INTO `wound_type` VALUES (46, '大疱类疹病', 25);
INSERT INTO `wound_type` VALUES (47, '皮肌炎', 25);
INSERT INTO `wound_type` VALUES (48, '皮损', 25);
INSERT INTO `wound_type` VALUES (49, '湿疹', 25);
INSERT INTO `wound_type` VALUES (50, '其他', 25);
INSERT INTO `wound_type` VALUES (52, '造口刺激性皮炎', 31);
INSERT INTO `wound_type` VALUES (53, '造口过敏性皮炎', 31);
INSERT INTO `wound_type` VALUES (54, '造口粘膜缺血坏死', 31);
INSERT INTO `wound_type` VALUES (55, '造口皮肤黏膜分离', 31);
INSERT INTO `wound_type` VALUES (56, '造口周围皮肤软组织感染', 31);
INSERT INTO `wound_type` VALUES (57, '造口回缩', 31);
INSERT INTO `wound_type` VALUES (58, '造口脱垂', 31);
INSERT INTO `wound_type` VALUES (59, '造口旁疝', 31);

SET FOREIGN_KEY_CHECKS = 1;
