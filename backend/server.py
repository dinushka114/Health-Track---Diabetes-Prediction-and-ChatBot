from flask import Flask, request, jsonify
from predict import predict
from chatbot.chat_rag import ask  

app = Flask(__name__)

@app.route('/predict', methods=['GET'])
def process_number():
    pregnancies = request.args.get('pregnancies', type=float)
    glucose = request.args.get('glucose', type=float)
    blood_pressure = request.args.get('blood_pressure', type=float)
    skin_thickness = request.args.get('skin_thickness', type=float)
    insulin = request.args.get('insulin', type=float)
    bmi = request.args.get('bmi', type=float)
    dpf = request.args.get('dpf', type=float)
    age = request.args.get('age', type=float)

    input_data = (pregnancies, glucose, blood_pressure, skin_thickness, insulin, bmi, dpf, age)
    is_diabetes, probability_non_diabetes, probability_diabetes = predict(input_data)

    return jsonify({
        "status": int(is_diabetes),
        "prob_non_d": probability_non_diabetes,
        "prob_d": probability_diabetes
    })

@app.route('/ask', methods=['POST'])
def handle_ask(): 
    query = request.form.get('query')

    if not query:
        return jsonify({"error": "Missing query parameter"}), 400

    try:
        response = ask(query) 
        return jsonify({"response": response})
    except Exception as e:
        return jsonify({"error": f"Failed to process query: {str(e)}"}), 500

if __name__ == '__main__':
    app.run(debug=True)
