/* START WITH PROC PRINTTO STATEMENT WITH LOG PATH*/
proc printto log="/path/to/log/file.log" new;
run;


/* START SAS LOGIC*/

%let till=1250000;
%PUT LOG CREATE DATA Test_&till;
data Test_&till;
array prob[6] _temporary_ (0.05, 0.4, 0.1, 0.1, 0.3, 0.05);
length a b c d e varchar(80);
length f g h i j varchar(160);
length k l m n o p varchar(40);
do count = 1 to &till.;
    a = cat('A',Round(rand('uniform')*5)+1);
    b = cat('B',Round(rand('uniform')*10)+1);
    c = cat('C',rand('Table', of prob[*]));
    d = cat('D',rand('GAMMA',10));
    e = cat('E',rand('POISSON',5));
    f = cat('F',Round(rand('uniform')*5)+1);
    g = cat('G',Round(rand('uniform')*10)+1);
    h = cat('H',rand('Table', of prob[*]));
    i = cat('I',rand('GAMMA',5));
    j = cat('J',rand('POISSON',10));
    k = rand('Bernoulli',0.3);
    l = rand('Bernoulli',0.4);
    m = rand('Bernoulli',0.5);
    n = rand('Bernoulli',0.5);
    o = rand('Bernoulli',0.4);
    p = rand('Bernoulli',0.3);
    q = rand('uniform')*1;
    r = rand('uniform')*10;
    s = rand('uniform')*100;
    t = rand('uniform')*1000;
    u = rand('uniform')*10000;
    v = rand('uniform')*100000;
    w = rand('uniform')*1000000;
    x = rand('uniform')*10000000;
    output;
end;
run;

/* END SAS LOGIC*/


/* END WITH PROC PRINTTO STATEMENT */
proc printto new;
run;
