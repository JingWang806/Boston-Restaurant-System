from boston_restaurant import db
import sys

if len(sys.argv) < 2:
	db.create_all()
else:
	db.drop_all()