# MATLAB code for LAHCMA

### This is code for paper entitled - "Feature selection for facial emotion recognition using late hill-climbing based memetic algorithm"
## Data Preparation
Four mat files need to be created:  
* train.mat - contains the data to be used for training
* trainLabel.mat - contains one hot encoded class labels for training data
* test.mat - contains the data to be used for validation
* testLabel.mat - contains one hot encoded class labels for validation data

all features to be put in _Data/data*/_ folder, where * is any number
## Parameters

The following 3 classifiers can be chosen using variable _ch_ in _classify.m_
* SVM
* MLP
* KNN

Note: SVM classifier in 'onevsall' setting, linear kernel, using SMO solver gave best results.

## Running the code
* Put all the data files in a folder name _Data/datax/_ folder, where x is any number
* Call function _maxRelMinRed(data,class,str)_ in _maxRelMinRed.m_ file - this generates the redundancy and relevance matrix to be used in LAHCRR
* run file _main\_loop.m_

Link for algorithm details: [Paper](https://link.springer.com/article/10.1007/s11042-019-07811-x)

## Abstract:

Facial Emotion Recognition (FER) is an important research domain which allows us to provide a better interactive environment between humans and computers. Some standard and popular features extracted from facial expression images include Uniform Local Binary Pattern (uLBP), Horizontal-Vertical Neighborhood Local Binary Pattern (hvnLBP), Gabor filters, Histogram of Oriented Gradients (HOG) and Pyramidal HOG (PHOG). However, these feature vectors may contain some features that are irrelevant or redundant in nature, thereby increasing the overall computational time as well as recognition error of a classification system. To counter this problem, we have proposed a new feature selection (FS) algorithm based on Late Hill Climbing and Memetic Algorithm (MA). A novel local search technique called Late Acceptance Hill Climbing through Redundancy and Relevancy (LAHCRR) has been used in this regard. It combines the concepts of Local Hill-Climbing and minimal-Redundancy Maximal-Relevance (mRMR) to form a more effective local search mechanism in MA. The algorithm is then evaluated on the said feature vectors extracted from the facial images of two popular FER datasets, namely RaFD and JAFFE. LAHCRR is used as local search in MA to form Late Hill Climbing based Memetic Algorithm (LHCMA). LHCMA is compared with state-of-the-art methods. The experimental outcomes show that the proposed FS algorithm reduces the feature dimension to a significant amount as well as increases the recognition accuracy as compared to other methods.