import json

def createJson(allValues: dict, measurements: list) -> json:
  return json.dumps(allValues[measurements[0]][1], indent=2)
