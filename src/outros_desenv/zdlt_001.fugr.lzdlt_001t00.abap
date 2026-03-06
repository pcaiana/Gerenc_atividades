*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLT_001........................................*
DATA:  BEGIN OF STATUS_ZDLT_001                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDLT_001                      .
CONTROLS: TCTRL_ZDLT_001
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDLT_001                      .
TABLES: ZDLT_001                       .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
