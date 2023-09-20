from flask import Flask
import json
from DatabaseQuery import query
from CleanValues import createJson

app = Flask(__name__)

@app.route("/errors")
def difference():
    # query db
    tables = query('RmsLastCycle')
    # find special cases
    # make them a JSON
    data = createJson(tables, ['RmsLastCycle'])
    # return the JSON
    return data
