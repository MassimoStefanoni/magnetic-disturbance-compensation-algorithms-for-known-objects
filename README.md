%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Description of the content of the repository.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

This repository contains some algorithms proposed in the article "A Comparison of Neural Networks and Fuzzy Inference Systems for the Identification of Magnetic Disturbances in Mobile Robot Localization". The algorithms aim to compensate for disturbances induced by known metallic objects. The algorithms are developed in MATLAB.
Three objects were investigated and are labeled Object A, B, and C. Their data are stored in the homonym folders.
Each folder contains the following subfolders:
- *1_ANN_1_hid_lay.
- *2_ANN_2_hid_lay.
- *3_FIS.
- *4_ANFIS_11.
- *5_ANFIS_41.

where the asterisk is equal to A, B, or C.

*1_ANN_1_hid_lay FOLDERS
The *1_ANN_1_hid_lay folder contains the algorithm that exploits a single hidden layer Artificial Neural Network (ANN). The folder contains two subfolders:
- Training.
It contains the file to train the ANN and the needed input and target data.
- Net_with_XX_neurons, where XX identifies the number of neurons in the hidden layer.
After the training process, the best network is stored in such a folder and its name is "netA_XX.mat". The file to get and save the ANN is not provided.
The other stored file, which is called "output_NET_1_layer.m", tests the network by using the disturbance in the space that are stored in the Hx_.txt, Hy_.txt, and Hz_.txt files. By running the "output_NET_1_layer.m", the diagrams of the errors for each component, and the output results, which include the Mean Absolute Errors (MEAs) and MAX errors as presented in the article, are generated. Moreover, it is clarified that the diagrams of the errors are a function of the space.

*2_ANN_2_hid_lay FOLDERS
The *2_ANN_2_hid_lay folders contain the algorithm that exploits a double hidden layers ANN. The folder contains two subfolders:
- Training.
It contains the file to train the ANN and the needed input and target data.
- Net_with_XX_neurons, where XX identifies the number of neurons in the hidden layer.
After the training process, the best network is stored in such a folder and its name is "netA_XX.mat". The file to get and save the ANN is not provided.
The other stored file, which is called "output_NET_2_layer.m", tests the network by using the disturbance in the space that are stored in the Hx_.txt, Hy_.txt, and Hz_.txt files. By running the "output_NET_2_layer.m", the diagrams of the errors for each component, and the output results, which include the Mean Absolute Errors (MEAs) and MAX errors as presented in the article, are generated. Moreover, it is clarified that the diagrams of the errors are a function of the space.

*3_FIS  FOLDERS
The *3_FIS folders contain the following: file (i) FIS_Bx_negl_sys_3_gauss_1_3.fis, (ii) FIS_By_negl_sys_3_gauss_1_3.fis, (iii) FIS_Bz_negl_sys_3_gauss_1_3.fis, (iv) Hx_.txt, (v) Hy_.txt, (vi) Hz_.txt, and (vii) output_FIS.m.
The (i), (ii), and (iii) are the designed Fuzzy Inference Systems (FISs), respectively for the x, y, and z components of the magnetic disturbance; the (iv), (v), and (vi) files are the disturbances; finally, (vii) is the algorithm that tests the designed FISs and generates the diagrams of the errors as a function of the space and the output results (MAEs and MAX errors).

*4_ANFIS_11 FOLDERS
The *4_ANFIS_11 folders contain the following: file (i) ANFIS_Bx_negl_sys_triang_11.fis, (ii) ANFIS_By_negl_sys_triang_11.fis, (iii) ANFIS_Bz_negl_sys_triang_11.fis, (iv) Hx_.txt, (v) Hy_.txt, (vi) Hz_.txt, and (vii) output_ANFIS_11.m.
The (i), (ii), and (iii) are the designed Adaptive Neuro Fuzzy Inference Systems (ANFISs), respectively for the x, y, and z components of the magnetic disturbance; the (iv), (v), and (vi) files are the disturbances; finally, (vii) is the algorithm that tests the designed FISs and generates the diagrams of the errors as a function of the space and the output results (MAEs and MAX errors).


*5_ANFIS_41 FOLDERS
The *5_ANFIS_41 folders contain the following: file (i) ANFIS_Bx_negl_sys_triang_41.fis, (ii) ANFIS_By_negl_sys_triang_41.fis, (iii) ANFIS_Bz_negl_sys_triang_41.fis, (iv) Hx_.txt, (v) Hy_.txt, (vi) Hz_.txt, and (vii) output_ANFIS_41.m.
The (i), (ii), and (iii) are the designed Adaptive Neuro Fuzzy Inference Systems (ANFISs), respectively for the x, y, and z components of the magnetic disturbance; the (iv), (v), and (vi) files are the disturbances; finally, (vii) is the algorithm that tests the designed FISs and generates the diagrams of the errors as a function of the space and the output results (MAEs and MAX errors).


For any doubts or clarification, please contact me at the following email address:  massimo.stefanoni@stud.uni-obuda.hu
