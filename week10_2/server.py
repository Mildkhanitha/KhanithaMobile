import pymysql
from flask import Flask, jsonify, request, render_template
from flaskext.mysql import MySQL

app = Flask(__name__)
mysql = MySQL()

# ตั้งค่าการเชื่อมต่อฐานข้อมูล [cite: 285-289]
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = '' # ถ้า XAMPP ไม่ได้ตั้งรหัสให้ปล่อยว่าง
app.config['MYSQL_DATABASE_DB'] = 'emp'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

# เพิ่มฟังก์ชันจัดการ Error กรณีข้อมูลไม่ครบ
def showMessage():
    response = jsonify('Error: ข้อมูลไม่ครบถ้วน (Bad Request)')
    response.status_code = 400
    return response

@app.route("/")
def hello():
    return """
    Flask API !<br>
    <a href='/new_user'>add</a> insert new<br>
    <a href='/emp'>emp</a> Show all<br>
    """

@app.route('/create', methods=['POST'])
def create_emp():
    conn = None
    cursor = None
    try:        
        _json = request.json
        _name = _json.get('name')
        _email = _json.get('email')
        _phone = _json.get('phone')
        _address = _json.get('address')
        _age = _json.get('age')      # แก้ไข: ใช้ .get() หรือ []
        _subject = _json.get('subject') # แก้ไข: ใช้ .get() หรือ []

        # แก้ไข: เช็คตัวแปร _age (ตัวเล็ก) ให้ตรงกับที่ประกาศไว้
        if _name and _email and _phone and _address and _age and request.method == 'POST':
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            sqlQuery = "INSERT INTO emp(name, email, phone, address, age, subject) VALUES(%s, %s, %s, %s, %s, %s)"
            bindData = (_name, _email, _phone, _address, _age, _subject)            
            cursor.execute(sqlQuery, bindData)
            conn.commit()
            return jsonify('Employee added successfully!'), 200
        else:
            return showMessage()
    except Exception as e:
        print(f"Error: {e}")
        return jsonify(str(e)), 500
    finally:
        if cursor: cursor.close() 
        if conn: conn.close()

@app.route('/emp')
def emp():
    conn = None
    cursor = None
    try:
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        # ดึงข้อมูล age และ subject มาด้วย
        cursor.execute("SELECT id, name, email, phone, address, age, subject FROM emp")
        empRows = cursor.fetchall()
        return jsonify(empRows), 200
    except Exception as e:
        print(e)
        return jsonify(str(e)), 500
    finally:
        if cursor: cursor.close() 
        if conn: conn.close()

@app.route('/update/<int:emp_id>', methods=['PUT'])
def update_emp(emp_id):
    conn = None
    cursor = None
    try:
        _json = request.json
        _name = _json.get('name')
        _email = _json.get('email')
        _phone = _json.get('phone')
        _address = _json.get('address')
        _age = _json.get('age')
        _subject = _json.get('subject')

        if _name and _email and emp_id and request.method == 'PUT':
            sqlQuery = "UPDATE emp SET name=%s, email=%s, phone=%s, address=%s, age=%s, subject=%s WHERE id=%s"
            bindData = (_name, _email, _phone, _address, _age, _subject, emp_id)
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sqlQuery, bindData)
            conn.commit()
            return jsonify('Employee updated successfully!'), 200
        else:
            return showMessage()
    except Exception as e:
        print(e)
        return jsonify(str(e)), 500
    finally:
        if cursor: cursor.close() 
        if conn: conn.close()

@app.route('/delete/<int:emp_id>', methods=['DELETE'])
def delete_emp(emp_id):
    conn = None
    cursor = None
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM emp WHERE id = %s", (emp_id,))
        conn.commit()
        return jsonify('Employee deleted successfully!'), 200
    except Exception as e:
        print(e)
        return jsonify(str(e)), 500
    finally:
        if cursor: cursor.close() 
        if conn: conn.close()

if __name__ == '__main__':
    
    app.run(host='0.0.0.0', port=5000, debug=True)