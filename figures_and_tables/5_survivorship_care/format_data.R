format_data <- function(input_data) {
  #'Function formats the data
  #'Input: data (dataframe)
  #'Output: Returns cleaned data
  
  clean_data <-
    input_data %>% mutate(
      age_cat = relevel(factor(age_cat), ref="21-39"),
      marital_status = relevel(factor(`Marital Status`), ref="Single"),
      cancer_screening = relevel(factor(`Have you been screened for cervical cancer?`), ref="No"),
      hiv_status = relevel(factor(case_when(`Are you HIV positive?` == "Yes" ~ "Positive",
                                            `Are you HIV positive?` == "No" ~ "Negative")), ref="Negative"),
      baseline_kps_90 = relevel(factor(performance_status_cat_x), ref=">=90"),
      baseline_cr = `Creatinine (umo/L) Lab Result _x`,
      baseline_hb = `Hemoglobin (g/dl) Lab Result_x`,
      baseline_hb_10 = relevel(factor(case_when(baseline_hb <= 10 ~ "<=10",
                                                baseline_hb > 10 ~ ">10")), ref="<=10"),
      baseline_alb = `Albumin (g/dL) Lab Result _x`,
      baseline_wbc = `White Blood Count (per10^9) Lab Result_x`,
      baseline_anc = `Neutrophil Count (%,per 10^9) Lab Result_x`,
      stage_eot_exact = `End of Treatment FIGO Staging`,
      stage_eot = relevel(factor(case_when(stage_eot_exact %in% c("Stage IB1", "Stage IA2", "Stage IB2", "Stage IA1", "Stage IB3", "Stage IA") ~ "I",
                                           stage_eot_exact %in% c("Stage IIA", "Stage IIB") ~ "II",
                                           stage_eot_exact %in% c("Stage IIIB", "Stage IIIC1", "Stage IIIA") ~ "III",
                                           stage_eot_exact %in% c("Stage IVA", "Stage IVB") ~ "IV")), ref="I"),
      condensed_stage_eot = relevel(factor(case_when(stage_eot %in% c("I", "II") ~ "I-II",
                                                     stage_eot %in% c("III", "IV") ~ "III-IV")), ref="I-II"),
      trt_type = relevel(factor(`Treatment type`), ref="Curative"),
      any_chemo = relevel(factor(case_when(`Total number of chemo cycles received` %in% c("0", "nil", "no chemo", 
                                                                                          "None", "0000") ~ "0",
                                           `Total number of chemo cycles received` %in% c("4", "5", "2", "1", "3", "6", 
                                                                                          "4 cycles neoadjuvant in Serowe", 
                                                                                          "4 cycles", "7", "8") ~ ">=1")), ref="0"),
      chemo_4 = relevel(factor(case_when(`Total number of chemo cycles received` %in% c("0", "nil", "no chemo", 
                                                                                        "None", "0000", "2", "1", "3") ~ "<4",
                                         `Total number of chemo cycles received` %in% c("4", "5", "6", 
                                                                                        "4 cycles neoadjuvant in Serowe", 
                                                                                        "4 cycles", "7", "8") ~ ">=4")), ref="<4"),
      trt_response = relevel(factor(`Response to treatment`), ref="Complete response"),
      eqd2 = `What is the  EQD2 result?`,
      eqd2_75 = relevel(factor(case_when(eqd2 < 75 ~ "<75",
                                         eqd2 >= 75 ~ ">=75")), ref="<75"),
      criteria_1 = relevel(factor(criteria_1), ref="N"),
      criteria_2 = relevel(factor(criteria_2), ref="N")
    )
  
  return(clean_data)
}