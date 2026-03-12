from flask import Flask, jsonify, request, render_template_string

app = Flask(__name__)

# Sample data (temporary list for demo)
students = [
    {"id": 1, "name": "Juan", "grade": 85, "section": "Stallman"},
    {"id": 2, "name": "Maria", "grade": 90, "section": "Stallman"},
]

# Home page
@app.route('/')
def home():
    return "Welcome to the Student API! Go to /add_student_form to add a student."

# --- FORM PAGE (for browser use) ---
@app.route('/add_student_form')
def add_student_form():
    html = """
    <h2>Add New Student</h2>
    <form action="/add_student" method="POST">
        Name: <input type="text" name="name" autofocus><br><br>
        Grade: <input type="number" name="grade"><br><br>
        Section: <input type="text" name="section"><br><br>
        <input type="submit" value="Add Student">
    </form>
    """
    return render_template_string(html)

# --- ADD STUDENT (POST) ---
@app.route('/add_student', methods=['POST'])
def add_student():
    name = request.form.get("name")
    grade = int(request.form.get("grade"))
    section = request.form.get("section")
    new_id = len(students) + 1
    new_student = {
        "id": new_id,
        "name": name,
        "grade": grade,
        "section": section
    }
    students.append(new_student)
    return jsonify({
        "message": "Student added successfully!",
        "student": new_student
    })

# --- VIEW ALL STUDENTS ---
@app.route('/students', methods=['GET'])
def get_students():
    # Add pass/fail remarks dynamically
    students_with_remarks = []
    for s in students:
        remarks = "Pass" if s["grade"] >= 75 else "Fail"
        student_copy = s.copy()
        student_copy["remarks"] = remarks
        students_with_remarks.append(student_copy)
    return jsonify(students_with_remarks)

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

if __name__ == '__main__':
    app.run(debug=True)
