# --- VIEW SINGLE STUDENT WITH PASS/FAIL ---
@app.route('/student')
def get_student():
    # Get grade from query parameter (default = 0)
    grade = int(request.args.get('grade', 0))
    
    # Determine pass or fail
    remarks = "Pass" if grade >= 75 else "Fail"
    
    return jsonify({
        "name": "Juan",
        "grade": grade,
        "section": "Zechariah",
        "remarks": remarks
    })
