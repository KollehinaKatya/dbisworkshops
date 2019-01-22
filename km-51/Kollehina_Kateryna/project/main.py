
from flask import Flask, render_template, request,  make_response, redirect, session
import pandas as pd
import cx_Oracle

from wtf.form.forms import LoginForm
from wtf.form.forms import RegForm
from auth import User
from datetime import datetime, timedelta

app = Flask(__name__)
app.secret_key = 'development key'
# @app.route('/signin', methods=['POST', 'GET'])
# def signin():
#     form = LoginForm()
#
#     if request.method == 'GET':
#         if 'email' not in session:
#             email = request.cookies.get("emailCookie")
#             if email is None:
#                 return render_template("login.html", myForm=form)
#             else:
#                 session['email'] = email
#                 return redirect('/index')
#         else:
#             return redirect('/index')
#
#     if request.method == 'POST':
#         if not form.validate():
#             return render_template("login.html", myForm=form)
#         else:
#             user = User()
#             user.__enter__()
#             var = user.sign_in(request.form['email'])
#
#             if var == 1:
#                 session['email'] = request.form["email"]
#                 response = make_response(redirect('/index'))
#
#                 expires = datetime.now()
#                 expires += timedelta(days=60)
#                 response.set_cookie('emailCookie', session['email'], expires=expires)
#                 return redirect('/index')
#                 # return response
#             else:
#                 return redirect('/registrate')

@app.route('/signin', methods=['POST', 'GET'])
def signin():
    form = LoginForm()
    err = None
    if request.method == 'GET':
        user_email = session.get('email') or request.cookies.get('emailCookie')
        if user_email:
            return redirect('/index')
        return render_template('login.html', myForm=form)

    if form.validate_on_submit():
        user = User()
        user.__enter__()
        res = user.sign_in(request.form['email'])
        print(res)
        if int(res):
            session['email'] = request.form["email"]
            response = make_response(redirect('/index'))
            expires = datetime.now() + timedelta(minutes=15)
            response.set_cookie('emailCookie', session['email'], expires=expires)
            return response
        err = 'Not correct email'
    return render_template('login.html', myForm=form, err=err)

@app.route('/registrate', methods=['GET', 'POST'])
def registrate():
    form = RegForm()

    if request.method == 'GET':
        return render_template("registrate.html", myForm=form)
    else:
        if not form.validate():
            return render_template("registrate.html", myForm=form)
        user = User()
        user.__enter__()
        status = user.sign_up( request.form['username'],
                               request.form['email'])

        if status == '200 OK':
            session['email'] = request.form["email"]
            response = make_response("logged in")

            expires = datetime.now()
            expires += timedelta(minutes=5)
            response.set_cookie('emailCookie', session['email'], expires=expires)
            return redirect('/index')
        elif status == '500 already existed':
            return redirect('/registrate')
        else:
            return redirect('/registrate')

@app.route('/index', methods=['GET', 'POST'])
def index():
    user_email = session.get('email') or request.cookies.get('emailCookie')
    if user_email:
        return render_template("index.html")
    return redirect('/signin')


@app.route('/signout', methods=['GET', 'POST'])
def signOut():
    response = make_response(redirect('/signin'))
    response.set_cookie('emailCookie', '', expires=0)
    session['email'] = None
    return response
    # return response

@app.route('/radio/<table_name>')
def show_table(table_name):
    sql = 'SELECT * from {}'.format(table_name)
    conn = cx_Oracle.connect('SYS', 'SYSTEM', cx_Oracle.makedsn('127.0.0.1', 1521, "SYS"), mode=cx_Oracle.SYSDBA)
    table = pd.read_sql_query(sql, conn)
    # table = table[['RECIPE_NAME', 'PRODUCT_NAME']]
    return render_template('show_table.html', table=table.to_html())

@app.route('/recipe_all')
def recipe_all():
    sql = 'SELECT * from recipe'
    conn = cx_Oracle.connect('SYS', 'SYSTEM', cx_Oracle.makedsn('127.0.0.1', 1521, "SYS"), mode=cx_Oracle.SYSDBA)
    table = pd.read_sql_query(sql, conn)
    table = table[['RECIPE_NAME', 'PRODUCT_NAME']]
    return render_template('show_table.html', table=table.to_html())


@app.route('/action/<action_name>')
def action(action_name):
    conn = cx_Oracle.connect('SYS', 'SYSTEM', cx_Oracle.makedsn('127.0.0.1', 1521, "SYS"), mode=cx_Oracle.SYSDBA)
    # sql = "SELECT * FROM TABLE(recipe_package.get_recipe_prod_name(''))".format(action_name)
    sql = '''
SELECT
    recipe.recipe_name,
    recipe.product_name
FROM
    recipe
    JOIN level_of_taste ON recipe.recipe_id = level_of_taste.recipe_id
WHERE
    level_of_taste.taste_name = '{}'
    '''.format(action_name)
    res = pd.read_sql_query(sql, conn)
    return render_template('show_table.html', table=res.to_html())

@app.route('/wishlist')
def wishlist():
    user_email = session.get('email') or request.cookies.get('emailCookie')
    conn = cx_Oracle.connect('SYS', 'SYSTEM', cx_Oracle.makedsn('127.0.0.1', 1521, "SYS"), mode=cx_Oracle.SYSDBA)
    sql = '''
SELECT
    recipe.recipe_name,
    recipe.product_name
FROM
    wishlist
    JOIN recipe ON wishlist.recipe_id = recipe.recipe_id
WHERE
    wishlist.user_email = '{}'
    '''.format(user_email)
    res = pd.read_sql_query(sql, conn)
    return render_template('show_table.html', table=res.to_html())


if __name__ == '__main__':
    app.run(port=8080, debug=True)