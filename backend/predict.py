import pickle
import numpy as np

def predict(data):
    with open('scaler_pickle.pkl', 'rb') as scaler_file:
        loaded_scaler = pickle.load(scaler_file)

    with open('model_pickle', 'rb') as model_file:
        loaded_classifier = pickle.load(model_file)

    input_data = data

    input_data_as_numpy_array = np.asarray(input_data)
    input_data_reshaped = input_data_as_numpy_array.reshape(1, -1)
    std_data = loaded_scaler.transform(input_data_reshaped)

    prediction = loaded_classifier.predict(std_data)

    probabilities = loaded_classifier.predict_proba(std_data)

    probabilities = loaded_classifier.predict_proba(std_data)
    probability_non_diabetes = probabilities[0][0] * 100  
    probability_diabetes = probabilities[0][1] * 100 

    return prediction[0], probability_non_diabetes, probability_diabetes