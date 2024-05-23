/*
 Navicat Premium Data Transfer

 Source Server         : ZpTest
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : beegoxiaomi

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 23/05/2024 17:15:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0',
  `type` tinyint(1) NULL DEFAULT NULL,
  `action_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `module_id` int NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 129 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of access
-- ----------------------------
INSERT INTO `access` VALUES (52, '管理员管理', 1, '', '', 0, 1, '管理员管理', 0, 1);
INSERT INTO `access` VALUES (53, '角色管理', 1, '', '', 0, 999, '角色管理', 0, 1);
INSERT INTO `access` VALUES (54, '管理员管理', 2, '管理员列表', '/manager', 52, 2, '管理员列表', 0, 1);
INSERT INTO `access` VALUES (55, '管理员管理', 2, '增加管理员', '/manager/add', 52, 1004, '管理员列表', 0, 1);
INSERT INTO `access` VALUES (56, '管理员管理', 3, '编辑管理员', '/manager/edit', 52, 3, '编辑管理员', 0, 1);
INSERT INTO `access` VALUES (57, '管理员管理', 3, '删除管理员', '/manager/delete', 52, 100, '删除管理员', 0, 1);
INSERT INTO `access` VALUES (59, '角色管理', 2, '角色列表', '/role', 53, 100, '角色列表', 0, 1);
INSERT INTO `access` VALUES (60, '角色管理', 2, '增加角色', '/role/add', 53, 100, '增加角色', 0, 1);
INSERT INTO `access` VALUES (64, '权限管理', 2, '权限列表', '/access', 74, 100, '', 0, 1);
INSERT INTO `access` VALUES (65, '权限管理', 2, '增加权限', '/access/add', 74, 1002, '增加权限', 0, 1);
INSERT INTO `access` VALUES (72, '角色管理', 3, '编辑角色', '/role/edit', 53, 100, '编辑角色', 0, 1);
INSERT INTO `access` VALUES (73, '角色管理', 3, '删除角色', '/role/delete', 53, 100, '删除角色', 0, 1);
INSERT INTO `access` VALUES (74, '权限管理', 1, '', '', 0, 998, '权限管理', 0, 1);
INSERT INTO `access` VALUES (78, '管理员管理', 3, '执行增加', '/manager/doAdd', 52, 100, '执行增加', 0, 1);
INSERT INTO `access` VALUES (79, '管理员管理', 3, '执行修改', '/manager/doEdit', 52, 100, '', 0, 1);
INSERT INTO `access` VALUES (80, '角色管理', 3, '执行修改', '/role/doEdit', 53, 100, '', 0, 1);
INSERT INTO `access` VALUES (81, '角色管理', 3, '执行增加', '/role/doAdd', 53, 100, '', 0, 1);
INSERT INTO `access` VALUES (82, '角色管理', 3, '授权', '/role/auth', 53, 100, '', 0, 1);
INSERT INTO `access` VALUES (83, '角色管理', 3, '执行授权', '/role/doAuth', 53, 100, '', 0, 1);
INSERT INTO `access` VALUES (84, '角色管理', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `access` VALUES (85, '权限管理', 3, '修改权限', '/access/edit', 74, 100, '修改权限', 0, 1);
INSERT INTO `access` VALUES (86, '权限管理', 3, '执行增加', '/access/doAdd', 74, 100, '', 0, 1);
INSERT INTO `access` VALUES (87, '权限管理', 3, '执行修改', '/access/doEdit', 74, 100, '', 0, 1);
INSERT INTO `access` VALUES (88, '权限管理', 3, '删除权限', '/access/delete', 74, 100, '', 0, 1);
INSERT INTO `access` VALUES (89, '轮播图管理', 1, '', '', 0, 111, '轮播图管理', 0, 1);
INSERT INTO `access` VALUES (90, '轮播图管理', 2, '轮播图列表', '/focus', 89, 100, '', 0, 1);
INSERT INTO `access` VALUES (91, '轮播图管理', 2, '增加轮播图', '/focus/add', 89, 100, '增加轮播图', 0, 1);
INSERT INTO `access` VALUES (92, '轮播图管理', 3, '修改轮播图', '/focus/edit', 89, 100, '执行修改', 0, 1);
INSERT INTO `access` VALUES (93, '轮播图管理', 3, '执行增加', '/focus/doAdd', 89, 100, '执行增加', 0, 1);
INSERT INTO `access` VALUES (94, '轮播图管理', 3, '执行修改', '/focus/doEdit', 89, 100, '执行修改', 0, 1);
INSERT INTO `access` VALUES (95, '轮播图管理', 3, '执行删除', '/focus/delete', 89, 100, '执行删除', 0, 1);
INSERT INTO `access` VALUES (96, '商品管理', 1, '', '', 0, 100, '', 0, 1);
INSERT INTO `access` VALUES (97, '商品管理', 2, '商品列表', '/goods', 96, 100, '', 0, 1);
INSERT INTO `access` VALUES (98, '商品管理', 2, '商品分类', '/goodsCate', 96, 100, '商品分类', 0, 1);
INSERT INTO `access` VALUES (99, '商品管理', 3, '增加商品分类', '/goodsCate/add', 96, 100, '增加商品分类', 0, 1);
INSERT INTO `access` VALUES (100, '商品管理', 3, '修改商品分类', '/goodsCate/edit', 96, 100, '修改商品分类', 0, 1);
INSERT INTO `access` VALUES (101, '商品管理', 3, '执行增加商品分类', '/goodsCate/doAdd', 96, 100, '执行增加', 0, 1);
INSERT INTO `access` VALUES (102, '商品管理', 3, '执行修改商品分类', '/goodsCate/doEdit', 96, 100, '执行修改', 0, 1);
INSERT INTO `access` VALUES (103, '商品管理', 3, '删除商品分类', '/goodsCate/delete', 96, 100, '删除商品分类', 0, 1);
INSERT INTO `access` VALUES (105, '商品管理', 3, '增加商品类型', '/goodsType/add', 96, 100, '', 0, 1);
INSERT INTO `access` VALUES (106, '商品管理', 3, '商品类型-执行增加', '/goodsType/doAdd', 96, 100, '', 0, 1);
INSERT INTO `access` VALUES (108, '商品管理', 3, '修改商品类型', '/goodsType/edit', 96, 100, '', 0, 1);
INSERT INTO `access` VALUES (109, '商品管理', 3, '删除商品类型', '/goodsType/delete', 96, 100, '', 0, 1);
INSERT INTO `access` VALUES (111, '商品管理', 3, '增加商品', '/goods/add', 96, 100, '增加商品', 0, 1);
INSERT INTO `access` VALUES (112, '商品管理', 3, '修改商品', '/goods/edit', 96, 100, '修改商品', 0, 1);
INSERT INTO `access` VALUES (113, '商品管理', 3, '删除商品', '/goods/delete', 96, 100, '删除商品', 0, 1);
INSERT INTO `access` VALUES (114, '商品管理', 3, '执行-增加商品', '/goods/doAdd', 96, 100, '执行增加商品', 0, 1);
INSERT INTO `access` VALUES (115, '商品管理', 3, '执行-修改商品', '/goods/doEdit', 96, 100, '执行-修改商品', 0, 1);
INSERT INTO `access` VALUES (116, '导航栏设置', 1, '', '', 0, 100, '', 0, 1);
INSERT INTO `access` VALUES (117, '导航栏设置', 2, '导航管理', '/nav', 116, 100, '导航管理', 0, 0);
INSERT INTO `access` VALUES (118, '导航栏设置', 3, '增加导航', '/nav/add', 116, 100, '/nav/add', 0, 1);
INSERT INTO `access` VALUES (119, '导航栏设置', 3, '修改导航', '/nav/edit', 116, 100, '', 0, 1);
INSERT INTO `access` VALUES (120, '导航栏设置', 3, '导航-执行增加', '/nav/doAdd', 116, 100, '', 0, 1);
INSERT INTO `access` VALUES (125, '订单管理', 1, '', '', 0, 100, '', 0, 1);
INSERT INTO `access` VALUES (126, '查看订单', 2, '查看订单', '/order', 125, 100, '查看用户提交的订单', 0, 1);
INSERT INTO `access` VALUES (127, '数据可视化', 2, '数据可视化', '/dataShow', 125, 100, '大数据分析', 0, 1);
INSERT INTO `access` VALUES (128, '用户管理', 2, '用户列表', '/userlist', 53, 100, '', 0, 1);

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `default_address` tinyint(1) NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  `zipcode` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (29, 6, '李四1222', '15201686411', '北京市海淀区', 0, 0, '10000');
INSERT INTO `address` VALUES (30, 6, '王五1', '15201686641', '深圳市 宝安区', 0, 0, '10000');
INSERT INTO `address` VALUES (31, 6, '赵四', '15264111111', '北京市海淀区', 0, 0, '10000');
INSERT INTO `address` VALUES (32, 6, '哈哈', '15201686411', '北京市海淀区111', 1, 0, '10000');
INSERT INTO `address` VALUES (33, 6, '王麻子222', '16212345622', '北京市海淀区222', 0, 0, '111222');
INSERT INTO `address` VALUES (34, 9, 'long zhang', '15201686411', '北京市海淀区', 1, 0, '10000');
INSERT INTO `address` VALUES (35, 10, 'zhangsan', '15264111521', '北京市海淀区', 0, 0, '10000');
INSERT INTO `address` VALUES (36, 5, 'Nap', '19861129871', '鲁东大学', 1, 0, '');
INSERT INTO `address` VALUES (37, 11, 'Nap', '19861129871', '山东省烟台市鲁东大学北区', 1, 0, '4302');
INSERT INTO `address` VALUES (38, 14, 'zp', '12222222222', '123', 1, 0, '123');
INSERT INTO `address` VALUES (39, 15, '刘鹏', '13153011482', '设实数', 1, 0, '1111');
INSERT INTO `address` VALUES (40, 10, '郑攀', '19861129871', '山东省烟台市鲁东大学北区菜鸟驿站', 1, 0, '264025');
INSERT INTO `address` VALUES (41, 23, 'Nap', '19861129871', '山东省烟台市鲁东大学北区菜鸟驿站', 0, 0, '264025');
INSERT INTO `address` VALUES (42, 23, 'Jason', '0007', '山东省烟台市鲁东大学北区菜鸟驿站', 0, 0, '264025');
INSERT INTO `address` VALUES (43, 23, 'Jason', '19861126666', '山东省烟台市鲁东大学北区菜鸟驿站', 1, 0, '264025');

-- ----------------------------
-- Table structure for focus
-- ----------------------------
DROP TABLE IF EXISTS `focus`;
CREATE TABLE `focus`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `focus_type` tinyint(1) NULL DEFAULT NULL,
  `focus_img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of focus
-- ----------------------------
INSERT INTO `focus` VALUES (9, '樱桃', 1, 'static/upload/20240422/1713720877659715300.jpg', 'http://localhost:8080/item_29.html', 1, 1, 1591535347);
INSERT INTO `focus` VALUES (10, '大苹果', 1, 'static/upload/20240415/1713163202575122500.png', 'http://localhost:8080/item_30.html', 2, 1, 1591535381);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cate_id` int NULL DEFAULT NULL,
  `click_count` int NULL DEFAULT NULL,
  `goods_number` int NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `market_price` decimal(10, 2) NULL DEFAULT NULL,
  `relation_goods` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_attr` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_gift` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_fitting` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `is_delete` tinyint NULL DEFAULT NULL,
  `is_hot` tinyint NULL DEFAULT NULL,
  `is_best` tinyint NULL DEFAULT NULL,
  `is_new` tinyint NULL DEFAULT NULL,
  `goods_type_id` int NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  `goods_id` int NULL DEFAULT NULL,
  `sale_num` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (19, '蘑菇', '', 1, 100, 1000, 4.00, 6.00, '', '', '', 'static/upload/20240508/1715127198079315300.jpg', '', '', '', '', '<p>蘑菇是大自然的一份礼物，它们在深林中静静地绽放，无论是形状、颜色还是纹理，都充满了诗意和想象力。&nbsp;</p>', 0, 1, 1, 1, 0, 0, 1, 1592392307, NULL, NULL);
INSERT INTO `goods` VALUES (20, '青菜', '', 1, 100, 1000, 5.00, 6.00, '', '', '', 'static/upload/20240418/1713371113496866700.jpg', '', '', '', '', '<p><span style=\"color: rgb(51, 51, 51); font-family: Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">青菜为低脂肪蔬菜，含有膳食纤维，还含多种营养素，富含维生素C，可用于腌制泡菜，还可晒为霉干菜。具有降低血脂、宽肠通便、美容等功效</span></p>', 0, 1, 1, 1, 0, 0, 1, 1592392495, NULL, NULL);
INSERT INTO `goods` VALUES (21, '西红柿', '', 1, 100, 1000, 3.00, 4.00, '', '', '', 'static/upload/20240508/1715127233268882300.jpg', '', '', '', '', '<p>666</p>', 0, 1, 1, 1, 0, 0, 1, 1592392825, NULL, NULL);
INSERT INTO `goods` VALUES (22, '水蜜桃', '2', 2, 100, 1000, 20.00, 35.00, '', '', '', 'static/upload/20240416/1713267964258120800.jpg', '', '', '', '', '<p>&nbsp;水蜜桃是蔷薇科桃属植物。 水蜜桃成熟后略成球形，表面裹着一层细小的绒毛，青里泛白，白里透红。 因水蜜桃所含果汁多，果肉香甜如蜜</p>', 0, 1, 1, 1, 0, 1, 1, 1592820016, NULL, NULL);
INSERT INTO `goods` VALUES (23, '鸡蛋', '', 5, 100, 1000, 1.00, 2.00, '', '', '', 'static/upload/20240421/1713671341200706900.jpg', '', '', '', '', '<p>含有蛋白质、脂肪、碳水化合物、粗纤维和钙、磷、铁等人体所需的物质&nbsp;</p>', 0, 1, 1, 1, 0, 2, 1, 1592820111, NULL, NULL);
INSERT INTO `goods` VALUES (24, '夏威夷果', '', 5, 100, 1000, 20.00, 30.00, '', '', '', 'static/upload/20240421/1713671603103639400.jpg', '', '', '', '', '<p><span style=\"color: rgb(51, 51, 51); font-family: -apple-system, Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">夏威夷果原产于澳洲昆士兰东南的海岸雨林和新南威尔士北部河谷地带，目前在夏威夷、美国、澳大利亚等地区有大量栽培</span></p>', 0, 1, 1, 1, 0, 0, 1, 1592820244, NULL, NULL);
INSERT INTO `goods` VALUES (25, '玉米', '', 9, 100, 1000, 2.00, 5.00, '', '', '', 'static/upload/20240422/1713719367123351600.jpg', '', '', '', '', '<p>减肥就吃玉米好吧，0脂肪。</p>', 0, 1, 1, 1, 0, 0, 1, 1592820331, NULL, NULL);
INSERT INTO `goods` VALUES (28, '地瓜', '', 1, 100, 1000, 3.00, 4.00, '', '', '', 'static/upload/20240504/1714823333141316200.jpg', '', '', '', '', '', 0, 1, 1, 1, 0, 0, 1, 1593488894, NULL, NULL);
INSERT INTO `goods` VALUES (29, '烟台樱桃', '', 1, 100, 1000, 25.00, 30.00, '', '', '', 'static/upload/20240430/1714440697827923300.jpg', '', '', '', '', '<p>&nbsp; &nbsp; &nbsp; 烟台樱桃是中国山东省烟台市的特产之一，也是烟台市的名优特产之一。烟台樱桃以果实饱满、色泽鲜艳、口感甜脆、汁水丰富而闻名，被誉为&ldquo;水果之王&rdquo;。烟台樱桃树生长在烟台市的温和气候下，土壤肥沃，阳光充足，气候适宜，这些条件为烟台樱桃的生长提供了良好的环境。</p><p>&nbsp; &nbsp; &nbsp;欢迎选购烟台樱桃，每颗樱桃都是阳光和甜蜜的结晶，色泽鲜艳、口感甜脆，每一口都是对自然的味蕾享受。尽情享受烟台樱桃带来的清新甜美，让您的生活充满果香滋味。</p>', 0, 1, 1, 1, 0, 10, 1, 1593491318, NULL, NULL);
INSERT INTO `goods` VALUES (30, '苹果', '', 21, 100, 1000, 5.00, 100.00, '', '', '', 'static/upload/20240416/1713268030765432800.jpg', '', '', '', '', '<p><br></p><p><br></p><p><img src=\"http://bee.apiying.com/static/upload/20200706/1593999345774680300.jpg\" style=\"width: 300px;\" class=\"fr-fic fr-dib\"></p><p>苹果是一种常见的水果，具有丰富的营养价值和多种健康益处。以下是关于苹果的介绍：</p><p>外观特征：苹果通常呈圆形或椭圆形，表面光滑，颜色多样，有红色、黄色、绿色等不同品种。果皮薄而脆，果肉多汁。</p><p>营养价值：苹果富含维生素C、维生素K、纤维素、钾等营养物质。苹果中的纤维素有助于促进消化、降低胆固醇，维生素C有助于增强免疫力。</p><p>健康益处：苹果被认为有多种健康益处，包括：</p><p>有助于降低心血管疾病风险：苹果中的纤维素和抗氧化物质有助于降低胆固醇水平，保护心脏健康。</p><p>有助于控制体重：苹果中的纤维素有饱腹感，有助于控制饥饿感，帮助控制体重。</p><p>有助于预防癌症：苹果中的抗氧化物质有助于抵抗自由基，有助于预防癌症。</p><p>食用方式：苹果可以生吃、榨汁、烹饪等多种方式食用。生吃苹果可以保留最多的营养成分，榨汁可以制作苹果汁，烹饪可以制作苹果派、苹果酱等美食。</p><p>种植方式：苹果是一种常见的果树，适合在温和气候下种植。苹果树需要充足的阳光和适量的水分，通常在春季开花，秋季结果。</p><p>总的来说，苹果是一种美味、营养丰富的水果，具有多种健康益处。适量食用苹果有助于增加营养、促进健康，是人们日常饮食中常见的水果之一。</p><p><br></p>', 0, 1, 1, 1, 0, 0, 1, 1593999389, NULL, NULL);
INSERT INTO `goods` VALUES (35, '西瓜', '', 1, 100, 1000, 4.90, 6.00, '', '', '', 'static/upload/20240501/1714532912892640000.png', '', '', '', '', '<p>解暑的西瓜</p>', 0, 1, 1, 1, 0, 0, 0, 1714532912, NULL, NULL);

-- ----------------------------
-- Table structure for goods_attr
-- ----------------------------
DROP TABLE IF EXISTS `goods_attr`;
CREATE TABLE `goods_attr`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `goods_id` int NULL DEFAULT NULL,
  `attribute_cate_id` int NULL DEFAULT NULL,
  `attribute_id` int NULL DEFAULT NULL,
  `attribute_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `attribute_type` tinyint(1) NULL DEFAULT NULL,
  `attribute_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 252 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_attr
-- ----------------------------

-- ----------------------------
-- Table structure for goods_cate
-- ----------------------------
DROP TABLE IF EXISTS `goods_cate`;
CREATE TABLE `goods_cate`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cate_img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `template` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `pid` int NULL DEFAULT NULL COMMENT 'pid=0表示主界面左边导航栏',
  `sub_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `keywords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `description` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_cate
-- ----------------------------
INSERT INTO `goods_cate` VALUES (1, '经典水果', '', '', '', 0, '水果', '水果', '水果', 1, 10, 1582461745);
INSERT INTO `goods_cate` VALUES (2, '桃类', 'static/upload/20240415/1713173869710588800.jpg', 'http://localhost:8080/item_22.html', '', 1, '', '', '', 1, 3, 1582463294);
INSERT INTO `goods_cate` VALUES (4, '经典蔬菜', '', '', '', 0, '电视 盒子', '电视 盒子', '电视 盒子', 1, 9, 1582463515);
INSERT INTO `goods_cate` VALUES (5, '西红柿', 'static/upload/20240415/1713174147696337600.jpg', 'http://localhost:8080/item_21.html', '', 4, '', '', '', 1, 0, 1582464603);
INSERT INTO `goods_cate` VALUES (6, '高纤维', '', '', '', 0, '', '', '', 1, 0, 1582513219);
INSERT INTO `goods_cate` VALUES (7, '高蛋白', '', '', '', 0, '', '', '', 1, 0, 1582513235);
INSERT INTO `goods_cate` VALUES (8, '菌菇', '', '', '', 0, '', '', '', 1, 0, 1582513270);
INSERT INTO `goods_cate` VALUES (9, '减肥专区', '', '', '', 0, '', '', '', 1, 0, 1582513285);
INSERT INTO `goods_cate` VALUES (13, '地瓜类', 'static/upload/20240422/1713720184775584400.jpg', 'http://localhost:8080/item_28.html', '', 6, '', '', '', 1, 0, 1582513945);
INSERT INTO `goods_cate` VALUES (15, '蛋', 'static/upload/20240422/1713720215850083400.jpg', 'http://localhost:8080/item_23.html', '', 7, '', '', '', 1, 0, 1582514113);
INSERT INTO `goods_cate` VALUES (17, '香菇', 'static/upload/20240422/1713720267893617700.jpg', 'http://localhost:8080/item_19.html', '', 8, '', '', '', 1, 0, 1582514289);
INSERT INTO `goods_cate` VALUES (19, '青菜', 'static/upload/20240422/1713720435587016000.jpg', 'http://localhost:8080/item_20.html', '', 4, '', '', '', 1, 0, 1582514664);
INSERT INTO `goods_cate` VALUES (20, '淀粉专区', 'static/upload/20240422/1713719471862588400.jpg', 'http://localhost:8080/item_25.html', '', 9, '淀粉', '淀粉', '淀粉', 1, 0, 1582514810);
INSERT INTO `goods_cate` VALUES (21, '烟台特色苹果', 'static/upload/20240415/1713173004267631600.jpg', 'http://localhost:8080/item_30.html', '', 1, '', '', '', 1, 1, 1594088238);
INSERT INTO `goods_cate` VALUES (22, '经典坚果', '', '', '', 0, '', '', '', 1, 8, 1594088325);
INSERT INTO `goods_cate` VALUES (23, '婴儿推车', 'static/upload/20200707/1594089221653126500.jpg', '', '', 10, '', '', '', 1, 10, 1594089221);
INSERT INTO `goods_cate` VALUES (24, '小米小爱音箱', 'static/upload/20200707/1594089287177874300.png', '', '', 11, '', '', '', 1, 10, 1594089287);
INSERT INTO `goods_cate` VALUES (25, '小背包', 'static/upload/20200707/1594089350990524100.jpg', '', '', 12, '', '', '', 1, 10, 1594089350);
INSERT INTO `goods_cate` VALUES (26, '夏威夷果', 'static/upload/20240422/1713720062186438900.jpg', 'http://localhost:8080/item_24.html', '', 22, '', '', '', 1, 10, 1594089381);

-- ----------------------------
-- Table structure for goods_color
-- ----------------------------
DROP TABLE IF EXISTS `goods_color`;
CREATE TABLE `goods_color`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `color_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `color_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_color
-- ----------------------------
INSERT INTO `goods_color` VALUES (1, '红色', 'red', 1);
INSERT INTO `goods_color` VALUES (2, '黑色', '#000', 1);
INSERT INTO `goods_color` VALUES (3, '红色', 'yellow', 1);
INSERT INTO `goods_color` VALUES (4, '金色', '#ebf10f', 1);
INSERT INTO `goods_color` VALUES (5, '灰色', '#eee', 1);
INSERT INTO `goods_color` VALUES (6, '蓝色', 'blue', 1);
INSERT INTO `goods_color` VALUES (7, '紫色', '#B09AFE', 1);
INSERT INTO `goods_color` VALUES (8, '薄荷', '#A0FBE9', 1);

-- ----------------------------
-- Table structure for goods_image
-- ----------------------------
DROP TABLE IF EXISTS `goods_image`;
CREATE TABLE `goods_image`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `goods_id` int NULL DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `color_id` int NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 94 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_image
-- ----------------------------
INSERT INTO `goods_image` VALUES (13, 18, '/static/upload/20200617/1592391780837536200.jpg', 0, 10, 1592391786, 1);
INSERT INTO `goods_image` VALUES (14, 18, '/static/upload/20200617/1592391780895539500.jpg', 0, 10, 1592391786, 1);
INSERT INTO `goods_image` VALUES (15, 18, '/static/upload/20200617/1592391780954542900.jpg', 0, 10, 1592391786, 1);
INSERT INTO `goods_image` VALUES (16, 18, '/static/upload/20200617/1592391780954542900.jpg', 0, 0, 0, 0);
INSERT INTO `goods_image` VALUES (17, 18, '/static/upload/20200617/1592392823882194900.jpg', 0, 0, 0, 0);
INSERT INTO `goods_image` VALUES (58, 20, 'static/upload/20240418/1713371638421977500.jpg', 0, 10, 1713371700, 1);
INSERT INTO `goods_image` VALUES (59, 20, 'static/upload/20240418/1713371695228442000.jpg', 0, 10, 1713371700, 1);
INSERT INTO `goods_image` VALUES (60, 20, 'static/upload/20240418/1713371695350354800.jpg', 0, 10, 1713371700, 1);
INSERT INTO `goods_image` VALUES (65, 30, 'static/upload/20240421/1713669872181657000.jpg', 0, 10, 1713669873, 1);
INSERT INTO `goods_image` VALUES (66, 21, 'static/upload/20240421/1713671095018041500.jpg', 0, 10, 1713671100, 1);
INSERT INTO `goods_image` VALUES (67, 21, 'static/upload/20240421/1713671099105356500.jpg', 0, 10, 1713671100, 1);
INSERT INTO `goods_image` VALUES (68, 23, 'static/upload/20240421/1713671339751632400.jpg', 0, 10, 1713671341, 1);
INSERT INTO `goods_image` VALUES (70, 24, 'static/upload/20240421/1713671599353256000.jpg', 0, 10, 1713671603, 1);
INSERT INTO `goods_image` VALUES (75, 22, 'static/upload/20240421/1713679847096727400.jpg', 0, 10, 1713679848, 1);
INSERT INTO `goods_image` VALUES (77, 22, 'static/upload/20240421/1713680370830794300.jpg', 0, 10, 1713680372, 1);
INSERT INTO `goods_image` VALUES (78, 19, 'static/upload/20240421/1713688358526483800.jpeg', 0, 10, 1713688359, 1);
INSERT INTO `goods_image` VALUES (80, 25, 'static/upload/20240422/1713719366314630000.jpg', 0, 10, 1713719367, 1);
INSERT INTO `goods_image` VALUES (82, 25, 'static/upload/20240422/1713719366354854700.jpg', 0, 10, 1713719367, 1);
INSERT INTO `goods_image` VALUES (83, 29, 'static/upload/20240430/1714440696378374300.jpg', 0, 10, 1714440697, 1);
INSERT INTO `goods_image` VALUES (84, 35, 'static/upload/20240501/1714532883334412900.png', 0, 10, 1714532912, 1);
INSERT INTO `goods_image` VALUES (85, 29, 'static/upload/20240503/1714742131751899700.jpg', 0, 10, 1714742140, 1);
INSERT INTO `goods_image` VALUES (87, 36, 'static/upload/20240504/1714837680053583000.jpg', 0, 10, 1714837687, 1);
INSERT INTO `goods_image` VALUES (88, 37, 'static/upload/20240506/1714981400985178100.jpg', 0, 10, 1714981402, 1);
INSERT INTO `goods_image` VALUES (89, 37, 'static/upload/20240506/1714981401005540500.jpg', 0, 10, 1714981402, 1);
INSERT INTO `goods_image` VALUES (90, 28, 'static/upload/20240508/1715098153529353700.jpg', 0, 10, 1715098160, 1);
INSERT INTO `goods_image` VALUES (91, 52, 'static/upload/20240511/1715432381112062800.jpg', 0, 10, 1715432391, 1);
INSERT INTO `goods_image` VALUES (92, 52, 'static/upload/20240511/1715432381133874600.jpg', 0, 10, 1715432391, 1);
INSERT INTO `goods_image` VALUES (93, 52, 'static/upload/20240511/1715432381153377200.jpg', 0, 10, 1715432391, 1);

-- ----------------------------
-- Table structure for goods_sale_num
-- ----------------------------
DROP TABLE IF EXISTS `goods_sale_num`;
CREATE TABLE `goods_sale_num`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `goods_id` int NULL DEFAULT NULL,
  `saled_num` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_id`(`goods_id` ASC) USING BTREE,
  CONSTRAINT `goods_id` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_sale_num
-- ----------------------------
INSERT INTO `goods_sale_num` VALUES (1, 19, 122);
INSERT INTO `goods_sale_num` VALUES (2, 20, 222);
INSERT INTO `goods_sale_num` VALUES (3, 21, 520);
INSERT INTO `goods_sale_num` VALUES (4, 22, 852);
INSERT INTO `goods_sale_num` VALUES (5, 23, 450);
INSERT INTO `goods_sale_num` VALUES (6, 24, 222);
INSERT INTO `goods_sale_num` VALUES (7, 25, 480);
INSERT INTO `goods_sale_num` VALUES (8, 28, 399);
INSERT INTO `goods_sale_num` VALUES (9, 29, 499);
INSERT INTO `goods_sale_num` VALUES (10, 30, 211);

-- ----------------------------
-- Table structure for goods_type_attribute
-- ----------------------------
DROP TABLE IF EXISTS `goods_type_attribute`;
CREATE TABLE `goods_type_attribute`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cate_id` int NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `attr_type` tinyint(1) NULL DEFAULT NULL,
  `attr_value` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods_type_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `password` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `mobile` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT 1,
  `role_id` int NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  `is_super` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '15201686411', '518864@qq.com', 1, 12, 0, 1);
INSERT INTO `manager` VALUES (2, 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '15201686419', '34233869@qq.com', 1, 2, 1581661532, 0);
INSERT INTO `manager` VALUES (7, 'lisi', 'e10adc3949ba59abbe56e057f20f883e', '15111324214', '3333498@qq.com', 1, 14, 1591078419, 0);

-- ----------------------------
-- Table structure for nav
-- ----------------------------
DROP TABLE IF EXISTS `nav`;
CREATE TABLE `nav`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `position` tinyint(1) NULL DEFAULT NULL COMMENT '1的话是最顶部（黑色）的导航栏\r\n2为中部导航栏',
  `is_opennew` tinyint(1) NULL DEFAULT NULL,
  `relation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nav
-- ----------------------------
INSERT INTO `nav` VALUES (1, '热卖商城', 'http://www.itying.com', 2, 2, '21,22,23,24', 10, 0, 1592919226);
INSERT INTO `nav` VALUES (3, '精品果蔬', 'https://shouji.mi.com/', 2, 2, '19,20', 10, 0, 1592922081);
INSERT INTO `nav` VALUES (4, '水果拼盘', 'https://ds.mi.com/', 2, 2, '23,24', 10, 0, 1592922273);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NULL DEFAULT NULL,
  `order_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `all_price` decimal(10, 2) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `zipcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pay_status` tinyint(1) NULL DEFAULT NULL,
  `pay_type` tinyint(1) NULL DEFAULT NULL,
  `order_status` tinyint(1) NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (37, 5, '2024041200396367', 0.00, 'Nap', '19861129871', '鲁东大学', '', 0, 0, 6, 1712853593);
INSERT INTO `order` VALUES (38, 11, '2024041318581473', 2999.00, 'Nap', '19861129871', '山东省烟台市鲁东大学北区', '4302', 0, 0, 0, 1713005883);
INSERT INTO `order` VALUES (39, 11, '2024041320109338', 549.00, 'Nap', '19861129871', '山东省烟台市鲁东大学北区', '4302', 0, 0, 0, 1713010233);
INSERT INTO `order` VALUES (40, 11, '2024041423160356', 549.00, 'Nap', '19861129871', '山东省烟台市鲁东大学北区', '4302', 0, 0, 0, 1713107809);
INSERT INTO `order` VALUES (41, 11, '2024041620031566', 20.00, 'Nap', '19861129871', '山东省烟台市鲁东大学北区', '4302', 0, 0, 0, 1713269005);
INSERT INTO `order` VALUES (42, 11, '2024041622038869', 10.00, 'Nap', '19861129871', '山东省烟台市鲁东大学北区', '4302', 0, 0, 4, 1713276228);
INSERT INTO `order` VALUES (43, 10, '2024041708559919', 10.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 0, 0, 2, 1713315310);
INSERT INTO `order` VALUES (44, 10, '2024041708567192', 10.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 0, 0, 0, 1713315417);
INSERT INTO `order` VALUES (46, 10, '2024041801085690', 30.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 0, 0, 0, 1713373691);
INSERT INTO `order` VALUES (47, 10, '2024042016219902', 30.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 0, 0, 0, 1713601285);
INSERT INTO `order` VALUES (48, 10, '2024042117059152', 40.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 0, 0, 0, 1713690329);
INSERT INTO `order` VALUES (49, 10, '2024042117077093', 10.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 0, 0, 0, 1713690477);
INSERT INTO `order` VALUES (50, 14, '2024042117167358', 300.00, 'zp', '12222222222', '123', '123', 0, 0, 0, 1713690984);
INSERT INTO `order` VALUES (51, 10, '2024042119492815', 0.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 2, 1713700192);
INSERT INTO `order` VALUES (52, 15, '2024042119517817', 14.00, '刘鹏', '13153011482', '设实数', '1111', 0, 0, 0, 1713700307);
INSERT INTO `order` VALUES (53, 10, '2024042120086119', 10.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 0, 0, 0, 1713701285);
INSERT INTO `order` VALUES (54, 10, '2024042120226812', 20.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 1, 1713702168);
INSERT INTO `order` VALUES (55, 10, '2024042120482187', 10.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 1, 1713703715);
INSERT INTO `order` VALUES (56, 10, '2024042200437835', 10.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 1, 1713717781);
INSERT INTO `order` VALUES (57, 15, '2024042618504923', 10.00, '刘鹏', '13153011482', '设实数', '1111', 1, 0, 1, 1714128602);
INSERT INTO `order` VALUES (63, 10, '2024042619536684', 100.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 1, 1714132438);
INSERT INTO `order` VALUES (64, 15, '2024042620025915', 10.00, '刘鹏', '13153011482', '设实数', '1111', 1, 0, 1, 1714132930);
INSERT INTO `order` VALUES (65, 15, '2024042620027845', 4499.00, '刘鹏', '13153011482', '设实数', '1111', 1, 0, 1, 1714132978);
INSERT INTO `order` VALUES (66, 10, '2024042700281977', 0.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 6, 1714148893);
INSERT INTO `order` VALUES (67, 10, '2024042719043378', 4111.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 1, 1714215867);
INSERT INTO `order` VALUES (68, 10, '2024042719316531', 10.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 1, 1714217466);
INSERT INTO `order` VALUES (69, 10, '2024043009330239', 1898.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 1, 1714440838);
INSERT INTO `order` VALUES (70, 10, '2024043009483781', 949.00, 'zhangsan', '15264111521', '北京市海淀区', '10000', 1, 0, 1, 1714441695);
INSERT INTO `order` VALUES (71, 10, '2024050110599135', 40.00, '郑攀', '19861129871', '111111111', '111', 1, 0, 1, 1714532355);
INSERT INTO `order` VALUES (72, 10, '2024050220347696', 4509.00, '郑攀', '19861129871', '111111111', '111', 0, 0, 0, 1714653241);
INSERT INTO `order` VALUES (73, 10, '2024050319346392', 10.00, '郑攀', '19861129871', '111111111', '111', 1, 0, 1, 1714736066);
INSERT INTO `order` VALUES (74, 10, '2024050321350037', 70.00, '郑攀', '19861129871', '山东省烟台市鲁东大学北区菜鸟驿站', '264025', 1, 0, 1, 1714743324);
INSERT INTO `order` VALUES (75, 10, '2024050811067204', 17.00, '郑攀', '19861129871', '山东省烟台市鲁东大学北区菜鸟驿站', '264025', 0, 0, 0, 1715137566);
INSERT INTO `order` VALUES (76, 23, '2024051114393061', 12.00, 'Nap', '19861129871', '山东省烟台市鲁东大学北区菜鸟驿站', '264025', 1, 0, 1, 1715409598);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NULL DEFAULT NULL,
  `uid` int NULL DEFAULT NULL,
  `product_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `product_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `product_price` decimal(10, 2) NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  `product_num` int NULL DEFAULT NULL,
  `goods_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 94 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (27, 23, 9, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 1, 'Redmi K30 5G', '蓝色');
INSERT INTO `order_item` VALUES (28, 23, 9, 'Redmi K30 系列-Redmi K30 4G', 33, 'static/upload/20200717/1594971710634525600.jpg', 1599.00, 0, 1, 'Redmi K30 4G', '蓝色');
INSERT INTO `order_item` VALUES (29, 23, 9, '小米8年度旗舰222', 21, 'static/upload/20200618/1592452490474942700.jpg', 1112.00, 0, 1, '3GB+32GB', '黑色');
INSERT INTO `order_item` VALUES (30, 24, 10, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 1, 'Redmi K30 5G', '蓝色');
INSERT INTO `order_item` VALUES (31, 25, 10, 'Redmi K30 系列-Redmi K30 4G', 33, 'static/upload/20200717/1594971710634525600.jpg', 1599.00, 0, 1, 'Redmi K30 4G', '蓝色');
INSERT INTO `order_item` VALUES (32, 25, 10, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 2, 'Redmi K30 5G', '蓝色');
INSERT INTO `order_item` VALUES (33, 26, 10, '小米9', 19, 'static/upload/20200617/1592392307796676500.jpg', 1299.00, 0, 1, '8GB+256GB', '黑色');
INSERT INTO `order_item` VALUES (34, 27, 10, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 1, 'Redmi K30 5G', '蓝色');
INSERT INTO `order_item` VALUES (35, 27, 10, '小米8年度旗舰222', 21, 'static/upload/20200618/1592452490474942700.jpg', 1112.00, 0, 1, '3GB+32GB', '黑色');
INSERT INTO `order_item` VALUES (36, 28, 10, 'Redmi K30 系列-Redmi K30 4G', 33, 'static/upload/20200717/1594971710634525600.jpg', 1599.00, 0, 1, 'Redmi K30 4G', '蓝色');
INSERT INTO `order_item` VALUES (37, 29, 6, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 1, 'Redmi K30 5G', '蓝色');
INSERT INTO `order_item` VALUES (38, 29, 6, 'Redmi K30 系列-Redmi K30 4G', 33, 'static/upload/20200717/1594971710634525600.jpg', 1599.00, 0, 1, 'Redmi K30 4G', '蓝色');
INSERT INTO `order_item` VALUES (39, 30, 6, '小米8年度旗舰222', 21, 'static/upload/20200618/1592452490474942700.jpg', 1112.00, 0, 1, '3GB+32GB', '黑色');
INSERT INTO `order_item` VALUES (40, 31, 6, '小米8年度旗舰222', 21, 'static/upload/20200618/1592452490474942700.jpg', 1112.00, 0, 1, '3GB+32GB', '黑色');
INSERT INTO `order_item` VALUES (41, 31, 6, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 1, 'Redmi K30 5G', '蓝色');
INSERT INTO `order_item` VALUES (42, 32, 6, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 1, 'Redmi K30 5G', '蓝色');
INSERT INTO `order_item` VALUES (43, 32, 6, 'Redmi K30 系列-Redmi K30 4G', 33, 'static/upload/20200717/1594971710634525600.jpg', 1599.00, 0, 1, 'Redmi K30 4G', '蓝色');
INSERT INTO `order_item` VALUES (44, 33, 6, '小米8年度旗舰222', 21, 'static/upload/20200618/1592452490474942700.jpg', 1112.00, 0, 1, '3GB+32GB', '黑色');
INSERT INTO `order_item` VALUES (45, 33, 6, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 1, 'Redmi K30 5G', '蓝色');
INSERT INTO `order_item` VALUES (46, 34, 6, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 1, 'Redmi K30 5G', '蓝色');
INSERT INTO `order_item` VALUES (47, 34, 6, '小米8年度旗舰222', 21, 'static/upload/20200618/1592452490474942700.jpg', 1112.00, 0, 1, '3GB+32GB', '黑色');
INSERT INTO `order_item` VALUES (48, 35, 6, 'Redmi K30 系列-Redmi K30 4G', 33, 'static/upload/20200717/1594971710634525600.jpg', 1599.00, 0, 1, 'Redmi K30 4G', '蓝色');
INSERT INTO `order_item` VALUES (49, 36, 6, 'Redmi K30 系列-Redmi K30 4G', 33, 'static/upload/20200717/1594971710634525600.jpg', 1599.00, 0, 1, 'Redmi K30 4G', '蓝色');
INSERT INTO `order_item` VALUES (50, 36, 6, 'Redmi K30 系列-Redmi K30 5G', 34, 'static/upload/20200717/1594973579432414700.jpg', 2399.00, 0, 1, 'Redmi K30 5G', '薄荷');
INSERT INTO `order_item` VALUES (51, 37, 5, '小米8年度旗舰222', 21, 'static/upload/20200618/1592452490474942700.jpg', 1112.00, 0, 1, '3GB+32GB', '黑色');
INSERT INTO `order_item` VALUES (52, 38, 11, 'Redmi 智能电视 X65', 23, 'static/upload/20200622/1592820111.jpg', 2999.00, 0, 1, '56寸', '金色');
INSERT INTO `order_item` VALUES (53, 39, 11, 'Redmi 7A', 22, 'static/upload/20200622/1592820040.jpg', 549.00, 0, 1, '3GB+32GB', '红色');
INSERT INTO `order_item` VALUES (54, 40, 11, 'Redmi 7A', 22, 'static/upload/20200622/1592820040.jpg', 549.00, 0, 1, '3GB+32GB', '红色');
INSERT INTO `order_item` VALUES (55, 41, 11, '巨甜水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 2, '3GB+32GB', '红色');
INSERT INTO `order_item` VALUES (56, 42, 11, '巨甜水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '3GB+32GB', '红色');
INSERT INTO `order_item` VALUES (57, 43, 10, '巨甜水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '3GB+32GB', '红色');
INSERT INTO `order_item` VALUES (58, 44, 10, '巨甜水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '3GB+32GB', '红色');
INSERT INTO `order_item` VALUES (59, 45, 10, '巨甜水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '3GB+32GB', '红色');
INSERT INTO `order_item` VALUES (60, 46, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 3, '', '红色');
INSERT INTO `order_item` VALUES (61, 47, 10, '蘑菇', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 3, '', '红色');
INSERT INTO `order_item` VALUES (62, 48, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 3, '', '红色');
INSERT INTO `order_item` VALUES (63, 48, 10, '苹果', 30, 'static/upload/20240416/1713268030765432800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (64, 49, 10, '苹果', 30, 'static/upload/20240416/1713268030765432800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (65, 50, 14, '苹果', 30, 'static/upload/20240416/1713268030765432800.jpg', 10.00, 0, 30, '', '红色');
INSERT INTO `order_item` VALUES (66, 51, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (67, 52, 15, '蘑菇', 19, 'static/upload/20240421/1713688359499803200.jpeg', 4.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (68, 52, 15, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (69, 53, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (70, 54, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 2, '', '红色');
INSERT INTO `order_item` VALUES (71, 55, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (72, 56, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (73, 57, 15, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (74, 63, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 10, '', '红色');
INSERT INTO `order_item` VALUES (75, 64, 15, '苹果', 30, 'static/upload/20240416/1713268030765432800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (76, 65, 15, '夏威夷果', 24, 'static/upload/20240421/1713671603103639400.jpg', 4499.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (77, 66, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 7, '', '红色');
INSERT INTO `order_item` VALUES (78, 67, 10, '鸡蛋', 23, 'static/upload/20240421/1713671341200706900.jpg', 2999.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (79, 67, 10, '西红柿', 21, 'static/upload/20240421/1713671118760359000.jpg', 1112.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (80, 68, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (81, 69, 10, '烟台樱桃', 29, 'static/upload/20240430/1714440697827923300.jpg', 949.00, 0, 2, '', '红色');
INSERT INTO `order_item` VALUES (82, 70, 10, '烟台樱桃', 29, 'static/upload/20240430/1714440697827923300.jpg', 949.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (83, 71, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 4, '', '红色');
INSERT INTO `order_item` VALUES (84, 72, 10, '夏威夷果', 24, 'static/upload/20240421/1713671603103639400.jpg', 4499.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (85, 72, 10, '苹果', 30, 'static/upload/20240416/1713268030765432800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (86, 73, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 10.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (87, 74, 10, '水蜜桃', 22, 'static/upload/20240416/1713267964258120800.jpg', 20.00, 0, 2, '', '红色');
INSERT INTO `order_item` VALUES (88, 74, 10, '烟台樱桃', 29, 'static/upload/20240430/1714440697827923300.jpg', 25.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (89, 74, 10, '苹果', 30, 'static/upload/20240416/1713268030765432800.jpg', 5.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (90, 75, 10, '苹果', 30, 'static/upload/20240416/1713268030765432800.jpg', 5.00, 0, 2, '', '红色');
INSERT INTO `order_item` VALUES (91, 75, 10, '蘑菇', 19, 'static/upload/20240421/1713688359499803200.jpeg', 4.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (92, 75, 10, '地瓜', 28, 'static/upload/20240504/1714823333141316200.jpg', 3.00, 0, 1, '', '红色');
INSERT INTO `order_item` VALUES (93, 76, 23, '蘑菇', 19, 'static/upload/20240508/1715127198079315300.jpg', 4.00, 0, 3, '', '红色');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (2, '销售部门', '通常负责公司的销售业务，包括销售策略制定、客户关系管理、销售团队管理、销售业绩评估等工作', 1, 1591061390);
INSERT INTO `role` VALUES (4, '编辑部门', '编辑部门通常是一个组织内负责编辑工作的部门，主要职责是编辑和校对组织内部或外部的文档、出版物、内容等', 1, 1591062092);
INSERT INTO `role` VALUES (12, '市场部门', '市场部门是一个组织内负责市场营销和推广的部门，主要职责是制定和执行市场营销策略，促进产品或服务的销售和品牌推广', 1, 1591073860);
INSERT INTO `role` VALUES (14, '软件部门', '软件部门是一个组织内负责软件开发和维护的部门，主要职责是开发、测试和维护组织的软件应用程序，以满足业务需求和客户需求', 1, 1715409862);

-- ----------------------------
-- Table structure for role_access
-- ----------------------------
DROP TABLE IF EXISTS `role_access`;
CREATE TABLE `role_access`  (
  `role_id` int NOT NULL,
  `access_id` int NOT NULL,
  PRIMARY KEY (`role_id`, `access_id`) USING BTREE,
  INDEX `role_access_access_id_Access_Id_foreign`(`access_id` ASC) USING BTREE,
  CONSTRAINT `role_access_access_id_Access_Id_foreign` FOREIGN KEY (`access_id`) REFERENCES `access` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_access
-- ----------------------------
INSERT INTO `role_access` VALUES (2, 52);
INSERT INTO `role_access` VALUES (11, 52);
INSERT INTO `role_access` VALUES (12, 52);
INSERT INTO `role_access` VALUES (4, 53);
INSERT INTO `role_access` VALUES (11, 53);
INSERT INTO `role_access` VALUES (14, 53);
INSERT INTO `role_access` VALUES (2, 54);
INSERT INTO `role_access` VALUES (11, 54);
INSERT INTO `role_access` VALUES (12, 54);
INSERT INTO `role_access` VALUES (2, 55);
INSERT INTO `role_access` VALUES (11, 55);
INSERT INTO `role_access` VALUES (12, 55);
INSERT INTO `role_access` VALUES (2, 56);
INSERT INTO `role_access` VALUES (11, 56);
INSERT INTO `role_access` VALUES (12, 56);
INSERT INTO `role_access` VALUES (2, 57);
INSERT INTO `role_access` VALUES (11, 57);
INSERT INTO `role_access` VALUES (12, 57);
INSERT INTO `role_access` VALUES (4, 59);
INSERT INTO `role_access` VALUES (11, 59);
INSERT INTO `role_access` VALUES (14, 59);
INSERT INTO `role_access` VALUES (4, 60);
INSERT INTO `role_access` VALUES (11, 60);
INSERT INTO `role_access` VALUES (14, 60);
INSERT INTO `role_access` VALUES (12, 64);
INSERT INTO `role_access` VALUES (12, 65);
INSERT INTO `role_access` VALUES (4, 72);
INSERT INTO `role_access` VALUES (11, 72);
INSERT INTO `role_access` VALUES (14, 72);
INSERT INTO `role_access` VALUES (4, 73);
INSERT INTO `role_access` VALUES (14, 73);
INSERT INTO `role_access` VALUES (12, 74);
INSERT INTO `role_access` VALUES (11, 78);
INSERT INTO `role_access` VALUES (11, 79);
INSERT INTO `role_access` VALUES (11, 80);
INSERT INTO `role_access` VALUES (14, 80);
INSERT INTO `role_access` VALUES (11, 81);
INSERT INTO `role_access` VALUES (14, 81);
INSERT INTO `role_access` VALUES (11, 82);
INSERT INTO `role_access` VALUES (14, 82);
INSERT INTO `role_access` VALUES (11, 83);
INSERT INTO `role_access` VALUES (14, 83);
INSERT INTO `role_access` VALUES (14, 89);
INSERT INTO `role_access` VALUES (14, 90);
INSERT INTO `role_access` VALUES (14, 91);
INSERT INTO `role_access` VALUES (14, 92);
INSERT INTO `role_access` VALUES (14, 93);
INSERT INTO `role_access` VALUES (14, 94);
INSERT INTO `role_access` VALUES (14, 95);
INSERT INTO `role_access` VALUES (14, 96);
INSERT INTO `role_access` VALUES (14, 97);
INSERT INTO `role_access` VALUES (14, 98);
INSERT INTO `role_access` VALUES (14, 99);
INSERT INTO `role_access` VALUES (14, 100);
INSERT INTO `role_access` VALUES (14, 101);
INSERT INTO `role_access` VALUES (14, 102);
INSERT INTO `role_access` VALUES (14, 103);
INSERT INTO `role_access` VALUES (14, 105);
INSERT INTO `role_access` VALUES (14, 106);
INSERT INTO `role_access` VALUES (14, 108);
INSERT INTO `role_access` VALUES (14, 109);
INSERT INTO `role_access` VALUES (14, 111);
INSERT INTO `role_access` VALUES (14, 112);
INSERT INTO `role_access` VALUES (14, 113);
INSERT INTO `role_access` VALUES (14, 114);
INSERT INTO `role_access` VALUES (14, 115);
INSERT INTO `role_access` VALUES (14, 125);
INSERT INTO `role_access` VALUES (14, 126);
INSERT INTO `role_access` VALUES (14, 127);
INSERT INTO `role_access` VALUES (14, 128);

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `site_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `site_logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `site_keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `site_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `no_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `site_icp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `site_tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `search_keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tongji_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `appid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `app_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `end_point` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of setting
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `last_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (6, 'fcea920f7412b5da7be0cf42b8c93759', '15201686411', '[', '', 0, 0);
INSERT INTO `user` VALUES (7, 'e10adc3949ba59abbe56e057f20f883e', '15201686410', '[', '', 0, 0);
INSERT INTO `user` VALUES (8, 'e10adc3949ba59abbe56e057f20f883e', '15201686444', '[', '', 0, 0);
INSERT INTO `user` VALUES (9, 'e10adc3949ba59abbe56e057f20f883e', '15201686459', '[', '', 0, 0);
INSERT INTO `user` VALUES (10, 'e10adc3949ba59abbe56e057f20f883e', '19861129871', '[', '', 0, 0);
INSERT INTO `user` VALUES (11, 'e10adc3949ba59abbe56e057f20f883e', '19861129878', '[', '', 0, 0);
INSERT INTO `user` VALUES (12, '272e7b02a23578284113b15ba99ba770', '13135241819', '[', '', 0, 0);
INSERT INTO `user` VALUES (13, '25f9e794323b453885f5181f1b624d0b', '19861129872', '[', '', 0, 0);
INSERT INTO `user` VALUES (14, 'e10adc3949ba59abbe56e057f20f883e', '18888888888', '192.168.3.10', '', 0, 0);
INSERT INTO `user` VALUES (15, 'e10adc3949ba59abbe56e057f20f883e', '19853506677', '192.168.3.45', '', 0, 0);
INSERT INTO `user` VALUES (16, 'e10adc3949ba59abbe56e057f20f883e', '19815455587', '[', '', 0, 0);
INSERT INTO `user` VALUES (17, 'e10adc3949ba59abbe56e057f20f883e', '11132324343', '192.168.3.177', '', 0, 0);
INSERT INTO `user` VALUES (19, 'e10adc3949ba59abbe56e057f20f883e', '19861129257', '192.168.3.152', '', 0, 0);
INSERT INTO `user` VALUES (20, 'e10adc3949ba59abbe56e057f20f883e', '00000000000', '[', '', 0, 0);
INSERT INTO `user` VALUES (21, '25f9e794323b453885f5181f1b624d0b', '19861129999', '[', '', 0, 0);
INSERT INTO `user` VALUES (22, 'e10adc3949ba59abbe56e057f20f883e', '19861129888', '[', '', 0, 0);
INSERT INTO `user` VALUES (23, '73882ab1fa529d7273da0db6b49cc4f3', '19861129877', '[', '', 0, 0);

-- ----------------------------
-- Table structure for user_temp
-- ----------------------------
DROP TABLE IF EXISTS `user_temp`;
CREATE TABLE `user_temp`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `send_count` int NULL DEFAULT NULL,
  `add_day` int NULL DEFAULT NULL,
  `add_time` int NULL DEFAULT NULL,
  `sign` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_temp
-- ----------------------------
INSERT INTO `user_temp` VALUES (40, '[', '19861129871', 2, 20240412, 1712903019, '6c01e0f43e5855489864461c803e201d');
INSERT INTO `user_temp` VALUES (41, '[', '18968435284', 2, 20240413, 1712993861, '10ea345191cfbcff8c0d5fc0b7c89828');
INSERT INTO `user_temp` VALUES (42, '[', '19861129873', 2, 20240413, 1712996155, '0d62c92fe5584a9098b3d9ec9d826773');
INSERT INTO `user_temp` VALUES (43, '[', '19861129877', 5, 20240413, 1712996914, '2cdca2b47a4a3e42bb9329f72e3c835c');
INSERT INTO `user_temp` VALUES (44, '[', '19861129874', 2, 20240413, 1712997953, '614454eac6af28c8b17e5763689706b5');
INSERT INTO `user_temp` VALUES (45, '[', '19861129876', 2, 20240413, 1712998529, '2143a4b889f9fe15e6c7c8334ecaad1c');
INSERT INTO `user_temp` VALUES (46, '[', '19861129878', 1, 20240413, 1712998925, 'b2610d7bfc5cd5c486f6b1056e948fa1');
INSERT INTO `user_temp` VALUES (47, '[', '13135241819', 1, 20240417, 1713283267, '86ee0cf623312ccadc0cd6c8ee201341');
INSERT INTO `user_temp` VALUES (48, '[', '19861129872', 1, 20240417, 1713318227, 'dcc159ac057a4dc01b7584b0bac4f53d');
INSERT INTO `user_temp` VALUES (49, '192.168.3.10', '18888888888', 1, 20240421, 1713690861, '709ff120fcb2634fdf13bf8fd6dce95a');
INSERT INTO `user_temp` VALUES (50, '192.168.3.45', '19853506677', 2, 20240421, 1713691471, 'a3051c0a5aa431012644ac7735ece4dc');
INSERT INTO `user_temp` VALUES (51, '[', '19815455587', 1, 20240503, 1714724688, '5cb66ca40824a529d47c5b284127f153');
INSERT INTO `user_temp` VALUES (52, '[', '19861129845', 1, 20240503, 1714735309, '13c0d701647565c9d90950f70a82045a');
INSERT INTO `user_temp` VALUES (53, '192.168.3.177', '11132324343', 1, 20240503, 1714736300, 'c07087e1f03d88dd9c7aaff1a5ff7336');
INSERT INTO `user_temp` VALUES (54, '192.168.3.152', '19861129257', 1, 20240503, 1714736863, '44ddc39f21ba2cdbcddbf84b9e97501b');
INSERT INTO `user_temp` VALUES (55, '[', '00000000000', 1, 20240507, 1715048272, '9332074f1bc87c474054beb9f10d454f');
INSERT INTO `user_temp` VALUES (56, '[', '12345678901', 9, 20240507, 1715087577, '0ff6cc606564c7dab23cd8bf5de959ca');
INSERT INTO `user_temp` VALUES (57, '[', '12345678902', 1, 20240507, 1715088282, 'd91df56602f57b409f9f7ffede5d6dd2');
INSERT INTO `user_temp` VALUES (58, '[', '19861129999', 1, 20240507, 1715095966, 'c3593a247fcc5e56daa05fe4bbed64aa');
INSERT INTO `user_temp` VALUES (59, '[', '19861129888', 1, 20240507, 1715096007, '5762cce08d00e6ecb49f03f6927819b1');
INSERT INTO `user_temp` VALUES (60, '[', '19861129877', 1, 20240511, 1715408988, '3f8352c49210f8eb3f34094f23f408aa');

SET FOREIGN_KEY_CHECKS = 1;
