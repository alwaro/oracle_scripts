#!/usr/bin/env bash
# #####################################################################
# getdbsize.sh
# - Shell script to get the info about occupation of the database which
#   enviroment variables are loaded in memory
# - A good idea is create an alias to this script to achieve execute it
#   from any path, in any moment.
# - The output of this script is
#       Datafiles size
#       Segments size
#       The list of all schemas whith segments ordered by size
#
# WHO            WHEN           WHAT
# -------------- -------------- ---------------------------------------
# Alvaro Anaya   2023-07-23     Script Creation and implementation
#
# #####################################################################

# ZONA DE VARIABLES y CONSTANTES
# ---------------------------------------------------------------------
export workDir=$(dirname $0)
export logDir=${workDir}/logs
export sqlDir=${workDir}/sql
export tmpDir=${workDir}/tmp
export modoDebug=1
export timeStamp=$(date +"%Y%m%d_%H%M%S")
export timeStampL=$(date +"%d de %b de %Y a las %H:%M")


# ZONA DE FUNCIONES
# ---------------------------------------------------------------------

function ctrl_c
{
    echo -e "\nCancelado manualmente mediante CTRL+C"
    exit 0
}

function usage 
{
  cat << EOF
Usage: 
    getdbsize.sh [ instancia ]

Descipcion:
    Extrae los datos tipicos de espacio/ocupacion de la bbdd que se le indique. 
    
    IMPORTANTE: 
    La base de datos debe estar arrancada en el nodo donde se ejecute el script.

Parametros:
    instancia: Es el ORACLE_SID de la instancia a consultar y es un parametro
                opcional ya que, si no se indica, usara el definido en memoria.

Ejemplos:
    getdbsize SAMPLEDB1 --> Muestra los datos de SAMPLEDB1
    getdbsize APOLO2    --> Muestra los datos de APOLO2
    getdbsize           --> Devuelve los datos del ORACLE_SID cargado en memoria

EOF
  exit 0
}


function msgQueue 
{ 
    # Funcion para gestionar la cola de mensajes 
    lvl="${1}" # Nivel de mensajes (DEBUG, NORMAL, WARNING, CRITICAL) 
    msg="${2}" # Mensaje a gestionar 
    msgTime=`date +%Y-%m-%d_%H:%M:%S` 
    failMsg="${msgTime} CRITICAL:\n FATAL error enviando msg a msgQueue" 
    [[ -z "${1}" ]] || [[ -z "${2}" ]] && echo -e "ops: ${failMsg}\n"| tee -a ${logFile} && exit 2 
    if [[ ${lvl} == "DEBUG" ]]; then 
        if [[ $modoDebug -eq 1 ]]; then 
            echo -e "${msgTime} ${lvl}:\n ${msg}\n"| tee -a ${logFile} 
        fi 
    else 
        echo -e "${msgTime} ${lvl}:\n ${msg}\n"| tee -a ${logFile} 
    fi 
} 


function checkEnv
{
    if [ "$1" == "variables_from_memoria" ]; then
        if [ -z $ORACLE_SID ] || [ -z $ORACLE_HOME ]; then
            msgQueue "CRITICAL" "Las variables de entorno NO estan cargadas (ORACLE_SID/ORACLE_HOME)"
            exit 1
        else
            elPmon=ora_pmon_$ORACLE_SID
            ps -ef|grep -w ${elPmon}|grep -v grep > /dev/null 2>&1
            if [ $? -eq 1 ]; then
                msgQueue "CRITICAL" "La instancia con ORACLE_SID $ORACLE_SID, no esta corriendo en este nodo"
                exit 1
            fi
            if [ ! -d $ORACLE_HOME ]; then
                msgQueue "CRITICAL" "La ruta definida como ORACLE_HOME, no es accesible"
                exit 1
            fi
        fi
    else
        elPmon=ora_pmon_$1
        ps -ef|grep -w ${elPmon} > /dev/null 2>&1
        if [ $? -eq 1 ]; then
            msgQueue "CRITICAL" "La instancia con ORACLE_SID $ORACLE_SID, no esta corriendo en este nodo"
            exit 1
        fi
        if [ ! -r ${preRuta}/${oracle_sid} ]; then
            msgQueue "CRITICAL" "No puede leerse el fichero de variables de entorno"
            exit 1
        fi
    fi
}


function get_db_data()
{
    export query="$1"
    sqlplus -S / as sysdba <<EOF > $tmpDir/result.tmp
set feedback off;
set heading off;
${query}
exit;
EOF
}


function get_db_data_long()
{
    export query="$1"
    sqlplus -S / as sysdba <<EOF > $tmpDir/result.tmp
set feedback off;
set heading off;
set lines 100
col owner format a60
spoo $tmpDir/resultado.log
${query}
spoo off
exit;
EOF
}

# ZONA CORE DEL SCRIPT

trap mi_func_ctrl_c INT

# Preconfiguramos la primera parte de la ruta del fichero de config con las variables de entorno
if [[ "$HOSTNAME" == "ex8-db01" ]] || [[ "$HOSTNAME" == "ex8-db02" ]]; then
        export preRuta="/scripts/oracle/entorno/exadata-x8"
elif [[ "$HOSTNAME" == "ex4-db01.des.int" ]] || [[ "$HOSTNAME" == "ex4-db02.des.int" ]]; then
        export preRuta="/scripts/oracle/entorno/exadata-x4"
elif [[ "$HOSTNAME" == "ex2-db01" ]] || [[ "$HOSTNAME" == "ex2-db02" ]]; then
        export preRuta="/scripts/oracle/entorno/exadata-x2"
else
    echo -e "\nERROR:\n\n    Este script esta pensado para ejecutarse sobre los exadata (X2, X4 o X8)!!!!\n\n"
    exit 2
fi

if [ -z $1 ]; then
    checkEnv "variables_from_memoria"
else
    oracle_sid=$(echo $1 |awk '{ print tolower($0) }')
    checkEnv $1
    . ${preRuta}/${oracle_sid}
fi

# recopilamos la info de la bbdd

get_db_data "select sum(bytes)/1024/1024/1024 from dba_data_files"
export datafilesSize=$(tail -1 $tmpDir/result.tmp)
get_db_data "select sum(bytes)/1024/1024/1024 from dba_segments;"
export segmentosSize=$(tail -1 $tmpDir/result.tmp)
get_db_data_long "select OWNER,sum(bytes)/1024/1024/1024 "SIZE_IN_GB" from dba_segments where owner not in ('SYS','SYSTEM','OUTLN','DIP','ANONYMOUS','ORACLE_OCM','DBSNMP','APPQOSSYS','WMSYS','XDB','XS$NULL','SYSRAC','SYSBACKUP','AUDSYS','SYSDG','SYSKM','GSMADMIN_INTERNAL','GGSYS','GSMUSER','REMOTE_SCHEDULER_AGENT','DBSFWUSER','SYS$UMF','GSMCATUSER','SQLTXPLAIN','OJVMSYS','SQLTXADMIN') group by owner order by SIZE_IN_GB DESC;"
export usersOcupacion=$(cat $tmpDir/resultado.log)

# GENERANDO EL INFORME FINAL
# --------------------------------------------------------------------------------------------------
echo 
echo ----======== INFORME DE OCUPACION DE LA BBDD $ORACLE_SID ========----
echo
echo "       Generado en el dia ${timeStampL}"
echo 
echo "      SUMA DE LOS DATAFILES en GB...: ${datafilesSize}"
echo "      SUMA DE LOS SEGMENTOS en GB...: ${segmentosSize}"
echo 
echo "       OCUPACION DE USERS CON SEGMENTOS EN LA BBDD en GB"
echo "     ------------------------------------------------------"
#echo ${usersOcupacion}
cat $tmpDir/resultado.log
echo 
echo ============================================================================
echo 


