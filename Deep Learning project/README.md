🧠💻 Deep Learning for Pneumonia Detection from Chest X-Rays
This project focuses on the design, training, and evaluation of deep learning models (CNNs) for detecting pneumonia from chest X-ray images. Using a dataset of 5,863 images (healthy vs. pneumonia), we compared custom CNN architectures with Transfer Learning approaches to achieve robust medical image classification.

🔹 Main Tasks & Methods Dataset

•	Chest X-ray dataset from Kaggle (balanced train/test split)
Models

•	Custom CNN (built from scratch – baseline)

•	Transfer Learning CNN (pre-trained on MobileNetV2, fine-tuned for pneumonia detection)
Training Approaches

•	Feature extraction (frozen base)

•	Fine-tuning (partial retraining of pre-trained layers)
Optimization Algorithms Tested

•	SGD

•	SGD + Momentum

•	Adam

•	RMSprop

•	Adagrad

Regularization Techniques

•	Early Stopping

•	Dropout

•	Batch Normalization

Evaluation Metrics

•	Accuracy, Precision, Recall, F1-score

•	Confusion Matrix

•	PR curves

Extended Task

•	3-class classification: Normal / Bacterial Pneumonia / Viral Pneumonia (Softmax)

🛠 Tools & Frameworks

•	Google Colab for training and experimentation

•	Python

•	TensorFlow / Keras for model implementation

📊 Outcome
•	Achieved high accuracy (above 93% on the test set) using Transfer Learning + Fine-Tuning

•	Demonstrated practical skills in:

o	Deep learning model design

o	Model evaluation and optimization

o	Application to real-world medical imaging tasks

o	Model evaluation and optimization
o	Application to real-world medical imaging tasks
