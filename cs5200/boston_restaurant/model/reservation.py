import datetime
from boston_restaurant import db
from sqlalchemy.schema import PrimaryKeyConstraint


class Reservation(db.Model):

    """docstring for Reservation"""
    __tablename__ = 'reservation'
    submit_date = db.Column(
        db.DateTime, nullable=False, default=datetime.datetime.now())
    party_size = db.Column(db.Integer, nullable=False, default=1)
    reserve_date = db.Column(db.DateTime, nullable=False)
    user_id = db.Column(
        db.Integer, db.ForeignKey('user.id', ondelete='CASCADE'))
    restaurant_id = db.Column(
        db.Integer, db.ForeignKey('restaurant.id', ondelete='CASCADE'))

    __table_args__ = tuple(
        PrimaryKeyConstraint(user_id, restaurant_id, name='reservation_pk'))

    def __init__(self, user_id, restaurant_id, reserve_date, party_size):
        self.reserve_date = reserve_date
        self.user_id = user_id
        self.restaurant_id = restaurant_id
        self.party_size = party_size
