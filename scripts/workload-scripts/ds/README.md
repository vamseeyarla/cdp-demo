# Simple data science demo for CML

This demo creates a simple product recommender for the clickstream dataset in the data file `access.log.2`, and deploys the recommender as a CML model.

To use:

1. Run `pip install -r requirements.txt`
2. Run `create-data-frame.py` in a session. This will use Spark to create a dataframe from `acces.log.2`, and will store it in `clickstream.pkl`.
3.  Run `train-recommender.py` in a session. This will read in `clickstream.pkl` and will train a recommender model using [surprise](http://surpriselib.com/). It will save the trained model to `recommender.pkl`.
4. Create a model with script `recommender.py` and function `recommend`. Example input is `{"ip": "99.99.191.106"}` and output `{"recommendation": "The North Face Women's Recon Backpack"}`.

Once deployed, the model can be called to obtain a product recommendation for any IP address in the dataset.