{smcl}
{* *! version 1.0.3  1 Mar 2010}{...}
{cmd:help htasurv} 

{title:Title}

{p2colset 5 12 14 2}{...}
{p2col :{hi:htasurv} {hline 2}}Fit alternative parametric survival distributions and report goodness-of-fit statistics for health economic evaluations Use htasurv (distfind And distanalysis) With STATA 18{p_end}
{p2colreset}{...}

{title:Description}

Fit alternative parametric survival distributions and report goodness-of-fit statistics for health economic evaluations Use htasurv (distfind And distanalysis) With STATA 18 
Fit alternative parametric survival distributions and report statistics relevant for health technology assessment Use distfind With STATA 18
Report results of parametric survival analysis for use in health technology assessment Use distanalysis With STATA 18

{title:Examples}

{phang}{cmd: # Install htasurv ado From Github Olah Data Semarang (timbulwidodostp)}

{phang}{cmd:. net install htasurv, from("https://raw.githubusercontent.com/timbulwidodostp/htasurv/main/htasurv") replace}

{phang}{cmd: # Use (Open) File Input From Github Olah Data Semarang (timbulwidodostp)}

{phang}{cmd:. import excel "https://raw.githubusercontent.com/timbulwidodostp/htasurv/main/htasurv/htasurv.xlsx", sheet("Sheet1") firstrow clear}

{phang}{cmd:. import delimited "https://raw.githubusercontent.com/timbulwidodostp/htasurv/main/htasurv/test_varcovar.txt", clear}

{phang}{cmd:. export delimited htasurv using "C:\Portable STATA 18 MP WA 085227746673\OlahDataSemarang WA 085227746673\Stata18\test_varcovar.txt", replace}

{phang}{cmd:. # Fit alternative parametric survival distributions and report goodness-of-fit statistics for health economic evaluations Use htasurv (distfind And distanalysis) With STATA 18}

{phang}{cmd:. global dlist "gamma ggamma weibull gompertz exponential lognormal loglogistic"}

{phang}{cmd:. distfind age i.drug, dlist($dlist) timevar(studytime) failure(died)}

{phang}{cmd:. distanalysis age i.drug, sdist(gompertz) doctitle(test) caption(“Gompertz”)"}

{title:Authors}

Timbul Widodo
Olah Data Semarang
WA : +6285227746673 (085227746673)
Receive Statistical Analysis Data Processing Services Using
SPSS, AMOS, LISREL, Frontier 4.1, EVIEWS, SMARTPLS, STATA
DEAP 2.1, ETC

{title:Also see}
Olah Data Semarang
WA : +6285227746673 (085227746673)
Receive Statistical Analysis Data Processing Services Using
SPSS, AMOS, LISREL, Frontier 4.1, EVIEWS, SMARTPLS, STATA
DEAP 2.1, ETC
{psee}
{p_end}
