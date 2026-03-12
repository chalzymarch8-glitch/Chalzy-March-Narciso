from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/')
def home():
return " Student API!"

@app.route('/student')
def get_student():
return jsonify({
"name": "Chalzy",
"grade": 10,
"section": "Firebase"
})
