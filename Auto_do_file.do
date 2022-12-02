*PLEASE REMEMBER TO IMPORT THE DATASET WITH FIRST ROW AS VARIABLE NAMES PRIOR TO RUNNING ANALYSIS*
gen validation = 0
gen id = _n
replace validation = 1 if id > 3998
drop id
logit balanceprob age if validation==0
logit balanceprob stroke if validation==0
logit balanceprob gender if validation == 0 
logit balanceprob dementia if validation == 0 
logit balanceprob depress if validation == 0 
logit balanceprob fall if validation == 0 
logit balanceprob i.raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall if validation == 0 
fracpoly logit balanceprob age stroke gender raceth dementia depress fall if validation == 0 , compare
quietly logit balanceprob age stroke gender i.raceth dementia depress fall if validation == 0 
generate stroke_x_age= stroke * age if validation == 0 
generate stroke_x_gender= stroke * gender if validation == 0 
generate stroke_x_dementia= stroke * dementia if validation == 0 
generate stroke_x_depress= stroke * depress if validation == 0 
generate stroke_x_fall= stroke * fall if validation == 0 
generate stroke_x_raceth= stroke * raceth if validation == 0 
generate age_x_gender= age * gender if validation == 0 
generate age_x_dementia= age * dementia if validation == 0 
generate age_x_depress= age * depress if validation == 0 
generate age_x_fall= age * fall if validation == 0 
generate age_x_raceth= age * raceth if validation == 0 
generate gender_x_dementia= gender * dementia if validation == 0 
generate gender_x_depress= gender * depress if validation == 0 
generate gender_x_fall= gender * fall if validation == 0 
generate gender_x_raceth= gender * raceth if validation == 0 
generate dementia_x_depress= dementia * depress if validation == 0 
generate dementia_x_fall= dementia * fall if validation == 0 
generate dementia_x_raceth= dementia * raceth if validation == 0 
generate depress_x_fall= depress * fall if validation == 0 
generate depress_x_raceth= depress * raceth if validation == 0 
generate fall_x_raceth= fall * raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_age if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_gender if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_dementia if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_depress if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_gender if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_depress if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_dementia if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_depress if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall gender_x_raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall dementia_x_depress if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall dementia_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall dementia_x_raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall depress_x_fall if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall depress_x_raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall fall_x_raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall stroke_x_age age_x_gender age_x_dementia age_x_raceth gender_x_raceth depress_x_raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_gender age_x_dementia age_x_raceth gender_x_raceth depress_x_raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth gender_x_raceth depress_x_raceth if validation == 0 
logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth depress_x_raceth if validation == 0 
estat gof if validation == 0 , group(10) t 
lroc
predict pihat if validation == 0 
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
quietly logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth depress_x_raceth if validation == 0
calibrationbelt balanceprob pihat if validation == 0, devel("internal")
replace age_x_dementia = age * dementia if validation == 1
replace age_x_raceth  = age * raceth if validation == 1
replace depress_x_raceth = depress * raceth if validation == 1
quietly logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth depress_x_raceth if validation == 0 
predict phat, pr
calibrationbelt balanceprob phat if validation==1 , devel("external") 
quietly logit balanceprob age stroke gender i.raceth dementia depress fall age_x_dementia age_x_raceth depress_x_raceth if validation == 0 
estat gof if validation == 1, group(10) t
roccomp balanceprob phat,by(validation) graph summary



