import picka
import random
from boston_restaurant.model.review import Review
from boston_restaurant.model.restaurant import Restaurant
from boston_restaurant.model.reservation import Reservation
from boston_restaurant.model.food import Food
from boston_restaurant.model.user import User
from boston_restaurant.model.menu import Menu
from boston_restaurant import db

users = []
restaurants = []
reviews = []
foods = []
menus = []
RATING_LEVELS = ['Good', 'Average', 'Bad']
MENU_TYPES = ['Brunch', 'Lunch', 'Dinner']
for i in range(5):
    user = User(nickname=picka.name(), username=picka.email(),
                password='12345', phone=picka.phone_number())
    db.session.add(user)
    users.append(user)

db.session.commit()

for line in open('food.txt'):
    parts = line.split('/')
    if len(parts) > 1:
        name, desc = parts[0], parts[1][:140]
    else:
        name, desc = parts[0], ''
    food = Food(name=name, description=desc)
    foods.append(food)


restaurants.append(Restaurant(name='Chinatown Cafe', food_style='Chinese', address='Chinatown\n262 Harrison Ave\nBoston, MA 02111', phone='(617) 695-9888', img_url='http://s3-media3.fl.yelpcdn.com/bphoto/gPrtMhL5KuLvn0NajLf8tQ/ls.jpg'))

restaurants.append(Restaurant(name='Kitchen', food_style='American', address='South End\n560 Tremont St\nBoston, MA 02118', phone='(617) 695-1250', img_url='http://s3-media2.fl.yelpcdn.com/bphoto/6VTsgAiUiIeJmSQvXq_BTg/ls.jpg'))

restaurants.append(Restaurant(name='Avana Sushi', phone='(617) 818-7782',
                             food_style='Japanese', img_url='http://s3-media2.fl.yelpcdn.com/bphoto/nAiseN_BBLZHPPG7tMYSgQ/ls.jpg', address='Chinatown\n42 Beach St\nBoston, MA 02111'))

restaurants.append(Restaurant(name='Giacomos', phone='(617) 695-1250',
                             food_style='Italian', img_url='http://s3-media4.fl.yelpcdn.com/bphoto/rOJ0wHhnrlR8LBJI0IcT8w/ls.jpg', address='Back Bay\n431 Columbus Ave\nBoston, MA 02116'))


for restaurant in restaurants:
    for _ in range(random.randint(1,6)):
        user = users[random.randint(0,len(users)-1)]
        rate = RATING_LEVELS[random.randint(0, 2)]
        restaurant.reviews.append(Review(picka.sentence(), rate, user_id=user.id))
    
    for t in MENU_TYPES:
        menu = Menu(t, restaurant.id)
        for _ in range(random.randint(5,10)):
            menu.foods.append(foods[random.randint(0,len(foods)-1)])
        restaurant.menu.append(menu)

    db.session.add(restaurant)

try:
    db.session.commit()
except Exception, e:
    db.session.rollback()
    raise e
