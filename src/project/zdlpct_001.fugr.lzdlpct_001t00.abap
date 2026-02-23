*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLPCT_001......................................*
DATA:  BEGIN OF STATUS_ZDLPCT_001                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDLPCT_001                    .
CONTROLS: TCTRL_ZDLPCT_001
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDLPCT_001                    .
TABLES: ZDLPCT_001                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
