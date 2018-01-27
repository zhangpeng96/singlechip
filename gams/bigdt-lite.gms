SETS
        I       'Canning plants'  / SEATTLE, SAN-DIEGO /
        J       'Markets'         / NEW-YORK, CHICAGO, TOPEKA /
        T       'Markets'         / 1*3 / ;

PARAMETERS
        A(I)    'Capacity of plant i in cases'
                / SEATTLE       650
                  SAN-DIEGO     600 /
        B(J)    'Demand at market j in cases'
                / NEW-YORK      325
                  CHICAGO       460
                  TOPEKA        275 /
        PR(T)    'Demand at market j in cases'
                / 1       1325
                  2       1460
                  3       1275 / ;

TABLE D(I, J)   'Distance in thousands of miles'
                    NEW-YORK    CHICAGO   TOPEKA
        SEATTLE        2.5        1.7       1.8
        SAN-DIEGO      2.5        1.8       1.4 ;


TABLE LOAD(T, J)   'Distance in thousands of miles'
               NEW-YORK    CHICAGO   TOPEKA
        1        325        460       275
        2        360        480       320
        3        2.5        1.8       1.4 ;


SCALAR F 'Freight in dollars per case per thousand miles' /90/ ;

PARAMETER C(I, J)       'Transport cost in thousands of dollars per case' ;
          C(I, J) = F * D(I, J) / 1000 ;

VARIABLES
        X(I, J)         'Shipment quantities in cases'
        Z               'Total transportation costs in thousands of dollars'
         OUTPUT;

POSITIVE VARIABLE X ;

EQUATIONS
        COST            'Define objective function'
        SUPPLY(I)       'Observe supply limit at plant i'
        DEMAND(J)       'Satisfy demand at market j'
        TEST;

COST ..             Z         =E=  SUM((I, J), C(I, J) * X(I, J)) ;
SUPPLY(I) .. SUM(J, X(I, J))  =L=  A(I) ;
DEMAND(J) .. SUM(I, X(I, J))  =G=  LOAD('1', J) ;
TEST .. OUTPUT =E= SUM(J,SUM(T,LOAD(T,J)));


MODEL TRANSPORT /ALL/ ;
SOLVE TRANSPORT USING LP MINIMIZING Z;
