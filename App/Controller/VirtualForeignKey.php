<?php
/*
 * j'ai ajouté un mail automatique en cas d'erreur ou de manque sur une PK
 *
 * 15% moins bien lors du chargement par rapport à une sauvegarde générer avec mysqldump
 * le temps de load peut être optimisé
 */

// Installation des gestionnaires de signaux
declare(ticks=1);

namespace App\Controller;

use \Glial\Sgbd\Sgbd;
use \Glial\Synapse\Controller;
use \Glial\Cli\Color;
use \App\Library\Debug;
use \App\Library\Mysql;

class VirtualForeignKey extends Controller
{

    CONST BEGIN = "id%";
    CONST END = "%id";

    static $primary_key = array();

    public function autoDetect($param)
    {
        $this->view = false;
        Debug::parseDebug($param);
        //$id_mysql_server = $param[0];

        $this->autoId($param);

        if ( ! IS_CLI){

            $location = $_SERVER['HTTP_REFERER'];
            header("locatlion: $location");
            //exit;
        }
    }

    public function autoId($param)
    {
        Debug::parseDebug($param);

        $id_mysql_server = $param[0];
        $db              = Mysql::getDbLink($id_mysql_server);
        $default         = Sgbd::sql(DB_DEFAULT);

        $sql = "DELETE FROM virtual_foreign_key WHERE id_mysql_server ='".$id_mysql_server."' and is_automatic = 1";
        $sql = "TRUNCATE table virtual_foreign_key;";
        $db->sql_query($sql);

        $databases = $this->getDatabase($param);

        foreach($databases as $database)
        {
            $table_not_found = array();

            $position = $this->getIdPosition(array($id_mysql_server, $database));
            $sql = "select TABLE_SCHEMA,TABLE_NAME, COLUMN_NAME 
            from information_schema.COLUMNS 
            where TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys') 
            AND TABLE_SCHEMA = '".$database."' 
            AND COLUMN_KEY != 'PRI' and COLUMN_NAME like '".$position."'";

            // need add where PK on more than one field
            //TO DO UPGRADE

            $res = $db->sql_query($sql);
            $nb_key = $db->sql_num_rows($res);

            Debug::debug($nb_key, "Nombre de clefs étrangère potentiels");

            $nb_fk_found = 0;
            while ($arr         = $db->sql_fetch_array($res, MYSQLI_ASSOC)) {

                Debug::success($arr, "reference to find ");

                $schema_ref = $arr['TABLE_SCHEMA'];

                //start with id
                if ($position === self::BEGIN) {
                    $table_ref  = preg_replace('/(^id\_?)/i', '$2', $arr['COLUMN_NAME']);
                }
                //end with id
                else if ($position === self::END) {
                    $table_ref  = preg_replace('/(\_?id$)/i', '$2', $arr['COLUMN_NAME']);
                }
                else {
                    Debug::error( "Error");
                }


                if ($arr2 = $this->isTableExist(array($id_mysql_server, $schema_ref, $table_ref))) {
                    
                } 
                else if ($arr2 = $this->isTableExist(array($id_mysql_server, $schema_ref, $table_ref."s"))) {
                        
                }
                else if ($arr2 = $this->isTableExist(array($id_mysql_server, $schema_ref, $table_ref."x"))) {
                            
                } /*
                else if ($arr2 = $this->isTableExist(array($id_mysql_server, $schema_ref, $table_ref2))) {
                    $table_id = $arr['COLUMN_NAME'];
                    //Debug::debug($arr2, 'ARR2');   
                } */
                else if ($arr2 = $this->getConbinaison(array($id_mysql_server, $schema_ref, $table_ref)))
                {
                    Debug::debug($arr2, '##################################################');
                }
                else {

                    $table_not_found[] = $table_ref;
                    Debug::error($arr, "Impossible de trouver la table");
                    continue;
                }
                
                $schema_ref = $arr2['TABLE_SCHEMA'];
                $table_ref  = $arr2['TABLE_NAME'];

                //find PRIMARY KEY
                $primary_key = $this->getPrimaryKey($id_mysql_server, $schema_ref, $table_ref);


                $virtual_foreign_key                                             = array();
                $virtual_foreign_key['virtual_foreign_key']['id_mysql_server']   = $id_mysql_server;
                $virtual_foreign_key['virtual_foreign_key']['constraint_schema'] = $arr['TABLE_SCHEMA'];
                $virtual_foreign_key['virtual_foreign_key']['constraint_table']  = $arr['TABLE_NAME'];
                $virtual_foreign_key['virtual_foreign_key']['constraint_column'] = $arr['COLUMN_NAME'];
                $virtual_foreign_key['virtual_foreign_key']['referenced_schema'] = $schema_ref;
                $virtual_foreign_key['virtual_foreign_key']['referenced_table']  = $table_ref;
                $virtual_foreign_key['virtual_foreign_key']['referenced_column'] = $primary_key;

                if ($primary_key !== false) {
                    $nb_fk_found++;
                    $default->sql_save($virtual_foreign_key);
                } else {

                    //save to other table and propose to set link manually
                    Debug::error($virtual_foreign_key, "No found\n");
                }
                
            }

            if ($nb_key > 0)
            {
                Debug::debug($nb_key, "Nombre de clefs étrangère potentiels");
                Debug::debug($nb_fk_found, "Nombre de clefs étrangère trouvé");
    
                $percent = round($nb_fk_found / $nb_key * 100, 2);
                Debug::debug($percent."%", "Nombre de clefs étrangère trouvé");
    
                $nb_not_found = count($table_not_found);
                Debug::error($nb_not_found, "Number of link not found");
    
                $list_error = $this->sort_and_count_array($table_not_found);
                Debug::error( $list_error, "Impossible to find these tables :");
            }

            Debug::warning($percent,'-----------------------------------------------------------');
        }

        //Color::printAll();
    }

    /*
      CREATE TABLE `virtual_foreign_key` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `id_mysql_server` int(11) NOT NULL DEFAULT 0,
      `constraint_schema` varchar(64) NOT NULL DEFAULT '',
      `constraint_table` varchar(64) NOT NULL DEFAULT '',
      `constraint_column` varchar(64) NOT NULL DEFAULT '',
      `referenced_schema` varchar(64) NOT NULL DEFAULT '',
      `referenced_table` varchar(64) NOT NULL DEFAULT '',
      `referenced_column` varchar(64) NOT NULL DEFAULT '',
      PRIMARY KEY (`id`),
      UNIQUE KEY `id_mysql_server_2` (`id_mysql_server`,`constraint_schema`,`constraint_table`,`constraint_column`,`referenced_schema`,`referenced_table`,`referenced_column`),
      KEY `id_mysql_server` (`id_mysql_server`),
      CONSTRAINT `id_mysql_server_ibfk_1` FOREIGN KEY (`id_mysql_server`) REFERENCES `mysql_server` (`id`)
      ) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4
     */

    public function isTableExist($param)
    {

        Debug::parseDebug($param);

        $id_mysql_server = $param[0];
        $table_name      = $param[2];
        $database_name   = $param[1];

        $db = Mysql::getDbLink($id_mysql_server);

        $sql = "SELECT TABLE_SCHEMA, TABLE_NAME 
        FROM `information_schema`.`tables` WHERE `TABLE_SCHEMA` = '".$database_name."' 
        AND  LOWER(`TABLE_NAME`) = LOWER('".$table_name."');";
        $res = $db->sql_query($sql);

        $nb_tables = $db->sql_num_rows($res);
        if ($nb_tables > 1) {
            Debug::error($nb_tables, "Nombre de tables");
        }

        while ($arr = $db->sql_fetch_array($res, MYSQLI_ASSOC)) {
            //Debug::debug($arr, "Table trouvé");
            return $arr;
        }

        return false;
    }

    public function cleanUp($param)
    {

        Debug::parseDebug($param);

        $db  = Sgbd::sql(DB_DEFAULT);
        $sql = "TRUNCATE TABLE `virtual_foreign_key`;";
        $db->sql_query($sql);

        Debug::sql($sql);
    }

    public function findField($param)
    {
        Debug::parseDebug($param);

        $id_mysql_server = $param[0];
        $database_name   = $param[1];
        $table_name      = $param[2];
        $field_name      = $param[3];

        $db = Mysql::getDbLink($id_mysql_server);

        $sql = "SELECT count(1) as cpt
        from information_schema.COLUMNS     
        where TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema') 
        AND TABLE_SCHEMA = '".$database_name."'
        AND TABLE_NAME = '".$table_name."'
        AND COLUMN_NAME = '".$field_name."';";
    }

    public function getAll($param)
    {

        $this->cleanUp($param);
        Debug::parseDebug($param);

        $db  = Sgbd::sql(DB_DEFAULT);
        $sql = "select id from mysql_server;";
        $res = $db->sql_query($sql);

        while ($ob = $db->sql_fetch_object($res)) {
            $this->autoDetect(array($ob->id));
        }
    }

    public function fill($param)
    {
        Debug::parseDebug($param);
        $db = Sgbd::sql(DB_DEFAULT);

        $id_mysql_server = $param[0];
        $database = $param[1];

        $sql = "SELECT * FROM virtual_foreign_key WHERE id_mysql_server = ".$id_mysql_server." 
        AND (constraint_schema ='".$database."' OR referenced_schema ='".$database."')";
        
        $res = $db->sql_query($sql);

        $data['virtual_fk'] = array();
        
        while ($ob          = $db->sql_fetch_array($res, MYSQLI_ASSOC)) {
            $data['virtual_fk'][] = $ob;
        }

        $data['real_fk'] = Mysql::getRealForeignKey($param);
        $this->set('data', $data);
    }


    /*

    @param id_mysql_server int
    @param database_name
    
    Récupère les préfix des tables a exclure pour une base de données,

    exemple : tb_bulletinnepasimporter.IdAgentMois  => tb_agentmois.IdAgentMois
    on veux ici pas tenir compte du prefix "tb_"
    */

    public function getPrefix($param)
    {

        Debug::parseDebug($param);

        $id_mysql_server = $param[0];
        $database_name   = $param[1];

        $db = Sgbd::sql(DB_DEFAULT);

        $sql = "SELECT * FROM fk_remove_prefix WHERE id_mysql_server='".$id_mysql_server."' AND database_name='".$database_name."'";
        $res = $db->sql_query($sql);

        $data['prefix'] = array();
        while ($ob          = $db->sql_fetch_object($res, MYSQLI_ASSOC)) {
            $data['prefix'][] = $ob->prefix;
        }

        Debug::debug($data['prefix']);

        return $data['prefix'];

    }

    /*
        On detectee le paterne pour une table 
        id_nametable => table.id 

        si id au debut ou à la fin

        return begining or end
    */

    public function getIdPosition($param)
    {
        $id_mysql_server = $param[0];   
        
        Debug::parseDebug($param);

        $id_mysql_server = $param[0];
        $table_schema = $param[1]; 

        $db = Mysql::getDbLink($id_mysql_server);
        $positions = array(self::BEGIN, self::END);
        $result = array();

        foreach($positions as $position)
        {
            $sql = "select count(1) as cpt
            from information_schema.COLUMNS 
            where TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys') 
            AND TABLE_SCHEMA = '".$table_schema."'
            AND COLUMN_KEY != 'PRI' 
            AND COLUMN_NAME like '".$position."'";
            $res = $db->sql_query($sql);

            while($ob = $db->sql_fetch_object($res)) {
                $result[$position] = $ob->cpt;
            }
        }

        Debug::debug($result,"Stats");

        if ($result[self::BEGIN] > $result[self::END]) {
            Debug::debug(self::BEGIN,"return");
            return self::BEGIN;
        }
        else {
            Debug::debug(self::END,"return");
            return self::END;
        }
    }

    public function getConbinaison($param)
    {
        Debug::parseDebug($param);

        $id_mysql_server = $param[0];
        $database_name   = $param[1];
        $table_name      = $param[2];

        $all_prefix = $this->getPrefix($param);
        $all_prefix[] = "";

        foreach($all_prefix as $prefix)
        {
            Debug::debug($prefix, "prefix");

            $table_to_try = "$prefix$table_name";
            Debug::debug($table_to_try, "table to try");

            $ret = $this->isTableExist(array($id_mysql_server,$database_name, $table_to_try));
            
            if ($ret !== false) {
                return $ret;
            }
        }

        return false;
    }

    public function getDatabase($param)
    {
        Debug::parseDebug($param);

        $id_mysql_server = $param[0];

        $db = Mysql::getDbLink($id_mysql_server);
        $sql = "select SCHEMA_NAME as schema_name from information_schema.SCHEMATA WHERE SCHEMA_NAME NOT IN('information_schema', 'sys', 'performance_schema', 'mysql');";
        $res = $db->sql_query($sql);

        $databases = array();
        while ($ob = $db->sql_fetch_object($res))
        {
            $databases[] = $ob->schema_name;
        }

        Debug::debug($databases, "databases");

        return $databases;
    }

    public function sort_and_count_array($name_arr)
    {
        $new_arr = array_count_values($name_arr);
        ksort($new_arr);
        
        return $new_arr;
    }


    public function getPrimaryKey($id_mysql_server, $database, $table)
    {
        $db = Mysql::getDbLink($id_mysql_server);

        if (empty(self::$primary_key[$database][$table])) {

            $sql = "SHOW INDEX FROM `".$database."`.`".$table."` WHERE `Key_name` ='PRIMARY';";
            $res = $db->sql_query($sql);

            $cpt = $db->sql_num_rows($res);
            if ($cpt == "0") {
                //log ERROR
                Debug::error($table, "PMACONTROL-069 : this table '".$table."' haven't Primary key !");
                return false;
            } else if ($cpt == "1"){
                while ($ob = $db->sql_fetch_object($res)) {
                    self::$primary_key[$database][$table] = $ob->Column_name;
                }
            }
            else {
                //log ERROR
                Debug::error($table, "PMACONTROL-069 : this table '".$table."' have composed Primary key ($cpt) !");
                return false;
            }
        }

        return self::$primary_key[$database][$table];
    }
}