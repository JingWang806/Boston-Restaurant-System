from boston_restaurant import db
from boston_restaurant.model.food import Food


MENU_TYPES = ['Brunch', 'Lunch', 'Dinner']


foods = db.Table('foods',
                 db.Column('food_id', db.Integer, db.ForeignKey('food.id')),
                 db.Column('menu_id', db.Integer, db.ForeignKey('menu.id'))
                 )


class Menu(db.Model):
    __tablename__ = 'menu'
    id = db.Column(db.Integer, primary_key=True)
    menu_type = db.Column(db.String(50), nullable=False)
    retaurant_id = db.Column(db.Integer, db.ForeignKey('restaurant.id', ondelete='CASCADE'))
    foods = db.relationship('Food', secondary=foods)

    def __init__(self, menu_type, restaurant_id):
        self.menu_type = menu_type
        self.restaurant_id = restaurant_id
