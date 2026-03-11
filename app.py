@app.route('/student')
def get_student():
    return jsonify({
        "name": "Your Name",
        "grade": 11,
        "section": "Zechariah"
    })
