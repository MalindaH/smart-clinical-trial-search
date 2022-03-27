# Smart Clinical Trial Search for Small Molecule Drugs
### Provide pharmaceutical researchers with the most up-to-date clinical trial information through molecular fingerprint similarity calculation of small molecule drugs.

This is the first ever app for clinical trial search based on [SMILES](https://en.wikipedia.org/wiki/Simplified_molecular-input_line-entry_system) molecular similarity.

## Usage instruction:
1. Open app.R in RStudio and click "Run App".

<img width="186" alt="image" src="https://user-images.githubusercontent.com/36162640/160281564-05f6ee33-5389-4de5-ad53-84bc9e86dc97.png">

2. Enter the SMILES of your drug of interest on the left and set a similarity threshold. Info of a list of clinical trials on drugs of higher molecular similarity than the threshold will show up on the right.

<img width="1440" alt="image" src="https://user-images.githubusercontent.com/36162640/160285836-278d7684-0ae1-4602-bc0f-8d8781854b95.png">

<img width="1440" alt="image" src="https://user-images.githubusercontent.com/36162640/160285857-bce2c07e-6648-4480-af63-f16b3b4a3da1.png">

<img width="1440" alt="image" src="https://user-images.githubusercontent.com/36162640/160285866-0c30cb44-e78a-4360-a51e-e7f8e6cb9c7d.png">

<img width="1439" alt="image" src="https://user-images.githubusercontent.com/36162640/160285810-437566be-c0fc-4c19-93b0-8f4c9b09506e.png">

## Project architecture

<img width="1440" alt="architecture" src="https://user-images.githubusercontent.com/36162640/160288597-90b28690-b998-46cf-bc43-2c6cf6e6ead5.png">


## Dataset sources
Clinical Trials data are from [ClinicalTrials.gov](https://clinicaltrials.gov/ct2/results?cond=&term=small+molecule&cntry=&state=&city=&dist=&Search=Search&recrs=e). Small molecule drugs data are from [DrugBank](https://go.drugbank.com/releases/latest). Molecular similarity calculations are done by [RDKit](https://www.rdkit.org/docs/GettingStartedInPython.html).


## To build the app using other datasets:
- Run [datasets_preprocessing.ipynb](https://github.com/MalindaH/smart-clinical-trial-search/blob/master/datasets_preprocessing.ipynb) to process, clean, and merge the datasets.


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
- DT 4.1.1

Developed by Malinda Huang, Mingyang Ma, and Meihan Liu at [PharmaHacks 2022](https://devpost.com/software/smart-clinical-trial-search-for-small-molecule-drugs).

