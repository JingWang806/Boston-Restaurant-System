from hashlib import sha256
from boston_restaurant import db
from boston_restaurant.model.review import Review
from flask.ext.login import UserMixin

favorites = db.Table('favorites',
                     db.Column(
                         'user_id', db.Integer, db.ForeignKey('user.id')),
                     db.Column('restaurant_id', db.Integer, db.ForeignKey('restaurant.id')))


class User(db.Model, UserMixin):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(120), unique=True, nullable=False)
    nickname = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(64), nullable=False)
    phone = db.Column(db.String(15))
    favorites = db.relationship('Restaurant', secondary=favorites)
    # reviews = db.relationship('Review', backref='user', lazy='dynamic')

    def __init__(self, nickname, username, password, phone=None):
        self.username = username
        self.nickname = nickname
        self.password = self.hash_password(password)
        self.phone = phone

    def __repr__(self):
        return "<User %s>" % self.username

    def is_authenticated(self):
        return True

    def is_active(self):
        return True

    def is_anonymous(self):
        return False

    def get_id(self):
        return self.id

    @staticmethod
    def hash_password(password):
        return sha256(password.encode()).hexdigest()