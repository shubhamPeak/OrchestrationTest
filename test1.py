from sqlalchemy import create_engine
import boto3
import os
import io



if __name__ == "__main__":
    url = "postgresql://{user}:{password}@{host}:{port}/{dbname}".format(
                  #dbname="punit_test_001",
                  dbname="elchipo",
                  user=os.getenv("REDSHIFT_USERNAME"),
                  password=os.getenv("REDSHIFT_PASSWORD"),
                  host = os.getenv("REDSHIFT_HOST"),
                  port=5439,
                  PEAK_API_KEY = os.getenv('PEAK_API_KEY')
                 )
    engine = create_engine(url)
    #engine.execute("INSERT INTO publish.q1 (firstname, email) VALUES ('name11','mail111@mail.com');")
    engine.execute("INSERT INTO publish.testqa (id ,name, email) VALUES (1,'Python1','Python1@mail.com');")
