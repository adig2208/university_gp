
from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re
 
app = Flask(__name__)
app.secret_key = "secret-key"

# Configure database connection
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "1234"
app.config["MYSQL_DB"] = "university_gp"

# Initialize database connection
mysql = MySQL(app)

def password_updated(username):
  cursor = mysql.connection.cursor()
  cursor.callproc("password_update",(username,))
  result = cursor.fetchone()
  if result is None:
    return False
  else:
    return result[0]
# Define login page route
@app.route("/", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        # Get login form data
        email = request.form["email"]
        password = request.form["password"]

        # Query database for user with matching email and password
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM user WHERE username = %s AND password = %s", (email, password))
        user = cursor.fetchone()
        if user:
            # Set session ID as user ID
            session['loggedin'] = True
            session["username"] = user[1]
            session["user_id"] = user[0]
            session["user_role"] = user[3]
            if password_updated(session["username"]):
            # Map role to appropriate page
                if user[3] == "student":
                    return redirect("/student")
                elif user[3] == "professor":
                    return redirect("/professor")
                elif user[3] == "advisor":
                    return redirect("/advisor")
                elif user[3] == "club_head":
                    return redirect("/student")
            else:
                return redirect('/update-password')
        else:
            # Display error message if login credentials are invalid
            error_message = "Invalid email or password"
            return render_template("login.html", error_message=error_message)

    # Display login form
    return render_template("login.html")

@app.route('/update-password', methods=['GET', 'POST'])
def update_password():
  if request.method == 'POST':
    username = session['username']
    new_password = request.form['new_password']
    cursor = mysql.connection.cursor()
    cursor.callproc("update_password",(username,new_password))
    mysql.connection.commit()
    cursor2 = mysql.connection.cursor()
    cursor2.execute("SELECT * FROM user WHERE username = %s AND password = %s", (username, new_password))
    result = cursor2.fetchone()
    if result:
        # Set session ID as user ID
        session['loggedin'] = True
        session["user_id"] = result[0]
        session["username"] = result[1]
        session["user_role"] = result[3]
        # Map role to appropriate page
        if result[3] == "student":
            return redirect("/student")
        elif result[3] == "professor":
            return redirect("/professor")
        elif result[3] == "advisor":
            return redirect("/advisor")
        elif result[3] == "club_head":
            return redirect("/student")
  else:
    return render_template('update_password.html')

@app.route('/update_professor', methods=['POST'])
def update_professor():
    if request.method == 'POST':
        name = request.form['name']
        dob = request.form['dob']
        tenure = request.form['tenure']
        phone = request.form['phone']
        email = request.form['email']
        cursor = mysql.connection.cursor()
        print(session['user_id'])
        cursor.callproc('update_professor', (name, dob, tenure, phone, email,session['user_id']))
        mysql.connection.commit()
        # redirect the user back to their profile page
        return redirect(url_for('professor'))
    
@app.route('/update_advisor', methods=['POST'])
def update_advisor():
    if request.method == 'POST':
        name = request.form['name']
        dob = request.form['dob']
        phone = request.form['phone']
        email = request.form['email']
        cursor = mysql.connection.cursor()
        print(session['user_id'])
        cursor.callproc('update_advisor', (name, dob, phone, email,session['user_id']))
        mysql.connection.commit()
        # redirect the user back to their profile page
        return redirect(url_for('student'))
    
@app.route('/update_student', methods=['POST'])
def update_student():
    if request.method == 'POST':
        name = request.form['name']
        dob = request.form['dob']
        email = request.form['email']
        cursor = mysql.connection.cursor()
        print(session['user_id'])
        cursor.callproc('update_student', (name, dob,email,session['user_id']))
        mysql.connection.commit()
        # redirect the user back to their profile page
        return redirect(url_for('student'))
    
@app.route('/logout')
def logout():
   session.pop('loggedin', None)
   session.pop('user_id', None)
   session.pop('username', None)
   return redirect(url_for('login'))

# Define student page route
@app.route("/student")
def student():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('get_student', (session['user_id'],))
        stu = cursor.fetchone()   
        return render_template("student.html", stu = stu)
    return redirect(url_for('login'))


# Define professor page route
@app.route("/professor")
def professor():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('get_professor', (session['user_id'],))
        prof = cursor.fetchone()   
        return render_template("professor.html", prof = prof)
    return redirect(url_for('login'))


# Define advisor page route
@app.route("/advisor")
def advisor():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('get_advisor', (session['user_id'],))
        adv = cursor.fetchone()   
        return render_template("advisor.html", adv = adv)
    return redirect(url_for('login'))

#Students assigned to advisor page route 
@app.route("/advisor_students")
def advisor_students():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('get_advisor_students', (session['user_id'],))
        adv_stu = cursor.fetchall() 
        return render_template("advisor_students.html", adv_stu = adv_stu)
    return redirect(url_for('login'))


@app.route("/book_appointment")
def book_appointment():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('get_slots', (session['user_id'],))
        slot = cursor.fetchall()
        return render_template("book_appointment.html", slot = slot)
    return redirect(url_for('login'))

@app.route('/update_appointment', methods=['POST'])
def update_appointment():
    if request.method == 'POST':
        email = request.form['email']
        advisor = request.form['ad_name']
        slot = request.form['time']
        cursor = mysql.connection.cursor()
        cursor.callproc('update_appointment', (email,advisor,slot,session['user_id']))
        mysql.connection.commit()
        return redirect(url_for('book_appointment'))
    
@app.route('/view_appointment')
def view_appointment():
        cursor = mysql.connection.cursor()
        cursor.callproc('get_slot_details',(session['user_id'],))
        rows = cursor.fetchall()
        cursor.close()
        get_slot = []
        for row in rows:
            get_slot.append({
                'student_id': row[0],
                'student_name': row[1],
                'student_major': row[2],
                'student_email_id': row[3],
                'class_level': row[4],
                'grade': row[5],
                'start_time': row[6],
                'end_time': row[7],
            })
            return render_template("view_appointment.html", get_slot = get_slot)

# Define club head page route
@app.route("/club_head")
def club_head():
    return "Welcome, club head"


if __name__ == "__main__":
    app.run(debug=True)
