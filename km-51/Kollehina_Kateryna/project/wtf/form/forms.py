from flask import Flask, render_template, request, flash
from flask_wtf import FlaskForm
from wtforms import TextField, StringField, IntegerField, TextAreaField, SubmitField, RadioField, SelectField
from flask import Flask, render_template, request, flash
from wtforms import validators, ValidationError

class LoginForm(FlaskForm):
    email = StringField("Email: ", validators=[validators.DataRequired('Required'), validators.Email("Wrong format")])
    submit = SubmitField("Log in")


class RegForm(FlaskForm):
    username = StringField("Name", [validators.DataRequired("Please enter your name.")])

    email = StringField("Email", [validators.DataRequired("Enter valid email address"), validators.Email("Wrong format")])
   
    submit = SubmitField("OK")


def create_select_form(items_list):
    class MyClass(FlaskForm):
        item = SelectField
