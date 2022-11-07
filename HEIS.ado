
**# main program

program define HEIS

	version 17
	clear all

syntax anything [,  weight(string) data(string) path(string)]
if "`path'" != ""{
	cd "`path'"
}

	if "`weight'" == "true"{
	    foreach year in `anything'{
			local Year : di mod(`year',100)
		    copy https://github.com/AliBahramiSani/Iran-Household-Expenditure-and-Income-Survey/raw/main/HEIS%20Weights/HHWeights`year'.dta "\HHWeights`year'.dta" , replace
	}
	}
	if "`data'" == "true"{
	    foreach year in `anything'{
			local Year : di mod(`year',100)
		    copy https://github.com/AliBahramiSani/HEIS_Data/raw/main/`year'.zip "./`year'.zip" , replace
// 			unzipfile `year'.zip, replace
			
			unzipfile "`year'.zip", replace
			cap erase "year.zip"
// 			! move /y ".\`Year'\*.mdb" ".\"
	}
	}

// 	89p1  Sum_U89New
local tables Data KarBagh1 KarBagh2 P1 P2 P3S01 P3S02 P3S03 P3S04 P3S05 P3S06 P3S07 P3S08 P3S09 P3S10 P3S11 P3S12 P3S13 P3S14 P4S01 P4S02 P4S03 P4S1 P4S2 P4S3 P4S04
di "`tables'"

	foreach year in `anything'{
		if `year' == 1400 {
			local Year `year'
		}
		else{
			local Year : di mod(`year',100)
		}
		
		di "`year'"
		odbc query "MS Access Database", dialog(complete)
		cap odbc load, table(U`Year') lowercase
			if _rc!=0 {
				display "`Year' not found!"
			}
			
			append_UR "" `Year'
// 			cap save `year', replace
		foreach table in `tables'{
			di "cleaning table `table' of `Year'"
			clear
			cap odbc load, table(U`Year'`table') lowercase
			if _rc!=0 {
				display "U`Year'`table' not found!"
				continue
			}
			append_UR `table' `Year'
			clear
			
		}
		
		if `year' == 89{
			di "`year'"
			local table Sum_R89New
			di "cleaning table `table' of `Year'"
			cap odbc load, table("`table'") lowercase
			if _rc!=0 {
				display "`table' not found!"
				continue
			}
			cap save `table',replace 
			clear
			local table 89P1
			di "cleaning table `table' of year `year'"
			cap odbc load, table("U`table'") lowercase
			if _rc!=0 {
				display "U`table' not found!"
				continue
			}
			local year = ""
			cap append_UR `table' `Year'
		}
		*odbc desc "U`i'P4S03"
// 		odbc load, table("U`year'P1")
	
	}


end

**# append program
program define append_UR 
args table year
	gen urban=1
// 	cap `table' `year' // clean
	save U`year'`table'.dta, replace
	clear
	di "`year'"
	di "R`year'`table'"
	cap odbc load, table("R`year'`table'") lowercase
	if _rc!=0 {
			display "R`year'`table' not found!"
			continue
		}
	gen urban=0
// 	cap `table' `year' // clean routine
	save R`year'`table'.dta, replace
	append using U`year'`table'
	save `year'`table', replace
	clear
	erase R`year'`table'.dta
	erase U`year'`table'.dta
end

**# clean_p1 subroutine !!! alaki
program define P1
args year
gen province = substr( address, 1,3)
gen county = substr( address, 1,5)
destring _all, force replace
replace province = province-100
replace county = county - 10000
ren (dycol01 dycol03 dycol04 dycol05 dycol06 dycol07 dycol08 dycol09 dycol10) (memberNumber rel2Head gender age literacy isEducating education activityStatus marriageStatus)
replace gender=0 if gender==2
replace literacy=0 if literacy!=1
replace isEducating=0 if isEducating==2
replace education=0 if literacy==0
egen familySize= count(address), by(address)

/*
egen WorkingAge = count(address) if Age>=15 & Age <=65, by(address)
*/
label var province "Province of residency"
label var address "Household ID"
label var rel2Head "Relationship to the household head"
label var activityStatus "Activity status"
label var education "Education level"
label var familySize "Family size"
label var marriageStatus "Marital status"
label var urban "Urbanity"
label var gender ""
label var age ""
label var literacy ""
label define rel2Head 0 "Not head" 1 "Head"
label values rel2Head rel2Head
label define activityStatus 0 "Not employed" 1 "Employed"
label values activityStatus activityStatus
label define gender 0 "Female" 1 "Male"
label values gender gender
label define literacy 0 "Illiterate" 1 "Literate"
label values literacy literacy
label define education 0 "Illiteracy" 1 "Primary school" 2 "Middle school" 3 "High school" 4 "Diploma & pre-university" 5 "Associate degree" 6 "‌Bachelor" 7 "Master/professional doctorate" 8 "PhD" 9 "Other & unofficial"
label values education education
label define YesNo 0 "NO" 1 "YES"
label values isEducating YesNo
label define marriageStatus 0 "Not married" 1 "Married"
label values marriageStatus marriageStatus
label define urban 0 "Rural" 1 "Urban"
label values urban urban
save U`year'P1.dta, replace 
clear

// odbc load, table("R`year'P1") lowercase
gen province = substr( address, 1,3)
gen county = substr( address, 1,5)
destring _all, force replace
replace province = province-200
replace county = county - 20000
ren (dycol01 dycol03 dycol04 dycol05 dycol06 dycol07 dycol08 dycol09 dycol10) (memberNumber rel2Head gender age literacy isEducating education activityStatus marriageStatus)
replace gender=0 if gender==2
replace literacy=0 if literacy!=1
replace isEducating=0 if isEducating==2
replace education=0 if literacy==0
egen familySize= count(address), by(address)
// gen urban=0
/*
egen WorkingAge = count(address) if Age>=15 & Age <=65, by(address)
*/
label var province "Province of residency"
label var address "Household ID"
label var rel2Head "Relationship to the household head"
label var activityStatus "Activity status"
label var education "Education level"
label var familySize "Family size"
label var marriageStatus "Marital status"
label var urban "Urbanity"
label var gender ""
label var age ""
label var literacy ""
label define rel2Head 0 "Not head" 1 "Head"
label values rel2Head rel2Head
label define activityStatus 0 "Not employed" 1 "Employed"
label values activityStatus activityStatus
label define gender 0 "Female" 1 "Male"
label values gender gender
label define literacy 0 "Illiterate" 1 "Literate"
label values literacy literacy
label define education 0 "Illiteracy" 1 "Primary school" 2 "Middle school" 3 "High school" 4 "Diploma & pre-university" 5 "Associate degree" 6 "‌Bachelor" 7 "Master/professional doctorate" 8 "PhD" 9 "Other & unofficial"
label values education education
label define YesNo 0 "NO" 1 "YES"
label values isEducating YesNo
label define marriageStatus 0 "Not married" 1 "Married"
label values marriageStatus marriageStatus
label define urban 0 "Rural" 1 "Urban"
label values urban urban
// save R`year'P1.dta, replace
// append using U`year'P1
// save `year'P1, replace
// clear
// erase R`year'P1.dta
// erase U`year'P1.dta
end

**# P3S01 
program define P3S01
// clear
// odbc load address = "Address" Expenditure01 = "DYCOL06", table("U99P3S01") lowercase
destring _all, replace force
// collapse (sum) expenditure01, by(address)
save U99P3S01.dta, replace
clear
odbc load address = "Address" Expenditure01 = "DYCOL06", table("R99P3S01") lowercase
destring _all, replace force
// collapse (sum) expenditure01, by(address)
save R99P3S01.dta, replace
append using U99P3S01
save 99P3S01.dta, replace
end

**# P3S02
program define P3S02
clear
odbc load address = "Address" Expenditure02 = "DYCOL06", table("U99P3S02") lowercase
destring _all, replace force
collapse (sum) expenditure02, by(address)
save U99P3S02.dta, replace
clear
odbc load address = "Address" Expenditure02 = "DYCOL06", table("R99P3S02") lowercase
destring _all, replace force
collapse (sum) expenditure02, by(address)
save R99P3S02.dta, replace
append using U99P3S02
save 99P3S02.dta, replace
end

**# P3S03
program define P3S03
clear 
odbc load address = "Address" Expenditure03 = "DYCOL03", table("U99P3S03") lowercase
destring _all, replace force
collapse (sum) expenditure03, by(address)
save U99P3S03.dta, replace
clear
odbc load address = "Address" Expenditure03 = "DYCOL03", table("R99P3S03") lowercase
destring _all, replace force
collapse (sum) expenditure03, by(address)
save R99P3S03.dta, replace
append using U99P3S03
save 99P3S03.dta, replace
end

**# P3S04
program define P3S04
clear 
odbc load address = "Address" Expenditure04 = "DYCOL04", table("U99P3S04") lowercase
destring _all, replace force
collapse (sum) expenditure04, by(address)
save U99P3S04.dta, replace
clear
odbc load address = "Address" Expenditure04 = "DYCOL04", table("R99P3S04") lowercase
destring _all, replace force
collapse (sum) expenditure04, by(address)
save R99P3S04.dta, replace
append using U99P3S04
save 99P3S04.dta, replace
end

**# P3S05 P3S06 P3S07 P3S08 P3S09
program define P3S05
forvalues i = 5/9{
	** PS0`i' **
	clear 
	odbc load address = "Address" Expenditure0`i' = "DYCOL03", table(	"U99P3S0`i'") lowercase
	destring _all, replace force
	collapse (sum) expenditure0`i', by(address)
	save U99P3S0`i'.dta, replace
	clear
	odbc load address = "Address" Expenditure0`i' = "DYCOL03", table("R99P3S0`i'") lowercase
	destring _all, replace force
	collapse (sum) expenditure0`i', by(address)
	save R99P3S0`i'.dta, replace
	append using U99P3S0`i'
	save 99P3S0`i'.dta, replace
}
end

**# PS11 P3S12 **
program define P3S011
forvalues i = 11/12{
	** PS0`i' **
	clear 
	odbc load address = "Address" Expenditure`i' = "DYCOL03", table(	"U99P3S`i'") lowercase
	destring _all, replace force
	collapse (sum) expenditure`i', by(address)
	save U99P3S`i'.dta, replace
	clear
	odbc load address = "Address" Expenditure`i' = "DYCOL03", table("R99P3S`i'") lowercase
	destring _all, replace force
	collapse (sum) expenditure`i', by(address)
	save R99P3S`i'.dta, replace
	append using U99P3S`i'
	save 99P3S`i'.dta, replace
}
end
**# P3S13 
program define P3S13
clear
odbc load address = "Address" LoanAmount_InsuranceNumber = "DYCOL02" LoanSource = "DYCOL03" expenditure13 = "DYCOL05", table(U99P3S13)
encode LoanSource, gen(LoanSource1)
drop LoanSource
ren LoanSource1 LoanSource
destring address LoanAmount_InsuranceNumber expenditure13, replace force
gen LoanAmount = LoanAmount_InsuranceNumber if LoanAmount_InsuranceNumber>14
replace LoanAmount=0 if LoanAmount==.
drop LoanAmount_InsuranceNumber
*preserve
collapse (sum) expenditure13 LoanAmount, by(address)
*save tempLoanU.dta, replace
*restore
*keep address LoanSource
*merge m:m address using tempLoanU, nogen
save U99P3S13.dta, replace
clear
odbc load address = "Address" LoanAmount_InsuranceNumber = "DYCOL02" LoanSource = "DYCOL03" expenditure13 = "DYCOL05", table(R99P3S13)
encode LoanSource, gen(LoanSource1)
drop LoanSource
ren LoanSource1 LoanSource
destring address LoanAmount_InsuranceNumber expenditure13, replace force
gen LoanAmount = LoanAmount_InsuranceNumber if LoanAmount_InsuranceNumber>14
replace LoanAmount=0 if LoanAmount==.
drop LoanAmount_InsuranceNumber
*preserve
collapse (sum) expenditure13 LoanAmount, by(address)
*save tempLoanU.dta, replace
*restore
*keep address LoanSource
*merge m:m address using tempLoanU, nogen
save R99P3S13.dta, replace
append using U99P3S13
save 99P3S13.dta, replace
end

**# P3S14
program define P3S14
clear
odbc load address = "Address" Expenditure14 = "DYCOL03", table("U99P3S14") lowercase
destring _all, replace force
collapse (sum) expenditure14, by(address)
save U99P3S14.dta, replace
clear
odbc load address = "Address" Expenditure14 = "DYCOL03", table("R99P3S14") lowercase
destring _all, replace force
collapse (sum) expenditure14, by(address)
save R99P3S14.dta, replace
append using U99P3S14
save 99P3S14.dta, replace
end
