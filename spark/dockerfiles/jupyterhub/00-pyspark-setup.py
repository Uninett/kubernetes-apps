import os
import sys

os.environ['SPARK_HOME'] = '/opt/spark'
os.environ['SPARK_SUBMIT_CLASSPATH'] = '/usr/lib/hadoop/lib/hadoop-lzo.jar'
os.environ['SPARK_LOCAL_DIRS'] = '/tmp/spark'
os.environ['SPARK_SUBMIT_LIBRARY_PATH'] = '/usr/lib/hadoop/lib/native'
os.environ['PYTHONPATH'] = '/usr/share/spark/python/lib/py4j-0.9-src.zip:/usr/share/spark/python/:'
os.environ['SPARK_ENV_LOADED'] = '1'
os.environ['SPARK_EXECUTOR_OPTS'] = '-Djava.library.path=/usr/lib/hadoop/lib/native'
os.environ['HADOOP_HOME'] = '/usr/lib/hadoop'

spark_home = os.environ.get('SPARK_HOME', None)
sys.path.insert(0, os.path.join(spark_home, 'python'))
sys.path.insert(0, os.path.join(spark_home, 'python/lib/py4j-0.9-src.zip'))
execfile(os.path.join(spark_home, 'python/pyspark/shell.py'))
