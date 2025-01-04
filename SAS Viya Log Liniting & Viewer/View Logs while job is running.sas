/* View Logs while job is running */
proc python;
submit;
import os
logpath="/path/to/log/file.log"
os.system("cat "+logpath)
endsubmit;
run;
