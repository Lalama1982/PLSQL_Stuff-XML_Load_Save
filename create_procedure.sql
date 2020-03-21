--------------------------------------------------------
--  File created - Thursday-January-25-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure PROC_XML
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "TEST_USER"."PROC_XML" IS 
  lv_xml          XMLTYPE; 
  lv_path         CONSTANT VARCHAR2 (50)  :=  '/tag1/tag2'; 
  
begin 
  select extract(xmlcol,'/*') 
  into lv_xml
  from (SELECT xmltype(BFILENAME('MY_DIR3', 'fxml.xml'),nls_charset_id('UTF-8')) xmlcol FROM dual);  

  FOR lp_clob_data IN ( 
    SELECT * 
      FROM XMLTABLE('/tag1/tag2' 
        PASSING lv_xml 
        COLUMNS lv_tag31 VARCHAR2(150) PATH './tag31/text()', 
                lv_tag32 varchar2(150) path './tag32/text()', 
                lv_tag33 varchar2(150) path './tag33/text()',
                lv_tag34 XMLTYPE PATH 'tag34'                
      )xml_sample 
   ) LOOP 

   insert into test_33 values(lp_clob_data.lv_tag31,lp_clob_data.lv_tag32,lp_clob_data.lv_tag33);

    FOR lp_clob_data_c IN ( 
      SELECT * 
        from xmltable('/tag34/tag34_c' 
          passing lp_clob_data.lv_tag34 
          columns lv_tag34_c_1 varchar2(150) path './tag34_c_1/text()', 
                  lv_tag34_c_2 varchar2(150) path './tag34_c_2/text()'
        )xml_sample 
     ) loop 
      insert into test_33 values(lp_clob_data_c.lv_tag34_c_1,lp_clob_data_c.lv_tag34_c_2,'101010');

     END LOOP;

  end loop; 
  commit;  

End;

/
