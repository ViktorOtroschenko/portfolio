# USAGE
# Start the server:
# 	python run_server.py
# Submit a request via cURL:
# 	curl -X POST -F image=@dog.jpg 'http://localhost:5000/predict'
# Submita a request via Python:
#	python simple_request.py

# import the necessary packages
import numpy as np
import dill
import pandas as pd
dill._dill._reverse_typemap['ClassType'] = type
#import cloudpickle
import flask

# initialize our Flask application and the model
app = flask.Flask(__name__)
model = None

def load_model(model_path):
	# load the pre-trained model
	global model
	with open(model_path, 'rb') as f:
		model = dill.load(f)

@app.route("/", methods=["GET"])
def general():
	return "Welcome to fraudelent prediction process"

@app.route("/predict", methods=["POST"])
def predict():
	# initialize the data dictionary that will be returned from the
	# view
	data = {"success": False}

	# ensure an image was properly uploaded to our endpoint
	if flask.request.method == "POST":
		title, text = "", "qq"
		request_json = flask.request.get_json()
		if request_json["title"]:
			title = request_json['title']
		if request_json["text"]:
			text = request_json['text']

		print(title)

		try:
			preds = model.predict_proba(pd.DataFrame({"title": [title],
												  "text": [text]
												  }))
		except AttributeError as e:
			logger.warning(f'{title} Exception: {str(e)}')
			data['predictions'] = str(e)
			data['success'] = False
			return flask.jsonify(data)
		data["predictions"] = preds[:, 1][0]
		data["title"] = title
		# indicate that the request was a success
		data["success"] = True
		print('Все прошло хорошо')

	# return the data dictionary as a JSON response
	return flask.jsonify(data)

# if this is the main thread of execution first load the model and
# then start the server
if __name__ == "__main__":
	print(("* Loading the model and Flask starting server..."
		"please wait until server has fully started"))
	modelpath = "models/gbc_pipeline.dill"
	load_model(modelpath)
	app.run()
