from rdkit import Chem
from rdkit import DataStructs
import pandas as pd

def find_similar_clinical_ids(input_similes = 'COC1=C(OCCCN2CCOCC2)C=C2C(NC3=CC(Cl)=C(F)C=C3)=NC=NC2=C1', cutoff = 0.6):
    # print(input_similes, cutoff)
    
    ### from the client's input ###
    try:
        m_input = Chem.MolFromSmiles(input_similes)
        fp_input = Chem.RDKFingerprint(m_input)
    except:
        print('Sorry, this is not a valid SMILES for us to process')
        return -1

    ### from the presaved dataset ###
    df_smiles = pd.read_csv('data/df_ct_completed.csv')
    smiles_l = list(df_smiles['SMILES'].to_numpy())
    
    inds_l = []
    inds_invalid = []
    #ms = [Chem.MolFromSmiles('CCOC'), Chem.MolFromSmiles('CCO'), Chem.MolFromSmiles('COC')]
    for i, smi in enumerate(smiles_l):
        try:
            m = Chem.MolFromSmiles(smi)
            fp = Chem.RDKFingerprint(m)
            similarity = DataStructs.FingerprintSimilarity(fp_input,fp)
            if similarity > cutoff:
                inds_l.append(i)
        except:
            inds_invalid.append(i)
            continue
    #np.save('inds_invalid',np.array(inds_invalid))
    # print('Number of related clinical trial instances:', len(inds_l))
    df_to_display = df_smiles.iloc[inds_l]
    df_valid = df_smiles.drop(index=inds_invalid)
    print(df_smiles)
    return df_to_display, df_valid
    # df_to_display.to_csv('df_to_display.csv', index = False)
    # print('CSV generated successfully')
    
df_to_display, df_valid = find_similar_clinical_ids()
print(df_valid)
df_valid.to_csv('data/df_ct_completed_valid.csv', index=False)