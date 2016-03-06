import flask
from datetime import date
from flask import request, session
from boston_restaurant import app, db
from boston_restaurant.model.restaurant import Restaurant
from boston_restaurant.model.menu import Menu
from boston_restaurant.model.user import User
from boston_restaurant.model.review import Review, RATING_LEVELS
from boston_restaurant.model.reservation import Reservation
from flask_wtf import Form
from wtforms import StringField, PasswordField, SelectField, IntegerField
from wtforms.validators import DataRequired, NumberRange, Length
from sqlalchemy.sql import or_ as OR
from flask.ext.login import login_required, current_user, logout_user, login_user


class LoginForm(Form):

    """docstring for LoginForm"""
    username = StringField('username', validators=[DataRequired()])
    password = PasswordField('password', validators=[DataRequired()])

class ChangePwdForm(Form):
    """docstring for LoginForm"""
    password = PasswordField('password', validators=[DataRequired()])

class RegisterForm(Form):

    """docstring for LoginForm"""
    username = StringField('username', validators=[DataRequired()])
    password = PasswordField('password', validators=[DataRequired()])
    nickname = StringField('nickname', validators=[DataRequired()])
    phone = StringField('phone', validators=[DataRequired()])


class ReviewForm(Form):
    """docstring for LoginForm"""
    content = StringField('content', validators=[DataRequired()])
    rating = SelectField('rating', choices=RATING_LEVELS, validators=[DataRequired()])


class ReservationForm(Form):
    """docstring for LoginForm"""
    SIZE =['1','2','3','4']
    date = StringField('date', validators=[DataRequired()])
    size = SelectField('size', choices=SIZE, validators=[DataRequired()])

SUCCESS_ALERT = 'success'
FAILURE_ALERT = 'danger'

# General Routing Rules
@app.route('/')
def show_home_page():
    # TODO: retrieve top 5 restaurants and inflate the page.
    restaurants = Restaurant.query.filter_by().limit(4).all()
    return flask.render_template('index.html', restaurants=restaurants)


@app.route('/login', methods=['GET', 'POST'])
def login():
    # Here we use a class of some kind to represent and validate our
    # client-side form data. For example, WTForms is a library that will
    # handle this for us, and we use a custom LoginForm to validate.
    form = LoginForm()
    next_url = request.args.get('next')
    if next_url:
        session['next'] = next_url
    if form.validate_on_submit():
        # Login and validate the user.
        # user should be an instance of your `User` class
        username = form.username.data
        password = form.password.data
        user = User.query.filter_by(
            username=username, password=User.hash_password(password)).first()
        if not user:
            flask.flash('Username/password incorrect!', category=FAILURE_ALERT)
            return flask.render_template('login.html', form=form)

        login_user(user)
        next_url = session.pop('next', '/')
        
        flask.flash('Logged in successfully.', category=SUCCESS_ALERT)

        return flask.redirect(next_url)
    return flask.render_template('login.html', form=form)


@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegisterForm()

    if form.validate_on_submit():
        # Login and validate the user.
        # user should be an instance of your `User` class
        username = form.username.data
        password = form.password.data
        phone = form.phone.data
        nickname = form.nickname.data
        user = User(
            nickname=nickname, username=username, password=password, phone=phone)
        try:
            db.session.add(user)
            db.session.commit()
        except Exception, e:
            flask.flash(e, FAILURE_ALERT)
            return flask.render_template('register.html', form=form)

        login_user(user)
        flask.flash('Registered successfully.', SUCCESS_ALERT)

        return flask.redirect(flask.url_for('show_home_page'))
    return flask.render_template('register.html', form=form)


@app.route('/logout')
@login_required
def logout():
    logout_user()
    flask.flash('Logout', SUCCESS_ALERT)
    return flask.render_template('index.html')


@app.route('/search')
def search():
    query = request.args.get('search')
    criteria = OR(Restaurant.name.contains(query), Restaurant.food_style.contains(query.capitalize()))
    result = Restaurant.query.filter(criteria).all()
    
    return flask.render_template('searchresult.html', result=result)


# Restaurant Routing Rules


@app.route('/restaurants/<int:r_id>')
def restaurant_info(r_id):
    restaurant = Restaurant.query.get(r_id)
    if not restaurant:
        flask.abort(404)
    # print(restaurant.reviews[0].user)
    return flask.render_template('restaurant-home.html', restaurant=restaurant)


@app.route('/restaurants/<int:r_id>/reviews', methods=['POST'])
@login_required
def restaurant_reviews(r_id):
    restaurant = Restaurant.query.get(r_id)
    form = ReviewForm()

    if request.method == 'POST':
        content = form.content.data
        rating = form.rating.data
        restaurant.reviews.append(Review(content, rating, current_user.id))
        db.session.add(restaurant)
        db.session.commit()
    return flask.render_template('restaurant-home.html', restaurant=restaurant)


@app.route('/restaurants/<int:r_id>/reserve', methods=['POST', 'GET'])
@login_required
def reserve(r_id):
    form = ReservationForm()
    restaurant = Restaurant.query.get(r_id)
    reservation = Reservation.query.get((current_user.id, r_id))

    if request.method == 'POST':
        y,m,d = map(int, form.date.data.split('-'))
        reserve_date = date(y, m, d)
        size = int(form.size.data)
        reservation = Reservation(current_user.id, restaurant.id, reserve_date, size)
        db.session.add(reservation)
        db.session.commit()
        # flask.flash('Reserved successfully.', SUCCESS_ALERT)
    return flask.render_template('restaurant-reservation.html', restaurant=restaurant, reservation=reservation)


@app.route('/restaurants/<int:r_id>/cancel-reservation')
@login_required
def cancel_reservation(r_id):
    restaurant = Restaurant.query.get(r_id)
    reservation = Reservation.query.get((current_user.id, r_id))
    db.session.delete(reservation)
    db.session.commit()
    return flask.render_template('restaurant-reservation.html', restaurant=restaurant, reservation=None)


@app.route('/restaurants/<int:r_id>/menu/<int:m_id>')
def show_menu(r_id, m_id):
    restaurant = Restaurant.query.get(r_id)
    menu = Menu.query.get(m_id)
    return flask.render_template('restaurant-menu.html', menu=menu, restaurant=restaurant)


@app.route('/change-password', methods=['POST', 'GET'])
@login_required
def change_password():
    form = ChangePwdForm()
    if form.validate_on_submit():
        new_password = form.password.data
        current_user.password = User.hash_password(new_password)
        db.session.add(current_user)
        db.session.commit()
        return flask.redirect(flask.url_for('show_home_page'))
    return flask.render_template('changepassword.html', form=form)


@app.route('/favorites', methods=['GET'])
@login_required
def my_favorites():
    r_id = request.args.get('restaurant', -1)
    restaurant = Restaurant.query.get(r_id)
    if restaurant:
        current_user.favorites.append(restaurant)
        try:
            db.session.commit()
        except Exception, e:
            print(e)
            db.session.rollback()
            flask.flash('Cannot add this restaurant to favorites. Try again.', category=FAILURE_ALERT)
            return flask.redirect(flask.url_for('restaurant_info', r_id=r_id))
        flask.flash('Added to your favorites.', category=SUCCESS_ALERT)
    restaurants = current_user.favorites
    return flask.render_template('likes.html', restaurants=restaurants)


@app.route('/add-to-favorites/<int:r_id>')
@login_required
def add_to_favorites(r_id):
    restaurant = Restaurant.query.get(r_id)
    if not restaurant:
        flask.abort(404)
    current_user.favorites.append(restaurant)
    db.session.add(current_user)
    db.session.commit()
    return flask.render_template('restaurant-home.html', restaurant=restaurant)

@app.route('/remove-from-favorites/<int:r_id>')
@login_required
def remove_from_favorites(r_id):
    restaurant = Restaurant.query.get(r_id)
    if not restaurant:
        flask.abort(404)
    current_user.favorites.remove(restaurant)
    db.session.add(current_user)
    db.session.commit()
    return flask.render_template('restaurant-home.html', restaurant=restaurant)