from boston_restaurant import db


STYLES = ['Chinese', 'American', 'Japanese', 'Italian']


class Restaurant(db.Model):
    __tablename__ = 'restaurant'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)
    address = db.Column(db.String(100), nullable=False)
    food_style = db.Column(db.String(50))
    phone = db.Column(db.String(15))
    img_url = db.Column(db.String(256))
    menu = db.relationship('Menu', backref='restaurant', lazy='dynamic')
    reviews = db.relationship('Review', backref='restaurant')

    __table_args__ = {'mysql_engine': 'InnoDB'}

    def __init__(self, name, food_style, address, phone=None, img_url=''):
        self.name = name
        self.food_style = food_style
        self.address = address
        self.phone = phone
        self.img_url = img_url

    def __repr__(self):
        return "<Restaurant %s>" % self.name
