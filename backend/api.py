from flask import Flask
import json

from CleanValues import createJson

app = Flask(__name__)

# setting API endpoint to /errors


@app.route("/errors")
def difference() -> json:

    # calling the result of the createJson function and formatting it nice
    return json.dumps(createJson(), indent=2)
