/*
Copyright (C) 2016  Source Market Access Ltd

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
mata: mata clear 
mata:
void nozero(Q) {
 		M = st_matrix(Q)
		non_zero = select(select(M, rowsum(abs(M))),colsum(abs(M))) 
		st_matrix("VarCovar", non_zero)
}
end

program define distoutmix
syntax [varlist(default=none fv)] [if], dlist(string) links(string) fname(string)	///
	sname(string) [note(string) MODify]


if "`modify'" == "" {
	putexcel set "`fname'", sheet("`sname'", replace) modify
}
else {
	putexcel set "`fname'", sheet("`sname'". modify) modify
}

local myrow = 6

local trow=`myrow'-1
putexcel A1="`c(current_date)'"
putexcel A2="`c(current_time)'"
putexcel A3="`note'"
putexcel D`trow'="Coef." E`trow'="Std. Err" F`trow'="ll" ///
	G`trow'="ul" H`trow'="Variance-covariance" B`trow'="Link" A`trow'="Dist."

foreach dist in `dlist' {
	foreach mylink in `links' {
		*Run regression and store output
		di "Mixture cure model: `dist', `mylink'"
		cap noisily strsmix `varlist' `if', dist(`dist') link(`mylink') bhazard(hazard0) iter(100)
		estimates store `dist'_`mylink'
		if _rc==0 {
			matrix A = e(V)
			local nvars = rowsof(A) //Includes ommitted variables
			matrix B = r(table)'
			local rownms: rown B    //Row names
			
			*Get variance-covriance matrix without zeros
			mata: nozero("A")

			if !missing("`j'") {
				local myrow = `myrow' + `j'
			}
			qui putexcel A`myrow' = ("`dist'")
			qui putexcel B`myrow' = ("`mylink'")
			local j = 0
			
			qui putexcel H`myrow' = matrix(VarCovar)
			
			forvalues i = 1/`nvars' {	
				if !missing(B[`i', 2]) {
					local rowname: word `i' of `rownms'
					local mynewrow = `myrow' + `j'
					local mycoef = B[`i', 1]
					local myse   = B[`i', 2]
					local myll   = B[`i', 5]
					local myul   = B[`i', 6]
					
					quietly {
						putexcel C`mynewrow' = "`rowname'"
						putexcel D`mynewrow' = `mycoef'
						putexcel E`mynewrow' = `myse'
						putexcel F`mynewrow' = `myll'
						putexcel G`mynewrow' = `myul'
					}
					local j = `j' + 1	
				}		
			}
		}
	}
}
putexcel close
estimates stats *
estimates clear
end
