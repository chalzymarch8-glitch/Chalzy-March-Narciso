from flask import Flask, jsonify, request

app = Flask(__name__)

# Sample student data
students = [
    {"id": 1, "name": "Juan", "grade": 85, "section": "Stallman"},
    {"id": 2, "name": "Maria", "grade": 90, "section": "Stallman"},
]

# --- LIST ALL STUDENTS ---
@app.route('/students', methods=['GET'])
def get_students():
    students_with_remarks = []
    for s in students:
        student_copy = s.copy()
        student_copy['remarks'] = "Pass" if s['grade'] >= 75 else "Fail"
        students_with_remarks.append(student_copy)
    return jsonify(students_with_remarks)

# --- GET STUDENT BY ID ---
@app.route('/student/<int:id>', methods=['GET'])
def get_student_by_id(id):
    student = next((s for s in students if s['id'] == id), None)
    if student:
        student_copy = student.copy()
        student_copy['remarks'] = "Pass" if student['grade'] >= 75 else "Fail"
        return jsonify(student_copy)
    else:
        return jsonify({"error": "Student not found"}), 404

# --- ADD NEW STUDENT ---
@app.route('/add_student', methods=['POST'])
def add_student():
    data = request.get_json()
    if not data or not all(k in data for k in ("name", "grade", "section")):
        return jsonify({"error": "Missing required student data"}), 400

    new_id = len(students) + 1
    new_student = {
        "id": new_id,
        "name": data["name"],
        "grade": data["grade"],
        "section": data["section"]
    }
    students.append(new_student)
    new_student['remarks'] = "Pass" if new_student['grade'] >= 75 else "Fail"
    return jsonify({
        "message": "Student added successfully",
        "student": new_student
    }), 201

if __name__ == '__main__':
    app.run(debug=True)

if __name__ == '__main__':
    app.run(debug=True)

