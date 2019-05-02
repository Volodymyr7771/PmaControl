-- MySQL dump 10.17  Distrib 10.3.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: pma_new
-- ------------------------------------------------------
-- Server version	10.3.14-MariaDB-1:10.3.14+maria~bionic-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned DEFAULT NULL,
  `bg` int(11) NOT NULL,
  `bd` int(11) NOT NULL,
  `active` int(11) NOT NULL DEFAULT 1,
  `icon` text NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `class` varchar(255) NOT NULL DEFAULT '',
  `method` varchar(255) NOT NULL DEFAULT '',
  `position` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `group_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `level` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `class` (`class`,`method`,`bg`,`bd`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (60,0,189,190,1,'<span class=\"glyphicon glyphicon-off\"></span>','Login','{LINK}user/connection/','user','connection',0,3,''),(61,0,191,192,1,'<span class=\"glyphicon glyphicon-user\"></span>','Register','{LINK}user/register/','user','register',0,3,''),(62,0,193,194,1,'<span class=\"glyphicon glyphicon-envelope\"></span>','Lost password','{LINK}user/lost_password/','user','lost_password',0,3,''),(92,NULL,1,156,1,'<span class=\"glyphicon glyphicon glyphicon-home\"></span>','Home','{LINK}home/index','home','index',0,1,''),(95,92,4,19,1,'<span class=\"glyphicon glyphicon glyphicon-home\"></span>','Dashboard','','dashboard','index',0,1,''),(96,95,5,8,1,'<i class=\"fa fa-server\" aria-hidden=\"true\" style=\"font-size:14px\"></i>','Servers','{LINK}server/main','server','main',0,1,''),(97,95,9,10,1,'<span class=\"glyphicon glyphicon-hdd\" style=\"font-size:12px\"></span>','Hardware','{LINK}server/hardware','server','hardware',0,1,''),(98,95,11,12,1,'<span class=\"glyphicon glyphicon-signal\" style=\"font-size:12px\"></span>','Statistics','{LINK}server/statistics','server','statistics',0,1,''),(99,95,13,14,1,'<span class=\"glyphicon glyphicon-floppy-disk\" style=\"font-size:12px\"></span>','Memory','{LINK}server/memory','server','memory',0,1,''),(100,95,15,16,1,'<span class=\"glyphicon glyphicon-th-list\" style=\"font-size:12px\"></span>','Index','{LINK}server/index','server','index',0,1,''),(101,95,17,18,1,'<i class=\"fa fa-line-chart\" aria-hidden=\"true\"></i>','Graphs','{LINK}server/id','server','id',0,1,''),(102,92,20,29,1,'<i class=\"fa fa-object-group\" style=\"font-size:14px\"></i>','Architecture','','','',0,1,''),(103,92,30,65,1,'<span class=\"glyphicon glyphicon-wrench\" aria-hidden=\"true\"></span>','Tools','','','',0,1,''),(104,103,31,32,1,'<span class=\"glyphicon glyphicon-list-alt\" style=\"font-size:12px\"></span>','Query Analyzer','{LINK}monitoring/query/','monitoring','query',0,1,''),(105,103,33,48,1,'<i class=\"glyphicon glyphicon-erase\"></i>','Cleaner','{LINK}cleaner/index/','cleaner','index',0,1,''),(108,92,68,85,1,'<span class=\"glyphicon glyphicon-floppy-disk\" style=\"font-size:12px\"></span>','Backups','','','',0,1,''),(109,92,86,91,1,'<i style=\"font-size: 16px\" class=\"fa fa-puzzle-piece\"></i>','Plugins','','','',0,1,''),(110,109,87,88,1,'<span class=\"glyphicon glyphicon-th-list\" aria-hidden=\"true\"></span>','sys Schema','{LINK}mysqlsys/index/','mysqlsys','index',0,1,''),(111,109,89,90,1,'<i class=\"fa fa-tachometer\" aria-hidden=\"true\"></i>','BenchMark','{LINK}benchmark/index/','benchmark','index',0,1,''),(112,103,49,50,1,'<i class=\"fa fa-key\" style=\"font-size:16px\"  aria-hidden=\"true\"></i>','Deploy RSA key','{LINK}DeployRsaKey/index/','DeployRsaKey','index',0,1,''),(113,92,92,135,1,'<span class=\"glyphicon glyphicon-cog\" style=\"font-size:12px\"></span>','Settings','','','',0,1,''),(114,108,69,76,1,'<span class=\"glyphicon glyphicon-hdd\" style=\"font-size:12px\"></span>','Storage area','{LINK}StorageArea/index/','StorageArea','index',0,1,''),(115,108,77,82,1,'<span class=\"glyphicon glyphicon-book\" style=\"font-size:12px\" aria-hidden=\"true\"></span>','Archives','{LINK}Archives/index/','Archives','index',0,1,''),(116,92,136,145,1,'<i class=\"fa fa-question\" style=\"font-size:16px\" aria-hidden=\"true\"></i>','Help','','','',0,1,''),(117,116,137,138,1,'<i class=\"fa fa-book\" style=\"font-size:16px\"></i>','Online docs and support','https://github.com/PmaControl/PmaControl/wiki','','',0,1,''),(118,116,139,140,1,'<i class=\"fa fa-refresh\" style=\"font-size:16px\"></i>','Check for update','https://github.com/PmaControl/PmaControl','update','index',0,1,''),(119,116,141,142,1,'<i class=\"fa fa-bug\" style=\"font-size:16px\"></i>','Report issue','https://github.com/PmaControl/PmaControl/issues','','',0,1,''),(120,116,143,144,1,'<i class=\"fa fa-info-circle\" style=\"font-size:16px\"></i>','About','{LINK}About/index','about','index',0,1,''),(121,113,93,94,1,'<span class=\"glyphicon glyphicon-user\" style=\"font-size:12px\"></span>','Users','{LINK}user/index/','user','index',0,1,''),(122,113,95,96,1,'<span class=\"glyphicon glyphicon-user\" style=\"font-size:12px\"></span>','Groups','{LINK}group/index/','group','index',0,1,''),(123,113,97,100,1,'<span class=\"glyphicon glyphicon-user\" style=\"font-size:12px\"></span>','Client','{LINK}client/index/','client','index',0,1,''),(124,113,101,104,1,'<span class=\"glyphicon glyphicon-user\" style=\"font-size:12px\"></span>','Environment','{LINK}environment/index/','environment','index',0,1,''),(125,113,105,106,1,'<span class=\"glyphicon glyphicon-calendar\" style=\"font-size:12px\"></span>','Daemon','{LINK}daemon/index','daemon','index',0,1,''),(126,113,107,112,1,' <i class=\"fa fa-server\" aria-hidden=\"true\" style=\"font-size:14px\"></i>','Servers','{LINK}server/settings','server','settings',0,1,''),(127,103,51,52,1,'<i class=\"glyphicon glyphicon-transfer\" style=\"font-size:12px\"></i>','Compare','{LINK}compare/index/','compare','index',0,1,''),(128,103,53,54,1,'<span class=\"glyphicon glyphicon-search\" aria-hidden=\"true\"></span>','Scan network','{LINK}scan/index/','scan','index',0,1,''),(129,92,2,3,1,'<span class=\"glyphicon glyphicon glyphicon-home\"></span>','Home','{LINK}home/index','home','index',0,1,''),(131,113,113,114,1,'<i class=\"fa fa-address-book\" aria-hidden=\"true\"></i>','LDAP','{LINK}ldap/index/','ldap','index',0,1,''),(132,113,115,116,1,'<i class=\"fa fa-puzzle-piece\" aria-hidden=\"true\"></i>','Plugins','{LInK}plugin/index','plugin','index',0,1,''),(133,113,117,122,1,'<i class=\"fa fa-key\" aria-hidden=\"true\"></i>','SSH keys','{LINK}ssh/index','ssh','index',0,1,''),(136,103,55,56,1,'<i class=\"fa fa-wpforms\" aria-hidden=\"true\"></i>','Format SQL','{LINK}format/index/','format','index',0,1,''),(137,92,146,147,1,'<span class=\"glyphicon glyphicon-off\" aria-hidden=\"true\"></span>','Logout','{LINK}user/logout/','user','logout',0,1,''),(138,113,123,128,1,'<span class=\"glyphicon glyphicon-import\"></span>','Import / Export','{LINK}export/index','Export','index',0,1,''),(139,103,57,58,1,'<i class=\"fa fa-wrench\" aria-hidden=\"true\"></i>','Check Config','{LINK}CheckConfig/index/','CheckConfig','index',0,1,''),(140,108,83,84,1,'<span class=\"glyphicon glyphicon-cog\" style=\"font-size:12px\"></span>','Settings','{LINK}backup/settings/','backup','settings',0,1,''),(141,113,129,130,1,'<span class=\"glyphicon glyphicon-globe\" aria-hidden=\"true\"></span>','Alias DNS','{LINK}alias/index','alias','index',0,1,''),(142,92,148,155,1,'<i class=\"fa fa-id-card-o\" aria-hidden=\"true\"></i>','Developer','','','',0,1,''),(143,142,149,150,1,'<i class=\"fa fa-terminal\" aria-hidden=\"true\"></i>','PHP Live REGEX','{LINK}PhpLiveRegex/index','PhpLiveRegex','index',0,1,''),(144,142,151,154,1,'<span class=\"glyphicon glyphicon-menu-hamburger\" aria-hidden=\"true\"></span>','Manage menu','{LINK}tree/index','tree','index',0,1,''),(145,113,131,134,1,'<span class=\"glyphicon glyphicon-tags\" aria-hidden=\"true\"></span>','Tags','{LINK}tag/index','tag','index',0,1,''),(146,103,59,60,1,'<i class=\"fa fa-address-card\" aria-hidden=\"true\"></i>','MySQL User','{LINK}MysqlUser/index/','MysqlUser','index',0,1,''),(147,102,21,22,1,'<i class=\"glyphicon glyphicon-th\"></i>','Topology','{LINK}architecture/index/','architecture','index',0,1,''),(148,102,23,26,1,'<i class=\"fa fa-sitemap\"></i>','Master / Slave','{LINK}slave/index/','slave','index',0,1,''),(149,102,27,28,1,'<i class=\"glyphicon glyphicon-th-large\"></i>','Galera Cluster','{LINK}GaleraCluster/index/','GaleraCluster','index',0,1,''),(150,103,61,64,1,'<i class=\"fa fa-database fa-lg\"></i>','Database','{LINK}database/index','database','index',0,1,''),(153,144,152,153,0,'<span class=\"glyphicon glyphicon-plus\"></span>','Add menu entry','{LINK}tree/add','tree','add',0,1,''),(154,96,6,7,0,'<i class=\"fa fa-server\" aria-hidden=\"true\" style=\"font-size:14px\"></i>','Servers listing','{LINK}Server/listing','Server','listing',0,1,''),(155,105,34,37,0,'<span class=\"glyphicon glyphicon-plus\"></span>','Add a cleaner','{LINK}cleaner/add/','cleaner','add',0,1,''),(156,114,70,71,0,'<span class=\"glyphicon glyphicon-plus\"></span>','Add a storage area','{LINK}StorageArea/add','StorageArea','add',0,1,''),(157,114,72,73,0,'<span class=\"glyphicon glyphicon-hdd\" style=\"font-size:12px\"></span>','List all storage area','{LINK}StorageArea/listStorage','StorageArea','listStorage',0,1,''),(158,115,78,79,0,'<span class=\"glyphicon glyphicon-book\" style=\"font-size:12px\" aria-hidden=\"true\"></span>','Restoration history','{LINK}Archives/history','Archives','history',0,1,''),(159,115,80,81,0,'<span class=\"glyphicon glyphicon-book\" style=\"font-size:12px\" aria-hidden=\"true\"></span>','Restoration detail','{LINK}Archives/detail/','Archives','detail',0,1,''),(160,150,62,63,0,'<span class=\"glyphicon glyphicon-plus\"></span>','Create database','{LINK}database/create','database','create',0,1,''),(161,126,108,109,0,'<i class=\"fa fa-key\" aria-hidden=\"true\"></i>','Change server password','{LINK}server/password','server','password',0,1,''),(162,126,110,111,0,'<span class=\"glyphicon glyphicon-plus\"></span>','Add a new server','{LINK}mysql/add','mysql','add',0,1,''),(163,123,98,99,0,'<span class=\"glyphicon glyphicon-plus\"></span>','Add a client','{LINK}client/add','client','add',0,1,''),(164,138,124,125,0,'<span class=\"glyphicon glyphicon-floppy-disk\"></span>','Import / Export configuration','{LINK}export/export_conf/','export','export_conf',0,1,''),(165,138,126,127,0,'<span class=\"glyphicon glyphicon-floppy-disk\"></span>','Import / Export configuration','{LINK}export/import_conf/','export','import_conf',0,1,''),(166,92,66,67,1,'<span class=\"glyphicon glyphicon-cog\" aria-hidden=\"true\"></span>','Job','{LINK}job/index','job','index',0,1,''),(167,148,24,25,0,'<i class=\"fa fa-sitemap\"></i>','Slave Show','{LINK}slave/show/','slave','show',0,1,''),(168,145,132,133,0,'<i class=\"fa fa-plus\"></i>','Add a new tag','{LINK}tag/add/','tag','add',0,1,''),(169,124,102,103,0,'<i class=\"fa fa-plus\"></i>','Add an environment','{LINK}environment/add/','environment','add',0,1,''),(170,133,118,119,0,'<i class=\"fa fa-plus\"></i>','Add a ssh key','{LINK}ssh/add/','ssh','add',0,1,''),(171,133,120,121,0,'<i class=\"far fa-edit\"></i>','Edit a ssh key','{LINK}ssh/edit/','ssh','edit',0,1,''),(172,105,38,39,0,'<i class=\"fa fa-area-chart\" aria-hidden=\"true\"></i>','Statistics','{LINK}cleaner/statistics','cleaner','statistics',0,1,''),(173,105,40,41,0,'<span class=\"glyphicon glyphicon-eye-open\"></span>','View','{LINK}cleaner/view','cleaner','view',0,1,''),(174,155,35,36,0,'<span class=\"glyphicon glyphicon-file\"></span>','Logs','{LINK}cleaner/logs','cleaner','logs',0,1,''),(175,105,42,43,0,'<i class=\"fa fa-file-text-o\" aria-hidden=\"true\"></i>','Details','{LINK}cleaner/details','cleaner','details',0,1,''),(176,105,44,45,0,'<i class=\"fa fa-table\" aria-hidden=\"true\"></i>','Tables impacted','{LINK}cleaner/impacted','cleaner','impacted',0,1,''),(177,114,74,75,0,'<span class=\"glyphicon glyphicon-stats\" style=\"font-size:12px\" aria-hidden=\"true\"></span>','Storage area','{LINK}storagearea/edit/','storagearea','edit',0,1,''),(178,105,46,47,0,'<span class=\"glyphicon glyphicon-edit\"></span>','Edit','{LINK}cleaner/edit','cleaner','edit',0,1,'');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-23 16:08:57
