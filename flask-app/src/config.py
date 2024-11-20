import os

class Config:
    BASE_DIR = os.path.abspath(os.path.dirname(__file__))

    # Replace with your MySQL connection details
    MYSQL_USER = os.getenv('MYSQL_USER')
    MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD')
    MYSQL_HOST = os.getenv('MYSQL_HOST')
    MYSQL_PORT = 3306  # Default MySQL port
    MYSQL_DB = os.getenv('MYSQL_DB')

    SQLALCHEMY_DATABASE_URI = f'mysql+mysqlconnector://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}/{MYSQL_DB}'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # SQLite config
    # BASE_DIR = os.path.abspath(os.path.dirname(__file__))
    # SQLALCHEMY_DATABASE_URI = f'sqlite:///{os.path.join(BASE_DIR, "app.db")}'
    # SQLALCHEMY_TRACK_MODIFICATIONS = False
