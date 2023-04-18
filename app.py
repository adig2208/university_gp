 
from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re
import json
 
app = Flask(__name__)
app.secret_key = "secret-key"

# Configure database connection
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "Vader@07"
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
                elif user[3] == "professor" or "dept_head":
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


@app.route("/my_booking")
def my_booking():
    cursor = mysql.connection.cursor()
    cursor.callproc('get_booking',(session['user_id'],))
    rows = cursor.fetchall()
    cursor.close()
    book = []
    for row in rows:
        book.append({
            'appointment_id': row[0],
            'start_time': row[1],
            'end_time': row[2],
            'staff_name': row[3],
            'staff_email_id': row[4],
        })
    return render_template("my_booking.html", book = book)
    
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
        print(session['user_role'])
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
        print(adv)  
        return render_template("advisor.html", adv = adv)
    return redirect(url_for('login'))

# Define professor page route
@app.route("/club")
def club():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('get_clubs')
        club = cursor.fetchall()    
        return render_template("club.html", club = club)
    return redirect(url_for('login'))

@app.route('/delete_club', methods=['POST'])
def delete_club():
    if request.method == 'POST':
        cursor = mysql.connection.cursor()
        user = session['user_id']
        cursor.callproc('delete_club', (session['user_id'],))
        mysql.connection.commit()
        # redirect the user back to their profile page
        return redirect(url_for('club'))

@app.route('/update_club', methods=['POST'])
def update_club():
    if request.method == 'POST':
        name = request.form['name']
        print(name)
        cursor = mysql.connection.cursor()
        user = session['user_id']
        cursor.callproc('fill_participants', (int(user),name))
        mysql.connection.commit()
        # redirect the user back to their profile page
        return redirect(url_for('club'))
    

#Students assigned to advisor page route 
@app.route("/advisor_students")
def advisor_students():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('get_advisor_students', (session['user_id'],))
        adv_stu = cursor.fetchall() 
        return render_template("advisor_students.html", adv_stu = adv_stu)
    return redirect(url_for('login'))

@app.route("/my_club")
def my_club():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('my_clubs', (session['user_id'],))
        my_club = cursor.fetchone()
        return render_template("my_club.html", my_club = my_club)
    return redirect(url_for('login'))

@app.route("/club_home")
def club_home():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('my_clubs',(session['user_id'],))
        my_club = cursor.fetchone()
        cursor.nextset()  # Advance to next result set
        cursor2 = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor2.callproc('get_building')
        build = cursor2.fetchall()
        cursor.close()
        cursor2.close()
        return render_template("club_home.html", my_club=my_club, build=build)
    return redirect(url_for('login'))

@app.route('/get_rooms', methods=['POST'])
def get_rooms():
    building_id = request.form['building_id']
    print(building_id)
    conn = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    conn.callproc('get_rooms',(building_id,))
    rooms = conn.fetchall()
    room_numbers = [room['room_number'] for room in rooms]
    return {'room_numbers': room_numbers}

@app.route('/create_events', methods=['POST'])
def create_events():
    if request.method == 'POST':
        name = request.form['name']
        event_name = request.form['event_name']
        event_description = request.form['event_description']
        event_date = request.form['event_date']
        start_time = request.form['start_time']
        end_time = request.form['end_time']
        building_name = request.form['building']
        room_number = request.form['room_number']
        cursor = mysql.connection.cursor()
        cursor.callproc('create_event', (name,event_name,event_description,event_date,start_time,end_time,building_name,room_number))
        mysql.connection.commit()
        return redirect(url_for('club_home'))

@app.route('/club_events', methods=['GET','POST'])
def club_events():
    if request.method == 'POST':
        name = request.form['name']
        cursor = mysql.connection.cursor()
        cursor.callproc('club_events',(name,))
        rows = cursor.fetchall()
        cursor.close()
        get_events = []
        for row in rows:
            get_events.append({
                'event_name': row[0],
                'event_description': row[1],
                'event_date': row[2],
                'start_time': row[3],
                'end_time': row[4],
                'room_number': row[5],
                'room_capacity': row[6],
                'building_name': row[7],
            })
        print(get_events)
        return render_template("club_events.html", get_events = get_events)

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
            print(row)
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
        print(get_slot)
        return render_template("view_appointment.html", get_slot = get_slot)

@app.route('/course')
def course():
        cursor = mysql.connection.cursor()
        cursor.callproc('get_course_details',(session['user_id'],))
        rows = cursor.fetchall()
        cursor.close()
        get_details = []
        for row in rows:
            get_details.append({
                'student_major': row[0],
                'course_name': row[1],
                'section_number': row[2],
                'course_description': row[3],
                'course_credits': row[4],
                'building_name': row[5],
                'staff_name': row[6],
                'room_number': row[7],
            })
        cursor2 = mysql.connection.cursor()
        cursor2.callproc('get_all_courses')
        rows2 = cursor2.fetchall()
        cursor2.close()
        get_det = []
        for row in rows2:
            get_det.append({
                'course_name': row[0],
                'section_number': row[1],
                'course_description': row[2],
                'course_credits': row[3],
                'building_name': row[4],
                'staff_name': row[5],
                'room_number': row[6],
            })
        return render_template("course.html", get_details = get_details,get_det =get_det)



@app.route("/professor_courses")
def professor_courses():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('view_courses', (session['username'],))
        prof_course = cursor.fetchall()
        return render_template('professor_courses.html',prof_course=prof_course)
    return redirect(url_for('login'))

@app.route("/enrolled_students",methods=['GET','POST'])
def enrolled_students():
    if 'loggedin' in session:
        if request.method=='POST':
            cursor = mysql.connection.cursor()
            cursor.callproc("update_grade",(request.form['grade'],request.form['student_id']))
            mysql.connection.commit()
        course_id = int(request.args.get('course_id'))
        section_id = int(request.args.get('section_id'))
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('view_students', (course_id,section_id))
        view_students = cursor.fetchall()
        return render_template('enrolled_students.html',data=view_students)
    return redirect(url_for('login'))

@app.route('/view_professors')
def view_professors():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('view_professors', (session['username'],))
        view_professors = cursor.fetchall()
        return render_template('view_professors.html',data=view_professors)
    return redirect(url_for('login'))

@app.route('/add_courses',methods=['GET','POST'])
def add_courses():
    if 'loggedin' in session:
        if request.method=='POST':
            cursor = mysql.connection.cursor()
            cursor.callproc("add_courses",(session['username'],request.form['name'],request.form['description'],request.form['credits']))
            mysql.connection.commit()
        return render_template('add_courses.html')
    return redirect(url_for('login'))

@app.route('/course_statistics')
def course_statistics():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('view_courses', (session['username'],))
        prof_course = cursor.fetchall()
        return render_template('course_statistics.html',prof_course=prof_course)
    return redirect(url_for('login'))

@app.route('/statistics')
def statistics():
    if 'loggedin' in session:
        course_id = int(request.args.get('course_id'))
        section_id = int(request.args.get('section_id'))
        course_name = request.args.get('course_name')
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.callproc('get_grade_statistics', (course_id,section_id))
        statistics = cursor.fetchall()
        output = []
        for d in statistics:
            rounded_value = round(d['y'])
            output.append({'label':d['label'],'y': rounded_value})
        return render_template('statistics.html',data=output,course_name=course_name)
    return redirect(url_for('login'))
if __name__ == "__main__":
    app.run(debug=True)
