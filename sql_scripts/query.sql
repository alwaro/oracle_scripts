-- ===============================================================
-- NAME: query.sql
-- DESCRIPTION: 
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT 0 coordinada, etiqueta, nenvio, expedicion, codpla1, codpla2, codremi,
                          (codremi || ' ' || nomrte) nomremi, codcons, nomcons, kilos, bultos,
                          DECODE (hoj.keytsv,
                           3, (SELECT NVL (keyemb, 'PA')
                                 FROM rho_int
                                WHERE rho_int.expedicion = hoj.expedicion),
                           NVL (hoj.keyemb, 'PA')) tipo_uc,
                         nvl(hoj.keyemb, 'PA') as keyemb,
                         hoj.referencia, hoj.fecha, 0 ocultar, hoj.keytst,
                         (SELECT denom
                            FROM tst
                           WHERE keytst = hoj.keytst) denomtst,
                         hoj.keytsv, (SELECT denom
                                        FROM tsv
                                       WHERE keytsv = hoj.keytsv) denomtsv,
                         pac_internacional.exp_internacional (expedicion) internacional,
                         (SELECT /*+ index(cbc CBC_EXPEDICION_I) */ MAX (fecha)
                            FROM cbc
                           WHERE cbc.expedicion = hoj.expedicion
                             AND tiplec <> 57
                             AND tiplec <> 58
                             AND tiplec <> 62
                             AND cbc.keydel = :1) AS ultima_lectura,
                         (SELECT /*+ index(cbc CBC_EXPEDICION_I) */COUNT (1)
                            FROM cbc
                           WHERE expedicion = hoj.expedicion
                             AND tiplec <> 55
                             AND tiplec <> 57
                             AND tiplec <> 58
                             AND tiplec <> 61
                             AND keydel = :2
                             AND fecha  < :3
                             AND ROWNUM = 1) lecturasafc,
                         (SELECT /*+ index(cbc CBC_EXPEDICION_I) */ COUNT (1)
                            FROM cbc
                           WHERE expedicion = hoj.expedicion
                             AND tiplec <> 55
                             AND tiplec <> 57
                             AND tiplec <> 58
                             AND tiplec <> 61
                             AND keydel = :4
                             AND fecha >= :5
                             AND ROWNUM = 1) lecturasdfc,
                         CASE
                           WHEN EXISTS (SELECT 1
                                          FROM ncpt_carga_exp xnce
                                         WHERE xnce.expedicion = hoj.expedicion
                                           AND xnce.ncpt  = :6
                                           AND xnce.plaza = :7)
                             THEN 'S'
                             ELSE 'N'
                         END existe_ncpt_carga_uc,
                         0 AS incidencia,
                         pac_master_palet.esta_exp_en_master_palet (hoj.expedicion,
                                                                    :8,
                                                                    :9,
                                                                    :10) AS en_mp,
                         pac_master_jaulas.esta_exp_en_master_jaula (hoj.expedicion,
                                                                     :11,
                                                                     :12,
                                                                     :13) AS en_mj,
                         NVL(ncpt_camion, 0) AS ncpt_camion,
                         NVL(obhoj1, 0) AS obhoj1,
                         (SELECT /*+ index(cbc CBC_EXPEDICION_I) */ COUNT(1)
                            FROM cbc
                           WHERE keydel = :14
                             AND tiplec = 62
                             AND fecha >= :15
                             AND cbc.expedicion = hoj.expedicion
                             AND ROWNUM = 1) AS descarga_fin_carga,
null as bultos_manifiesto,
null as bultos_ncpt
                    FROM hoj
                   WHERE keytsv <> 30 AND keytst <> 15
                     AND actua <> 2 AND actua <> 4 AND actua <> 9
                     AND NVL (retenido_previo, 0) <> 1
                     AND NVL (retenido_sistema, 0) <> 1
                     AND NVL (ret_etiqueta_propia, 0) <> 1
                     AND NVL (ncpt_camion_cor, 0) = 0
                     AND codpla1 IN (:16,
                                         (SELECT keydel
                                            FROM del
                                          WHERE del_principal_inter = :17
                                          AND PAC_UTILIDADES.LEE_PAR_NUMBER(:18, 'PAR_CP_AUTOMAT_EN_PI') = 1))
                     AND pac_paletizacion.esta_expedicion_paletizada (hoj.expedicion) = 0
                     AND (SELECT COUNT (1)
                            FROM ncpt_carga_exp nce, ncpt_carga_uc ncu
                           WHERE nce.expedicion = hoj.expedicion
                             AND nce.ncpt  = :19
                             AND ncu.plaza = :20
                             AND ncu.lectura = nce.lectura
                             AND ncu.ncpt = nce.ncpt
                             AND ncu.tipo = 'B') = 0
                     AND hoj.bultos <> (SELECT COUNT (DISTINCT ncb.keybul)
                                          FROM ncpt_carga_bul ncb
                                         WHERE ncb.expedicion = hoj.expedicion
                                           AND ncb.plaza = :21)
                     AND codpla2 IN ('035')
                     AND pac_trazabilidad.es_producto_valido_parada (:22, :23, hoj.expedicion) = 1
                   UNION ALL
                  SELECT *
 FROM (SELECT 1 coordinada,
  0 etiqueta,
  lle.nenvio,
  lle.expedicion,
  lle.codpla1,
  lle.codpla2,
  lle.codremi,
  (lle.codremi || ' ' || lle.nomrte) nomremi,
  lle.codcons,
  lle.nomcons,
  lle.kilos,
  lle.bultos,
  DECODE (lle.keytsv,
  3, (SELECT NVL (keyemb, 'PA')
FROM rho_int
WHERE rho_int.expedicion = lle.expedicion),
  NVL (lle.keyemb, 'PA'))
  tipo_uc,
  NVL (lle.keyemb, 'PA') AS keyemb,
  lle.referencia,
  lle.fecha,
  NVL (mrc.ocultapendientecarga, 0) ocultar,
  lle.keytst,
  (SELECT denom
 FROM tst
WHERE keytst = lle.keytst)
  denomtst,
  lle.keytsv,
  (SELECT denom
 FROM tsv
WHERE keytsv = lle.keytsv)
  denomtsv,
  pac_internacional.exp_internacional (lle.expedicion)
  internacional,
  (SELECT /*+ index(cbc CBC_EXPEDICION_I) */ MAX (fecha)
 FROM cbc
WHERE   cbc.expedicion = lle.expedicion
  AND cbc.tiplec <> 57
  AND cbc.tiplec <> 58
  AND cbc.tiplec <> 62
  AND cbc.keydel = :24)
  AS ultima_lectura,
  (SELECT /*+ index(cbc CBC_EXPEDICION_I) */ COUNT (1)
 FROM cbc
WHERE   cbc.expedicion = lle.expedicion
  AND cbc.tiplec <> 55
  AND cbc.tiplec <> 57
  AND cbc.tiplec <> 58
  AND cbc.tiplec <> 61
  AND cbc.keydel = :25
  AND cbc.fecha < :26
  AND ROWNUM = 1)
  lecturasafc,
  (SELECT /*+ index(cbc CBC_EXPEDICION_I) */ COUNT (1)
 FROM cbc
WHERE   cbc.expedicion = lle.expedicion
  AND cbc.tiplec <> 55
  AND cbc.tiplec <> 57
  AND cbc.tiplec <> 58
  AND cbc.tiplec <> 61
  AND cbc.keydel = :27
  AND cbc.fecha >= :28
  AND ROWNUM = 1)
  lecturasdfc,
  CASE
  WHEN EXISTS
(SELECT 1
  FROM ncpt_carga_exp xnce
 WHERE xnce.expedicion = lle.expedicion
AND xnce.ncpt = :29
AND xnce.plaza = :30
AND ROWNUM = 1)
  THEN
  'S'
  ELSE
  'N'
  END
  existe_ncpt_carga_uc,
  (SELECT COUNT (1)
 FROM hes
WHERE   hes.expedicion = lle.expedicion
  AND hes.plaza = lle.codpla2
  AND (   hes.keyfti = 'B101'
OR hes.keyfti = '9907'
OR hes.keyfti = '110104'
OR hes.keyfti = '110204'
OR hes.keyfti = '110303'
OR hes.keyfti = '120104'
OR hes.keyfti = '1101')
  AND ROWNUM = 1)
  AS incidencia,
  pac_master_palet.esta_exp_en_master_palet (lle.expedicion,
 :31,
 :32,
 :33)
  AS en_mp,
  pac_master_jaulas.esta_exp_en_master_jaula (lle.expedicion,
  :34,
  :35,
  :36)
  AS en_mj,
  1 AS ncpt_camion,
  0 AS obhoj1,
  (SELECT /*+ index(cbc CBC_EXPEDICION_I) */ COUNT (1)
 FROM cbc
WHERE   keydel = :37
  AND tiplec = 62
  AND fecha >= :38
  AND expedicion = mrc.expedicion
  AND ROWNUM = 1)
  AS descarga_fin_carga,
  (SELECT COUNT (DISTINCT bulto)
 FROM manifiesto_carga mc
WHERE   mc.expedicion = lle.expedicion
  AND mc.plaza_cp = :39
  AND mc.ncpt <> :40)
  AS bultos_manifiesto,
  (SELECT COUNT (DISTINCT ncb.keybul)
 FROM ncpt_carga_bul ncb
WHERE   ncb.expedicion = lle.expedicion
  AND ncb.plaza = :41
  AND ncb.ncpt <> :42)
  AS bultos_ncpt
 FROM cor, mva_rho_coor mrc, lle
WHERE   lle.expedicion = mrc.expedicion
  AND lle.keytsv <> 30
  AND lle.keytst <> 15
  AND mrc.estado = 1
  AND mrc.keydeld = :43
  AND cor.usr_plaza = mrc.keydeld
  AND cor.codpla1 = mrc.codpla1
  AND cor.codpla2 = mrc.codpla2
  AND cor.remesa = mrc.remesa
  AND cor.actua = 3
  AND cor.ncpt_i = mrc.ncpt
  AND cor.ncpt_c = 0
  AND cor.codpla2 IN ('035')
  AND pac_paletizacion.esta_expedicion_paletizada (mrc.expedicion) = 0
  AND pac_trazabilidad.es_producto_valido_parada ( :44, :45, mrc.expedicion) = 1
  AND EXISTS
  (SELECT 1
 FROM bul
WHERE   bul.expedicion = lle.expedicion
  AND NOT EXISTS
  (SELECT /*+ index(cbc CBC_EXPEDICION_I) */ 1
 FROM cbc
WHERE   cbc.expedicion =
  bul.expedicion
  AND keydel =
  SUBSTR (bul.keybul,
  1,
  3)
  AND (   bul.keybul =
  cbc.keybul
OR bul.bulcli =
  cbc.keybul
OR bul.sscc = cbc.keybul))
          AND ROWNUM = 1)
  AND (SELECT /*+ index(cbc CBC_EXPEDICION_I) */ COUNT (1)
 FROM cbc
WHERE   cbc.expedicion = lle.expedicion
  AND cbc.keydel = :46
  AND ROWNUM = 1) > 0
  AND (SELECT COUNT (1)
 FROM ncpt_carga_exp nce, ncpt_carga_uc ncu
WHERE   nce.expedicion = lle.expedicion
  AND nce.ncpt = :47
  AND ncu.plaza = :48
  AND ncu.lectura = nce.lectura
  AND ncu.ncpt = nce.ncpt
  AND ncu.tipo = 'B') = 0)
WHERE bultos <> bultos_manifiesto
  AND bultos <> bultos_ncpt

