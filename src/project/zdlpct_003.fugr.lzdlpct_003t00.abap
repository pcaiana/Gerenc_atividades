*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDLPCT_003......................................*
DATA:  BEGIN OF STATUS_ZDLPCT_003                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDLPCT_003                    .
CONTROLS: TCTRL_ZDLPCT_003
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDLPCT_003                    .
TABLES: ZDLPCT_003                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
