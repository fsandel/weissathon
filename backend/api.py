from flask import Flask
import json
from DatabaseQuery import query
from CleanValues import createJson

app = Flask(__name__)

@app.route("/errors")
def difference():
    # query db
    
    # find special cases
    # make them a JSON
    # return the JSON
    return json.dumps(createJson(), indent=2)
