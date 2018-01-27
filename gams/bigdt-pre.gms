SETS
        I       'Canning plants'  / SEATTLE, SAN-DIEGO /
        J       'Markets'         / LOAD1, LOAD2, LOAD3 / ;

PARAMETERS
        A(I)    'Capacity of plant i in cases'
                / SEATTLE       22
                  SAN-DIEGO     27 /
        B(J)    'Demand at market j in cases'
                / LOAD1, LOAD2, LOAD3 /

        LOAD1(T) 'LOAD'
                / 1    13.23
                  2    13.64
                  3    14.39
                  4    14.65
                  5    15.21
                  6    15.51
                  7    15.98
                  8    16.09
                  9    16.54
                  10    16.99
                  11    18.02
                  12    19.11
                  13    19.88
                  14    20
                  15    20.47
                  16    20.81
                  17    19.92
                  18    18.93
                  19    16.81
                  20    15.83
                  21    15.17
                  22    16
                  23    15.19
                  24    16.18 /

        LOAD2(T) 'LOAD'
                / 1    17.23
                  2    7.64
                  3    12.39
                  4    11.65
                  5    14.21
                  6    11.51
                  7    12.98
                  8    24.09
                  9    18.54
                  10    21.99
                  11    25.02
                  12    27.11
                  13    26.88
                  14    16
                  15    18.47
                  16    18.81
                  17    25.92
                  18    12.93
                  19    11.81
                  20    18.83
                  21    14.17
                  22    15
                  23    10.19
                  24    10.18 /

        LOAD3(T) 'LOAD'
                / 1    8.23
                  2    15.64
                  3    14.39
                  4    6.65
                  5    20.21
                  6    10.51
                  7    6.98
                  8    7.09
                  9    7.54
                  10    18.99
                  11    15.02
                  12    17.11
                  13    12.88
                  14    24
                  15    20.47
                  16    12.81
                  17    24.92
                  18    19.93
                  19    21.81
                  20    17.83
                  21    13.17
                  22    6
                  23    10.19
                  24    6.18   /

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

TABLE D(I, J)   'Distance in thousands of miles'
                      LOAD1      LOAD2     LOAD3
        SEATTLE        650        650       650
        SAN-DIEGO      650        650       650 ;

SCALAR POWER_COST 'Freight in dollars per case per thousand miles' / 350 / ;

PARAMETER C(I, J)       'Transport cost in thousands of dollars per case' ;
          C(I, J) = F * D(I, J) / 1000 ;

VARIABLES
        X(I, J)         'Shipment quantities in cases'
        Z               'Total transportation costs in thousands of dollars' ;

POSITIVE VARIABLE X ;

EQUATIONS
        COST            'Define objective function'
        SUPPLY(I)       'Observe supply limit at plant i'
        DEMAND(J)       'Satisfy demand at market j';

COST ..             Z         =E=  SUM((I, J), C(I, J) * X(I, J)) ;
SUPPLY(I) .. SUM(J, X(I, J))  =L=  A(I) ;
DEMAND(J) .. SUM(I, X(I, J))  =G=  B(J) ;

MODEL TRANSPORT /ALL/ ;
SOLVE TRANSPORT USING LP MAXIMIZING Z;
