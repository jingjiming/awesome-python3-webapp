/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : awesome

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 29/04/2021 09:39:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blogs
-- ----------------------------
DROP TABLE IF EXISTS `blogs`;
CREATE TABLE `blogs`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_image` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `summary` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` double NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_at`(`created_at`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blogs
-- ----------------------------
INSERT INTO `blogs` VALUES ('0016116407379839420db908eee4c7eaed6333ce4ea59b5000', '0016080262798593075820ecd7643cf848f5da78c043676000', 'admin', 'http://www.gravatar.com/avatar/87f73fde37b1172357f5cbb3b4f9bc41?d=mm&s=120', '31省区市新确诊82例 吉林死亡1例', '风中的人都自以为坚毅，却都缩着脖子。', '1月25日0—24时，31个省（自治区、直辖市）和新疆生产建设兵团报告新增确诊病例82例，其中境外输入病例13例（上海8例，广东2例，福建1例，湖南1例，陕西1例），本土病例69例（黑龙江53例，吉林7例，河北5例，北京2例，上海2例）；新增死亡病例1例，为本土病例，在吉林；新增疑似病例3例，均为境外输入病例（均在上海）。\n\n当日新增治愈出院病例46例，解除医学观察的密切接触者1351人，重症病例较前一日增加1例。\n\n境外输入现有确诊病例292例（其中重症病例3例），现有疑似病例4例。累计确诊病例4624例，累计治愈出院病例4332例，无死亡病例。\n\n截至1月25日24时，据31个省（自治区、直辖市）和新疆生产建设兵团报告，现有确诊病例1885例（其中重症病例110例），累计治愈出院病例82676例，累计死亡病例4636例，累计报告确诊病例89197例，现有疑似病例4例。累计追踪到密切接触者957984人，尚在医学观察的密切接触者38443人。\n\n31个省（自治区、直辖市）和新疆生产建设兵团报告新增无症状感染者57例（境外输入16例）；当日转为确诊病例35例（境外输入1例）；当日解除医学观察25例（境外输入9例）；尚在医学观察无症状感染者956例（境外输入283例）。\n\n累计收到港澳台地区通报确诊病例11094例。其中，香港特别行政区10158例（出院9056例，死亡171例），澳门特别行政区47例（出院46例），台湾地区889例（出院787例，死亡7例）。\n\n（注：媒体引用时，请标注“信息来自国家卫生健康委员会官方网站”。）', 1611640737.98308);
INSERT INTO `blogs` VALUES ('001611640802133cb10f7148af745b59bd9c1a11a12b6f9000', '0016080262798593075820ecd7643cf848f5da78c043676000', 'admin', 'http://www.gravatar.com/avatar/87f73fde37b1172357f5cbb3b4f9bc41?d=mm&s=120', '敦煌万亩沙漠防护林被毁？官方通报', '敦煌万亩沙漠防护林被毁?官方通报:未发现林地大面积...', '26日上午，甘肃省举行敦煌市阳关林场防护林被毁问题调查情况新闻发布会，调查组在会上通报：\n\n经过历年卫星遥感资料比对分析，2000年以来，未发现林地大面积减少情况。2018年至2019年间卫星遥感数据显示，林场范围内有3处面积约42.98亩的疑似林地破坏图斑，经现场核查，主要是阳关林场进行基础设施改造，新修砂石道路和U型灌渠、铺设管线灌线造成的，未发现砍树开垦葡萄园地情况。根据最新的卫星遥感数据测算，阳关林场区域内现有防护林面积6979亩。\n\n媒体反映的“2万多亩林地”实际上是林场经营管理面积，“1.3万亩生态林面积”实际上包括林场乔木林地、灌木林地、苗圃地、葡萄园地和部分未成林造林地，以及道路、水域、建设用地等林场生产生活用地。\n\n阳关林场经营管理区域大致可分为西南和东北两大片，这1.33万亩林地实际上是西南方位的这一片区域，林场范围内长期以来只有6000余亩防护林，基本都位于林场西南片区。\n\n根据调查，2006年林场承包改制时实有葡萄园地面积3304亩。通过卫星遥感资料比对，2006年至2011年间，葡萄园地面积没有发生变化。2012年，承租林地的敦煌葡萄酒业公司通过残次林改造，新建葡萄园地400亩。至此，林场实有葡萄园地面积3704亩。2013年以来，葡萄园面积再无增加。\n\n同时，调查组还查阅了三次全国土地调查数据。1999年“一调”显示，阳关林场有水浇地1488亩，果园2688亩，共计4176亩；2009年“二调”显示，阳关林场有水浇地2亩，果园4452亩，共计4454亩；2019年“三调”显示，林场有水浇地19亩，果园4706亩，共计4725亩。从1999年至2019年，水浇地和果园面积增加549亩。扣除道路、沟渠、田埂等占地因素，土地调查数据和卫星遥感资料比对数据基本一致。\n\n调查组通过现场调查还掌握到，阳关林场管理比较粗放，日常工作存在薄弱环节，导致媒体反映的一些问题的发生。一是林木抚育工作不够规范。二是林木更新采伐管理不够到位。三是水资源节约利用不够。四是存在违规承租和协调不力问题。其中，近年来，敦煌飞天公司自身发展利益与群众利益以及生态保护要求的分歧越发突出，并出现矛盾纠纷，省、市多次组织工作组调查并指导问题整改和矛盾化解工作，但因飞天公司诉求过高，导致矛盾无法彻底化解，问题仍未整改到位。\n\n调查组表示，下一步将举一反三，继续严格排查，针对存在的问题，提出整改措施，压实整改责任，确保全面整改到位，同时对相关责任人依法依纪严肃处理。', 1611640802.13332);
INSERT INTO `blogs` VALUES ('001611640884550deb0da4699b6416295d4ae6e504d664c000', '0016080262798593075820ecd7643cf848f5da78c043676000', 'admin', 'http://www.gravatar.com/avatar/87f73fde37b1172357f5cbb3b4f9bc41?d=mm&s=120', '特朗普弹劾条款正式提交参议院', '外媒称特朗普弹劾条款正式提交参议院，他的支持者还会“做点什么”？', '据法新社消息，众议院民主党向参议院正式递交针对特朗普的弹劾条款“煽动叛乱”，正式开启对特朗普的第二次弹劾的审判。2月8日当周，美国国会参议院将以“煽动暴力叛乱”的罪名对特朗普开展弹劾审判。\n\n\n资料图 新华社供图\n\n这将是特朗普的第二次弹劾审判，也将是美国历史上首次针对前总统的弹劾审判。美国国会众议院于2019年12月首次弹劾特朗普，指控他滥用职权和妨碍国会。\n\n随着美国前总统特朗普的第二次弹劾审判临近，美媒披露称，近日出现了一些针对国会议员的威胁，包括社交媒体上煽动在美国国会大厦外杀害或袭击议员的恶意评论。\n\n据美联社1月25日报道，一名不具名的美国联邦官员24日透露称，联邦执法官员正在研究社交媒体上对议员们的威胁，并担忧武装抗议者可能会在针对特朗普的弹劾审判进行期间再度冲击国会大厦。\n\n\n资料图 新华社供图\n\n福克斯新闻当地时间22日报道，特朗普卸任后首次发声。离开白宫后，特朗普来到佛罗里达州的海胡庄园。当天晚上用晚餐时，一位《华盛顿观察家报》的记者问特朗普未来有何打算。特朗普很简短的回答：我们会做点什么，但不是现在。之后特朗普的一位助手要求这位记者离开。\n\n原标题：外媒：特朗普弹劾条款正式提交参议院\n\n来源：综合综合 环球网 澎湃新闻', 1611640884.55065);
INSERT INTO `blogs` VALUES ('00161164111061829b13b5aeace482e868a6b028c1e5300000', '0016080262798593075820ecd7643cf848f5da78c043676000', 'admin', 'http://www.gravatar.com/avatar/87f73fde37b1172357f5cbb3b4f9bc41?d=mm&s=120', '栖霞矿工被困14天经历了什么', '相信一定有人来救我们！栖霞矿工被困14天都经历了什么？', '1月26日，记者在栖霞市人民医院，面对面采访了从栖霞笏山金矿爆炸事故井下救出来的两位矿工。\n\n被困14天，他们经历了什么？什么样的信念支撑他们活下来的？ 听听他们的讲述。\n\n获救矿工之一：相信一定有人来救我们！\n\n\n“爆炸发生时，我当时在6中段，因为水比较多，就从井筒的梯子间爬到5中段等待救援。二次爆炸后，5中段开始浓烟弥漫，两三米的距离见不到人，情况非常混乱。在下边等待救援的时候， 中间的管道断开了，我们每天都去敲击回升井。”\n\n“1号钻孔打通的前两三天，我们就听到打钻的声音，最后一天快透的时候听得很清楚了。”\n\n“钻孔打通的时候，听到声音，我们所有人都站起来了！有一种绝地重生的感觉。”\n\n“这14天有人失望，有人乐观。我们互相鼓励，相信党和政府一定会派人来救我们的！”\n\n“感谢党，感谢救援指挥部，感谢所有救援人员！”\n\n“我们当时在矿井下500多米深，水质比较硬，不太适合人喝，偶尔维持生命，用瓶子杯子取水，光喝水，并没有别的食物。”\n\n“井下有特别有经验的带头大哥，各取所长，集各方面智慧。敲击钻杆的时候，最多敲击了9下。”\n\n“现在的身体状况相当不错！吃饭也很好！”\n\n“钻孔打通之后，救援人员投放了很多食物、水，24小时救援不停，真的很辛苦。”\n\n“当时升井的感觉，就像重生的感觉，第二次生命，而这第二次生命，正是党和政府给我们的！”\n\n获救矿工之二：双手合十就是为了表达感谢！\n\n\n“当时钻孔打通，是我去敲击钻杆的，因为我的体力最好，当时带了个工具，需要使劲敲击。一开始敲击5下，意思是我们在5中段，又敲击9下，意思是我们已经在井下9天，最担心的就是家人，他们不知道我们什么情况。”\n\n“爆炸发生时，我们在6中段，事后爬到5中段，头盔都裂了。”\n\n“在井下这么多天，当时在下边呼吸还可以，氧气比较充足，困了就睡。”\n\n“在下面待了8、9天的时候，听到响声，知道有人来救我们了。”\n\n“腊八节那天，收到腊八粥，当时手机还有电，知道那天是腊八节，都感叹救援人员想得太周到了。”\n\n“我是最后一位升井的，还是因为我体力最好。升井时，我双手合十，是自发地表达感谢。当时手里拿的电筒亮着，因为在井筒内升井时，是黑暗看不见，需要电筒一直照亮。”\n\n“感谢党和政府，没有把我们放弃！”（记者侯琳良、李蕊）', 1611641110.61879);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `blog_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_image` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` double NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_create_at`(`created_at`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES ('0016116409220754852dc1c5d724391911dbfd512feb931000', '001611640884550deb0da4699b6416295d4ae6e504d664c000', '001611640544518659ce194ccfe47b484df7e7139f8d2fa000', 'awesome', 'http://www.gravatar.com/avatar/904ab3d34504e5b6b717441d7ab17317?d=mm&s=120', '好的', 1611640922.07595);
INSERT INTO `comments` VALUES ('00161164094567996480d23a48f42f98340b0565e36dc29000', '0016116407379839420db908eee4c7eaed6333ce4ea59b5000', '001611640544518659ce194ccfe47b484df7e7139f8d2fa000', 'awesome', 'http://www.gravatar.com/avatar/904ab3d34504e5b6b717441d7ab17317?d=mm&s=120', '666', 1611640945.67834);
INSERT INTO `comments` VALUES ('001611713838572e616b0cdfd0e42ed99800d12b59955d4000', '00161164111061829b13b5aeace482e868a6b028c1e5300000', '001611640544518659ce194ccfe47b484df7e7139f8d2fa000', 'awesome', 'http://www.gravatar.com/avatar/904ab3d34504e5b6b717441d7ab17317?d=mm&s=120', '感谢党和政府,没有放弃,这是对生命的尊重,对劳苦大众的深深关怀...', 1611713838.57266);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `passwd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` double NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_email`(`email`) USING BTREE,
  INDEX `idx_create_at`(`created_at`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('0016080262798593075820ecd7643cf848f5da78c043676000', 'admin@py.com', '2f43dad46fcc12cdf75b13f5c049cd50df8f2e26', 1, 'admin', 'http://www.gravatar.com/avatar/87f73fde37b1172357f5cbb3b4f9bc41?d=mm&s=120', 1608026279.85968);
INSERT INTO `users` VALUES ('001611640544518659ce194ccfe47b484df7e7139f8d2fa000', 'awesome@qq.com', '74a924eda9dac32849cd0c06da9a8d0e2e9f7cff', 0, 'awesome', 'http://www.gravatar.com/avatar/904ab3d34504e5b6b717441d7ab17317?d=mm&s=120', 1611640544.51802);

SET FOREIGN_KEY_CHECKS = 1;
