LIBNAME GEOFILE ".";

option compress=Yes;
option casdatalimit=all;
proc mapimport
   datafile="./INDIAN_STATE.shp"
   out=INDIA_STATE_RAW;
run;

data INDIA_STATE;
set INDIA_STATE_RAW;
	SEQUENCE=_n_;
run;

proc greduce data=INDIA_STATE out=GEOFILE.INDIA_STATE;
	id State_LGD;
run;


PROC FREQ DATA=GEOFILE.INDIA_STATE;
TABLE DENSITY;
run;

PROC GMAP map=GEOFILE.INDIA_STATE data=geofile.india_state all;
	id State_LGD;
   choro Density / coutline=blue;
run;



proc mapimport
   datafile="./INDIAN_DIST.shp"
   out=INDIAN_DIST_RAW;
run;

data INDIAN_DIST;
set INDIAN_DIST_RAW;
	SEQUENCE=_n_;
run;

proc greduce data=INDIAN_DIST out=GEOFILE.INDIAN_DIST;
	id State_LGD DISTRICT_L ;
run;


PROC FREQ DATA=GEOFILE.INDIAN_DIST;
TABLE DENSITY;
run;

PROC GMAP map=GEOFILE.INDIAN_DIST data=GEOFILE.INDIAN_DIST all;
	id State_LGD DISTRICT_L;
   choro Density / coutline=blue;
run;

/* CLEAN DATA */
/* ">":"A" "|","I"   "@","U" */
data GEOFILE.INDIA_STATE;
	set geofile.INDIA_STATE;
	STATE=translate(STATE,"U","@");
	STATE=translate(STATE,"I","|");
	STATE=translate(STATE,"A",">");
run;

data GEOFILE.INDIAN_DIST;
	set GEOFILE.INDIAN_DIST;
	District=translate(District,"U","@");
	District=translate(District,"I","|");
	District=translate(District,"A",">");
	STATE=translate(STATE,"U","@");
	STATE=translate(STATE,"I","|");
	STATE=translate(STATE,"A",">");
run;

/* TEST */
proc casutil;
	droptable casdata="MAPTEST" incaslib="casuser" quiet;
run;
quit;
proc sort data=GEOFILE.INDIAN_DIST(KEEP=State_LGD 'STATE'n DISTRICT_L District) nodupkey
	out=casuser.MAPTEST(promote=Yes);
by State_LGD DISTRICT_L STATE District;
run;

PROC FREQ DATA=GEOFILE.INDIAN_DIST;
TABLES STATE DISTRICT;
run;

