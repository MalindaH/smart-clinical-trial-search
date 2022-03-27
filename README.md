# Smart Clinical Trial Search for Small Molecule Drugs
### Provide pharmaceutical researchers with the most up-to-date clinical trial information through molecular fingerprint similarity calculation.

## Usage instruction:
1. Open app.R in RStudio and click "Run App".

<img width="186" alt="image" src="https://user-images.githubusercontent.com/36162640/160281564-05f6ee33-5389-4de5-ad53-84bc9e86dc97.png">

2. Enter the SMILES of your drug of interest on the left and set a similarity threshold. A list of clinical trials on drugs of higher molecular similarity than the threshold will show up on the right.

<img width="1438" alt="image" src="https://user-images.githubusercontent.com/36162640/160282479-043dce27-df1f-4c56-bf5a-f21e0ecfd6ec.png">

<img width="1440" alt="image" src="https://user-images.githubusercontent.com/36162640/160282710-8a246001-b288-4c10-9d21-bbc5aef32c65.png">


## Dataset sources
Clinical Trials data are from [ClinicalTrials.gov](https://clinicaltrials.gov/ct2/results?cond=&term=small+molecule&cntry=&state=&city=&dist=&Search=Search&recrs=e). Small molecule drugs data are from [DrugBank](https://go.drugbank.com/releases/latest). Molecular similarity calculations are done by [RDKit](https://www.rdkit.org/docs/GettingStartedInPython.html).


## To build the app using other datasets:
- Run [datasets_preprocessing.ipynb](https://github.com/MalindaH/smart-clinical-trial-search/blob/master/datasets_preprocessing.ipynb) to clean and merge the datasets.


### Build environment:
- Google Colab
- Python 3.9.7
- R 4.1.1
- numpy 1.22.3
- pandas 1.4.1
- rdkit 2021.9.5
- shiny 4.1.1
- shinythemes 4.1.0
- reticulate 4.1.1

Developed by Malinda Huang, Mingyang Ma, and Meihan Liu at PharmaHacks 2022.

