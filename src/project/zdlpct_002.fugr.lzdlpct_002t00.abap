*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLPCT_002......................................*
DATA:  BEGIN OF STATUS_ZDLPCT_002                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDLPCT_002                    .
CONTROLS: TCTRL_ZDLPCT_002
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDLPCT_002                    .
TABLES: ZDLPCT_002                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
