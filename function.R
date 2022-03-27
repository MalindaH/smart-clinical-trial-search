library(shiny)
library(reticulate)

if(!"r-reticulate" %in% conda_list()$name){
  conda_create("r-reticulate")
  conda_install("r-reticulate", "rdkit")
  conda_install("r-reticulate", "numpy")
  conda_install("r-reticulate", "pandas")
}
use_condaenv("r-reticulate")
rdkit <- import('rdkit')
numpy <- import('numpy')
pandas <- import('pandas')

df_smiles <- pandas$read_csv('data/df_ct_completed_valid.csv')
smiles_l <- df_smiles$'SMILES'


get_df_to_display <- function(input_smiles, cutoff) {
  empty_df <- data.frame(matrix(ncol = 12, nrow = 0))
  colnames(empty_df) <- c("Similarity","Title","Interventions","Status","Conditions","SMILES","DrugBank ID","NCT Number","Phases","Gender","Age","URL")
  tryCatch(
    expr = {
      m_input <- rdkit$Chem$MolFromSmiles(input_smiles)
      fp_input <- rdkit$Chem$RDKFingerprint(m_input)
    },
    error = function(e){return(empty_df)},
    warning = function(w){},
    finally = {}
  )
  
  inds_l <- c()
  similarity_values <- c()
  for(i in 1:length(smiles_l)){
    flag <- TRUE
    smi = smiles_l[i]
    tryCatch(
      expr = {
        m = rdkit$Chem$MolFromSmiles(smi)
        fp = rdkit$Chem$RDKFingerprint(m)
        similarity = rdkit$DataStructs$FingerprintSimilarity(fp_input,fp)
        if(similarity > cutoff){
          inds_l = append(inds_l,i)
          similarity_values = append(similarity_values,similarity)
        }
      },
      error = function(e){flag<<-FALSE},
      warning = function(w){},
      finally = {}
    )
    if (!flag) next
  }
  if(is.null(similarity_values)){return(empty_df)}
  df_to_display = df_smiles[inds_l,]
  df_to_display = df_to_display[,2:dim(df_to_display)[2]]
  rownames(df_to_display) <- NULL
  df_to_display <- cbind(Similarity = similarity_values, df_to_display)
  df_to_display1 <- df_to_display[c("Similarity","Title","Interventions","Status","Conditions","SMILES","DrugBank ID","NCT Number","Phases","Gender","Age","URL")]
  return(df_to_display1)
}
