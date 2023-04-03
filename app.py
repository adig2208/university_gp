from flask import Flask, render_template, request, redirect, session
from flask_mysqldb import MySQL

app = Flask(__name__)
app.secret_key = "secret-key"

# Configure database connection
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "1234"
app.config["MYSQL_DB"] = "university_gp"

# Initialize database connection
mysql = MySQL(app)


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
            session["user_id"] = user[0]
            session["user_role"] = user[0]

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
            # Display error message if login credentials are invalid
            error_message = "Invalid email or password"
            return render_template("login.html", error_message=error_message)

    # Display login form
    return render_template("login.html")


# Define student page route
@app.route("/student")
def student():
    return "Welcome, student"


# Define professor page route
@app.route("/professor")
def professor():
    return "Welcome, professor"


# Define advisor page route
@app.route("/advisor")
def advisor():
    return "Welcome, advisor"


# Define club head page route
@app.route("/club_head")
def club_head():
    return "Welcome, club head"


if __name__ == "__main__":
    app.run(debug=True)
