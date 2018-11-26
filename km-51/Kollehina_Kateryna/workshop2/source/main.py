
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

user_dictionary = {
     "user_name": "Katya",
     "user_email": "katkollegina@gmail.com",
}

product_dictionary = {
     "product_name": "potato",

}

@app.route('/api/<action>', methods=['GET'])
def apiget(action):

    if action == "user":
        return render_template("user.html", user=user_dictionary)

    elif action == "product":
        return render_template("product.html", product=product_dictionary)

    elif action == "all":
        return render_template("all.html", user=user_dictionary, product=product_dictionary)

    else:
        return render_template("404.html", action_value=action, link=["user", "product"])

@app.route('/api', methods=['POST'])
def apipost():
    if request.form["action"] == "user_update":
        user_dictionary["user_name"] = request.form["name"]
        user_dictionary["user_email"] = request.form["email"]
    if request.form["action"] == "product_update":
        product_dictionary["product_name"] = request.form["product_name"]


    return redirect(url_for('apiget', action="all"))



if __name__ == '__main__':
    app.run()