import flask
import os
from flask.ext.login import LoginManager
from flask_sqlalchemy import SQLAlchemy

db_host = os.getenv('MYSQL_PORT_3306_TCP_ADDR')
db_password = os.getenv('MYSQL_ENV_MYSQL_ROOT_PASSWORD')

app_rootpath = os.path.dirname(__file__)
static_folder = os.path.relpath('templates', app_rootpath)
app = flask.Flask(__name__, static_folder='templates', static_url_path='/static')
app.secret_key = 'super secret string'
app.config[
    'SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqldb://root:%s@%s/restaurant' % (db_password, db_host)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False


# print('DB_URI %s' % app.config['SQLALCHEMY_DATABASE_URI'])

login_manager = LoginManager(app)
db = SQLAlchemy(app)

login_manager.login_view = "login"
login_manager.login_message = "Hi, welcome back"
login_manager.login_message_category = "info"


from boston_restaurant import controller
from boston_restaurant.model.user import User

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(user_id)
