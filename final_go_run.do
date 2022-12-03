*PLEASE REMEMBER TO IMPORT THE DATASET WITH FIRST ROW AS VARIABLE NAMES PRIOR TO RUNNING ANALYSIS*

*GENERATION OF INTERNAL AND EXTERNAL DATA*
gen validation = 0
gen id = _n
replace validation = 1 if id > 3997
drop id

*GENERATION OF DUMMY VARIABLES FOR INTERACTION TERMS*
gen raceth_1 = 1 if raceth==1
replace raceth_1 = 0 if raceth_1!=1
gen raceth_2 = 1 if raceth==2
replace raceth_2 = 0 if raceth_2!=1
gen raceth_3 = 1 if raceth==3
replace raceth_3 = 0 if raceth_3!=1

*UNIVARIATE MODEL TESTING OF VARIABLES*
logit balanceprob age if validation==0
logit balanceprob stroke if validation==0
logit balanceprob gender if validation == 0 
logit balanceprob dementia if validation == 0 
logit balanceprob depress if validation == 0 
logit balanceprob fall if validation == 0 
logit balanceprob i.raceth if validation == 0

*MULTIVARIABLE MODEL TESTING*
logit balanceprob age stroke gender i.raceth dementia depress fall if validation == 0 

*LINEARITY TESTING OF AGE*
fracpoly logit balanceprob age stroke gender raceth dementia depress fall if validation == 0 , compare

*GENERATION OF ALL POSSIBLE INTERACTION TERMS*
generate stroke_x_age= stroke * age if validation == 0 
generate stroke_x_gender= stroke * gender if validation == 0 
generate stroke_x_dementia= stroke * dementia if validation == 0 
generate stroke_x_depress= stroke * depress if validation == 0 
generate stroke_x_fall= stroke * fall if validation == 0 
generate stroke_x_raceth_1= stroke*raceth_1 if validation == 0
generate stroke_x_raceth_2= stroke*raceth_2 if validation == 0 
generate stroke_x_raceth_3= stroke*raceth_3 if validation == 0 
generate age_x_gender= age * gender if validation == 0 
generate age_x_dementia= age * dementia if validation == 0 
generate age_x_depress= age * depress if validation == 0 
generate age_x_fall= age * fall if validation == 0 
generate age_x_raceth_1= age * raceth_1 if validation == 0 
generate age_x_raceth_2= age * raceth_2 if validation == 0 
generate age_x_raceth_3= age * raceth_3 if validation == 0 
generate gender_x_dementia= gender * dementia if validation == 0 
generate gender_x_depress= gender * depress if validation == 0 
generate gender_x_fall= gender * fall if validation == 0 
generate gender_x_raceth_1= gender * raceth_1 if validation == 0 
generate gender_x_raceth_2= gender * raceth_2 if validation == 0 
generate gender_x_raceth_3= gender * raceth_3 if validation == 0 
generate dementia_x_depress= dementia * depress if validation == 0 
generate dementia_x_fall= dementia * fall if validation == 0 
generate dementia_x_raceth_1= dementia * raceth_1 if validation == 0 
generate dementia_x_raceth_2= dementia * raceth_2 if validation == 0 
generate dementia_x_raceth_3= dementia * raceth_3 if validation == 0 
generate depress_x_fall= depress * fall if validation == 0 
generate depress_x_raceth_1= depress * raceth_1 if validation == 0 
generate depress_x_raceth_2= depress * raceth_2 if validation == 0 
generate depress_x_raceth_3= depress * raceth_3 if validation == 0 
generate fall_x_raceth_1= fall * raceth_1 if validation == 0
generate fall_x_raceth_2= fall * raceth_2 if validation == 0 
generate fall_x_raceth_3= fall * raceth_3 if validation == 0

*TESTING OF INDIVIDUAL INTERACTION TERMS INTO MULTIVARABLE MODEL (KEEPING >0.2)*
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_age if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_gender if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_dementia if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_depress if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_raceth_1 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_raceth_2 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_raceth_3 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_gender if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_depress if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_raceth_1 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_raceth_2 if validation == 0
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_raceth_3 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_dementia if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_depress if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_raceth_1 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_raceth_2 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_raceth_3 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall dementia_x_depress if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall dementia_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall dementia_x_raceth_1 if validation == 0
logit balanceprob age stroke gender i.raceth dementia depress fall dementia_x_raceth_2 if validation == 0
logit balanceprob age stroke gender i.raceth dementia depress fall dementia_x_raceth_3 if validation == 0
logit balanceprob age stroke gender i.raceth dementia depress fall depress_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall depress_x_raceth_1 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall depress_x_raceth_2 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall depress_x_raceth_3 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall fall_x_raceth_1 if validation == 0
logit balanceprob age stroke gender i.raceth dementia depress fall fall_x_raceth_2 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall fall_x_raceth_3 if validation == 0

*TESTING OF INTERACTION TERMS INTO MULTIVARABLE MODEL (KEEPING >0.05)*
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_depress age_x_raceth_2 gender_x_raceth_3 dementia_x_raceth_3 depress_x_raceth_1 depress_x_raceth_3 fall_x_raceth_3 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_depress age_x_raceth_2 gender_x_raceth_3 dementia_x_raceth_3 depress_x_raceth_1 depress_x_raceth_3 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth_2 dementia_x_raceth_3 depress_x_raceth_1 depress_x_raceth_3 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth_2 depress_x_raceth_3 depress_x_raceth_1 if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth_2 depress_x_raceth_3 if validation == 0 

*TESTING GOODNESS OF FIT FOR INTERNAL DATA*
estat gof if validation == 0 , group(10) t 
lroc

*TESTING FOR HIGHLY INFULENTAL VARIABLES*
predict h, h
if validation == 0 twoway (scatter h pihat, mlabel(spid))
predict dx2, dx2
twoway (scatter dx2 pihat, mlabel(spid))
predict db, db
twoway (scatter db pihat, mlabel(spid))
scatter dx2 pihat [w=db]
egen h_rank = rank(h)
sort h_rank 
l spid h h_rank if h_rank <= 10, sepby(h_rank)
egen dx2_rank = rank(dx2)
sort dx2_rank 
l spid h dx2_rank if dx2_rank <= 10, sepby(dx2_rank)
egen db_rank = rank(db)
sort db_rank 
l spid h db_rank if db_rank <= 10, sepby(db_rank)

*HIGH LEVERAGE VALUE POINT REMOVED FOR >20% CHANGE IN BETAS*
drop if spid==10005882

*RETESTING GOODNESS OF FIT FOR INTERNAL DATA FOLLOWING DROPPED VARIABLE*
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth_2 depress_x_raceth_3 if validation == 0 
predict pihat if validation == 0 
estat gof if validation == 0 , group(10) t 
lroc

*TESTING CALIBRATION OF INTERNAL DATA*
quietly logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth_2 depress_x_raceth_3 if validation == 0  
calibrationbelt balanceprob pihat if validation == 0, devel("internal")

*GENERATION OF INTERACTION TERMS AND PREDICTION FOR EXTERNAL VALIDATION DATASET*
replace age_x_dementia = age * dementia if validation == 1
replace age_x_raceth_2  = age * raceth_2 if validation == 1
replace depress_x_raceth_3 = depress * raceth_3 if validation == 1
quietly logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth_2 depress_x_raceth_3 if validation == 0 
predict phat, pr

*TESTING CALIBRATION AND GOODNESS OF FIT FOR EXTERNAL DATA*
calibrationbelt balanceprob phat if validation==1 , devel("external") 
quietly logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth_2 depress_x_raceth_3 if validation == 0 
estat gof if validation == 1, group(10) t

*COMPARISON OF ROC DATA BETWEEN *
roccomp balanceprob phat,by(validation) graph summary
 