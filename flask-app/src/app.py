from flask import Flask, render_template, request, redirect, url_for
import mysql.connector
from models import db, Item
import config

app = Flask(__name__)
app.config.from_object(config.Config)  # Use the Config class from config.py
db.init_app(app)

# Create the database if it doesn't exist
def create_database():
    try:
        # Establish a raw connection to MySQL (without specifying a database)
        connection = mysql.connector.connect(
            host=config.Config.MYSQL_HOST,
            user=config.Config.MYSQL_USER,
            password=config.Config.MYSQL_PASSWORD
        )
        
        cursor = connection.cursor()
        # Escape the database name to handle special characters like hyphens
        database_name = f"`{config.Config.MYSQL_DB}`"
        # Execute the CREATE DATABASE statement
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS {database_name}")
        cursor.close()
        connection.close()
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        # Optionally log the error or handle it as needed


# Ensure the database exists before initializing the app
create_database()

# Use `with app.app_context()` to create tables
with app.app_context():
    db.create_all()

# Home Page: Display All Items
@app.route('/')
def index():
    # Check if the database connection is working and fetch items
    try:
        # Query all items in the database
        items = Item.query.all()
        return render_template('index.html', items=items)
    except Exception as e:
        return f"Database connection failed: {str(e)}"

# Create: Add a New Item
@app.route('/add', methods=['GET', 'POST'])
def add_item():
    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']
        new_item = Item(title=title, content=content)
        db.session.add(new_item)
        db.session.commit()
        return redirect(url_for('index'))
    return render_template('add.html')

# Read: View Item Details
@app.route('/item/<int:id>')
def view_item(id):
    item = Item.query.get_or_404(id)
    return render_template('view.html', item=item)

# Update: Edit an Existing Item
@app.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit_item(id):
    item = Item.query.get_or_404(id)
    if request.method == 'POST':
        item.title = request.form['title']
        item.content = request.form['content']
        db.session.commit()
        return redirect(url_for('index'))
    return render_template('edit.html', item=item)

# Delete: Remove an Item
@app.route('/delete/<int:id>')
def delete_item(id):
    item = Item.query.get_or_404(id)
    db.session.delete(item)
    db.session.commit()
    return redirect(url_for('index'))

@app.route('/health', methods=['GET'])
def health_check():
    return "Healthy", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
