from flask import Flask, jsonify, request

# 1️⃣ Define the Flask app
app = Flask(__name__)

# 2️⃣ Define routes
@app.route('/')
def home():
    return "Welcome to my Flask API!"

@app.route('/student')
def get_student():
    return jsonify({
        "name": "Your Name",
        "grade": 10,
        "section": "Zechariah"
    })

# 3️⃣ Run locally (optional)
if __name__ == "__main__":
    app.run(debug=True)
