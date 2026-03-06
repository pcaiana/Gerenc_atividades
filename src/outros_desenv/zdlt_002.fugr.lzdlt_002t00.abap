*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLT_002........................................*
DATA:  BEGIN OF STATUS_ZDLT_002                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDLT_002                      .
CONTROLS: TCTRL_ZDLT_002
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDLT_002                      .
TABLES: ZDLT_002                       .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
