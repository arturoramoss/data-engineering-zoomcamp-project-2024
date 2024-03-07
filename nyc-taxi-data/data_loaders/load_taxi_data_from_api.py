import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """

    month_list = range(1,2) # change to 13
    year_list = [2019,2020]
    
    urls = [f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_{year}-{('0' + str(month))[-2:]}.csv.gz" 
        for month in month_list for year in year_list]

    taxi_dtypes = {
                    'VendorID': pd.Int64Dtype(),
                    'passenger_count': pd.Int64Dtype(),
                    'trip_distance': float,
                    'RatecodeID':pd.Int64Dtype(),
                    'store_and_fwd_flag':str,
                    'PULocationID':pd.Int64Dtype(),
                    'DOLocationID':pd.Int64Dtype(),
                    'payment_type': pd.Int64Dtype(),
                    'fare_amount': float,
                    'extra':float,
                    'mta_tax':float,
                    'tip_amount':float,
                    'tolls_amount':float,
                    'improvement_surcharge':float,
                    'total_amount':float,
                    'congestion_surcharge':float
                }
    parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

    dfs = []
    for url in urls:
        print(f"Getting {url}")
        df = pd.read_csv(url, sep=',', dtype = taxi_dtypes, compression = 'gzip', parse_dates=parse_dates)
        dfs.append(df)

    return pd.concat(dfs, axis = 0)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
