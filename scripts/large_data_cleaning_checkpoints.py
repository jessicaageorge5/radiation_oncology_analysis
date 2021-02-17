
# Summary: Assessing the (1) number of patients missing initial cancer stage, (2) number of patients missing final cancer stage, and (3) number of patients missing both initial and final cancer stage
# Location: large_data_cleaning.ipynb after block 5
# (1)
# Patient's initial cancer stage
initial_stage = data.groupby("patient_id")["init_cancer_stage_exact"].first().reset_index()
# Patients who are missing initial cancer stage only
missing_initial = initial_stage[initial_stage["init_cancer_stage_exact"].isnull()]
print(len(set(missing_initial["patient_id"])))
# (2)
# Patient's final cancer stage
final_stage = data.groupby("patient_id")["final_cancer_stage_exact"].last().reset_index()
# Patients who are missing final cancer stage only
missing_final = final_stage[final_stage["final_cancer_stage_exact"].isnull()]
print(len(set(missing_final["patient_id"])))
# (3)
# 34 patients who are missing both initial and final cancer stage
len(set(missing_initial["patient_id"]).intersection(set(missing_final["patient_id"])))


# Summary: Viewing all of the stages present in the data. Stage 14 and 15 not in data mapping originally (14 = IB3, 15 = IIIC1).
# Location: large_data_cleaning.ipynb after block 7
print(set(data["init_cancer_stage_exact"].dropna()))
print(set(data["final_cancer_stage_exact"].dropna()))

# Summary: Viewed number of patients with last OTV for toxicity analysis
# Location: large_data_cleaning.ipynb after block 10
len(set(data[data["last_otv"] == 1]["patient_id"])) # 910 / 948


