from flask import Flask
import json
from DatabaseQuery import query

app = Flask(__name__)

@app.route("/difference")
def difference():
    # query db
    tables = query('CycleCount')
    # find special cases
    # make them a JSON
    data = json.dumps(tables['CycleCount'])
    # return the JSON
    return data
