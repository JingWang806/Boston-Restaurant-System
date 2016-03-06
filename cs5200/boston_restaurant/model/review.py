import datetime
from boston_restaurant import db


RATING_LEVELS = ['Good', 'Average', 'Bad']


class Review(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(140), nullable=False)
    post_date = db.Column(
        db.DateTime, nullable=False, default=datetime.datetime.now())
    rating = db.Column(db.String(10), nullable=False)
    retaurant_id = db.Column(
        db.Integer, db.ForeignKey('restaurant.id', ondelete='CASCADE'))
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    user = db.relationship('User')
    def __init__(self, content, rating, user_id, retaurant_id=0):
        self.content = content
        self.rating = rating
        self.user_id = user_id
        # self.restaurant_id = restaurant_id
