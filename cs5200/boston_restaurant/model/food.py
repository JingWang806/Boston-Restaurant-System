from boston_restaurant import db


class Food(db.Model):
    __tablename__ = 'food'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(140), nullable=False)
    description = db.Column(db.String(140), nullable=False)

    def __init__(self, name, description):
        self.name = name
        self.description = description
