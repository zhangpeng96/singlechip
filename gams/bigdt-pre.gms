SETS
        I       'Canning plants'  / SEATTLE, SAN-DIEGO /
        J       'Markets'         / LOAD1, LOAD2, LOAD3 /
        T       'Markets'         / 1 * 24 / ;

PARAMETERS
        A(I)    'Capacity of plant i in cases'
                / SEATTLE       22
                  SAN-DIEGO     27 /

        PRICE(T) 'SELL PRICE'
                / 1    96.7687
                  2    89.9511
                  3    84.6939
                  4    81.0704
                  5    78.7205
                  6    75.258
                  7    68.6082
                  8    79.2705
                  9    95.4397
                  10    99.148
                  11    101.6208
                  12    103.3502
                  13    103.8025
                  14    103.9053
                  15    103.9172
                  16    103.14
                  17    101.4961
                  18    99.478
                  19    100.7609
                  20    101.054
                  21    104.6942
                  22    105.1309
                  23    104.5201
                  24    99.9302  / ;

TABLE LOAD(T, J)   'Distance in thousands of miles'
                        LOAD1    LOAD2    LOAD3
                   1    13.23    17.23    8.23
                   2    13.64    7.64     15.64
                   3    14.39    12.39    14.39
                   4    14.65    11.65    6.65
                   5    15.21    14.21    20.21
                   6    15.51    11.51    10.51
                   7    15.98    12.98    6.98
                   8    16.09    24.09    7.09
                   9    16.54    18.54    7.54
                  10    16.99    21.99    18.99
                  11    18.02    25.02    15.02
                  12    19.11    27.11    17.11
                  13    19.88    26.88    12.88
                  14    20       16       24
                  15    20.47    18.47    20.47
                  16    20.81    18.81    12.81
                  17    19.92    25.92    24.92
                  18    18.93    12.93    19.93
                  19    16.81    11.81    21.81
                  20    15.83    18.83    17.83
                  21    15.17    14.17    13.17
                  22    16       15       6
                  23    15.19    10.19    10.19
                  24    16.18    10.18    6.18   ;

TABLE D(I, J)   'Distance in thousands of miles'
                      LOAD1      LOAD2     LOAD3
        SEATTLE        650        650       650
        SAN-DIEGO      650        650       650 ;


SCALAR POWER_COST 'Freight in dollars per case per thousand miles' / 350 / ;

VARIABLES
        X(I, J)         'Shipment quantities in cases'
        Z               'Total transportation costs in thousands of dollars' ;

POSITIVE VARIABLE X ;

EQUATIONS
        COST            'Define objective function'
        SUPPLY(I)       'Observe supply limit at plant i'
        DEMAND(J)       'Satisfy demand at market j';

COST ..             Z         =E=  SUM((I, J), ( D(I, J) + POWER_COST) * X(I, J)) ;
SUPPLY(I) .. SUM(J, X(I, J))  =L=  A(I) ;
DEMAND(J) .. SUM(I, X(I, J))  =G=  LOAD('2', J) ;

MODEL TRANSPORT /ALL/ ;
SOLVE TRANSPORT USING LP MINIMIZING Z;
