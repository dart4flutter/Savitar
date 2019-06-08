/*
 Navicat Premium Data Transfer

 Source Server         : Tencent
 Source Server Type    : PostgreSQL
 Source Server Version : 90421
 Source Host           : localhost:5432
 Source Catalog        : demo
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 90421
 File Encoding         : 65001

 Date: 27/04/2019 15:33:07
*/


-- ----------------------------
-- Sequence structure for _user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."_user_id_seq";
CREATE SEQUENCE "public"."_user_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for _avatar
-- ----------------------------
DROP TABLE IF EXISTS "public"."_avatar";
CREATE TABLE "public"."_avatar" (
  "id" int4 NOT NULL,
  "user_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar" varchar(100) COLLATE "pg_catalog"."default",
  "avatar_path" varchar(200) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of _avatar
-- ----------------------------
INSERT INTO "public"."_avatar" VALUES (2, '4', 'http://localhost:8080/static/admin.png', 'static/admin.png');

-- ----------------------------
-- Table structure for _user
-- ----------------------------
DROP TABLE IF EXISTS "public"."_user";
CREATE TABLE "public"."_user" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "username" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "role" int4 NOT NULL,
  "phone_number" varchar(11) COLLATE "pg_catalog"."default",
  "email" varchar(30) COLLATE "pg_catalog"."default",
  "salt" varchar(30) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of _user
-- ----------------------------
INSERT INTO "public"."_user" VALUES ('4', 'rhyme', '207acd61a3c1bd506d7e9a4535359f8a', 810, '159xxxxxxxx', 'rhymelph@gmail.com', 'salt');
INSERT INTO "public"."_user" VALUES ('2', 'rhyme', 'cc100db3284b42752b3f74951dfccca1', 1, '13815345341', '614464513#qq.com', 'salt');
INSERT INTO "public"."_user" VALUES ('EnkyyzOWkSojtohIgSvLr4lo8AlpaKTn', 'rhyme', 'cc100db3284b42752b3f74951dfccca1', 1, '13815345341', '614464513#qq.com', 'salt');

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"public"."_user_id_seq"', 2, false);

-- ----------------------------
-- Primary Key structure for table _avatar
-- ----------------------------
ALTER TABLE "public"."_avatar" ADD CONSTRAINT "_avatar_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table _user
-- ----------------------------
ALTER TABLE "public"."_user" ADD CONSTRAINT "_user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table _avatar
-- ----------------------------
ALTER TABLE "public"."_avatar" ADD CONSTRAINT "_avatar_user_id" FOREIGN KEY ("user_id") REFERENCES "public"."_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
