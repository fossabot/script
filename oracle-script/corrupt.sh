set heading off
set lines 113
SELECT 'dd of=' || f.file_name || ' bs=8192 conv=notrunc seek=' ||
       to_number(S.HEADER_BLOCK + 1) || ' << EOF',
       'CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt CORRUPT corrupt CORRUPT CORRUPT CORRUPT CORRUPT corrupt corrupt ',
       'EOF'
  FROM DBA_SEGMENTS s, dba_data_files f
 WHERE f.tablespace_name = 'CORRUPT'  AND s.segment_name like 'X%'
;