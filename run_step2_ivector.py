import kaldi_ivector as ivector
import numpy as np
M=4
num_gselect=5
ivector_dim=100
modeldir="models/extractor_8k"

#ivector.train('mfcc_hires/raw_mfcc_test.1.scp',modeldir,M,ivector_dim,num_gselect)
ivectors,keys=ivector.extract(modeldir+"/extractor", 'mfcc_hires/raw_mfcc_test.1.scp','ivectors_kaldi',num_gselect)

n=len(keys)
for i in range(n):
    np.savetxt("ivectors/"+keys[i]+".csv",np.array(ivectors[i]))
    '''
    fw=open("ivectors/"+keys[i]+".txt",'w')
    #fw.write(keys[i]+".wav"+'\n')
    fw.write(str(ivectors[i])+'\n')
    fw.close()
    '''

print("all ok, see result in ivectors/*.csv")
