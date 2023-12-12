-- ===============================================================
-- NAME: problem.sql
-- DESCRIPTION: 
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
declare cursor pal is
               SELECT * FROM stocks_lote WHERE
                  STL_CODCLI='385' AND STL_CODALM='56' and stl_codtst='BL' and stl_codlot<>'-2';
 
stock number;
canrec number;
canrecl number;
canreco number;
begin
for p in pal loop
       SELECT NVL(sum(pal_stocpa),0) into stock
        FROM paletas
        where pal_propie=p.stl_codcli
          and pal_almace=p.stl_codalm
          and pal_articu=p.stl_codart
          and pal_varia1=p.stl_varia1
          and pal_varia2=p.stl_varia2
          and pal_varlog=p.stl_varlog
          and p.stl_codlot=nvl(pal_lotefa,'-1')
          and pal_clasto=p.stl_clasto
          and (pal_sitpal='BL' or pal_sitlog<>'DI')
          AND PAL_SITPAL NOT IN ('NL','BA');
 
 
       if stock <> p.stl_cantid then
        dbms_output.put_line('Stock Bloqueado: Almacén;'||stock||';Modulos;'||p.stl_cantid||';Articulo: '|| P.stl_CODART||';'|| P.stl_varia1||';'|| P.stl_varia2||';'|| P.stl_varlog||'; Lote: '|| P.stl_codlot||'; Clase: '|| P.stl_clasto);
      end if;
      END LOOP;
 END;

